require "cocoapods"
require "cocoapods-core"
require_relative "LocalModuleManager"

module Pod
  class Podfile
    module DSL
      def local_source(*paths)
        paths.each do |path|
          LocalModuleManager.addLocalPath(path)
        end
      end
    end
  end
end

module Pod
  class Dependency
    alias_method :real_initialize, :initialize

    def initialize(name = nil, *requirements)
      # adds requirement hash if it's not present
      requirements << {} unless requirements.last.is_a?(Hash)

      pathComponents = name.split("/")
      baseName = pathComponents[0]

      if LocalModuleManager.all_modules[baseName].present?
        localModule = LocalModuleManager.all_modules[baseName]
        # remove version requirement, if local
        requirements = requirements[1..-1] unless requirements.first.is_a?(Hash)
        # add path to local dependency
        requirements.last[:path] = localModule.module_path
      end

      real_initialize(name, *requirements)
    end
  end
end

module Pod
  class Installer
    class Analyzer
      def allDependenciesFor(name, localModules = LocalModuleManager.all_modules)
        if LocalModuleManager.resolved?(name)
          # if the local dependency has already been resolved, we don't need to resolve the dependencies again.
          return []
        end

        pathComponents = name.split("/")
        baseName = pathComponents[0]
        importingSubspec = pathComponents.length > 1

        localModule = localModules[baseName]

        podspec = nil
        # Position in the modules directory to generate the subspecs correctly
        Dir.chdir(localModule.module_path) do
          podspec = eval File.read("#{baseName}.podspec")
        end

        # Use the subspec if we're importing it
        if importingSubspec
          podspec = podspec.subspec_by_name(name)
        end

        # Get all local dependencies of the spec/subspec
        allDependencies = podspec.all_dependencies.select { |d| LocalModuleManager.local?(d.name) }

        # Get other dependencies recursively
        allDependencies.each do |dependency|
          allDependencies += allDependenciesFor(dependency.name, localModules)
        end

        LocalModuleManager.set_resolved(name)
        return allDependencies.uniq
      end

      alias_method :real_dependencies_to_fetch, :dependencies_to_fetch

      def dependencies_to_fetch(podfile_state)
        real_dependencies_to_fetch(podfile_state)

        resolvedLocalDependencies = @deps_to_fetch.map do |key, value|
          allDependenciesFor(key.name)
        end.flatten.uniq

        @deps_to_fetch = (@deps_to_fetch | resolvedLocalDependencies).uniq
      end
    end
  end
end
