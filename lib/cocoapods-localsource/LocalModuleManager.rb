require "cocoapods-core"

class LocalModuleManager
  @@all_modules = {}
  @@resolved_modules = {}

  def self.all_modules
    @@all_modules
  end

  def self.set_resolved(name)
    @@resolved_modules[name] = true
  end

  def self.resolved?(name)
    @@resolved_modules.key?(name)
  end

  def self.addLocalPath(path)
    dependencies = findLocalModules(path)

    dependencies.each do |key, value|
      existingModule = @@all_modules[value.name]
      raise "Duplicate local module definition for #{value.name} at #{path}. Already defined here: #{existingModule.module_podspec_path}" unless existingModule.nil?
      @@all_modules[key] = value
    end
  end

  def self.local?(name)
    !@@all_modules[name].nil?
  end

  def self.findLocalModules(path)
    modules = {}
    Dir.chdir(path) do
      podspec_paths = Dir["*/*.podspec"]

      podspec_paths.each do |p|
        pathComponents = p.split("/")
        moduleName = pathComponents[1].split(".podspec")[0]
        foundModule = LocalModule.new(path, pathComponents[0], moduleName)

        modules[moduleName] = foundModule
      end
    end

    return modules
  end

  def self.clear
    @@all_modules = {}
  end
end

class LocalModule
  def initialize(modulesPath, root, name)
    @modules_path = modulesPath
    @root = root
    @name = name
  end

  attr_reader :modules_path
  attr_reader :root
  attr_reader :name

  def module_path
    "#{@modules_path}/#{@root}"
  end

  def module_podspec_path
    "#{@modules_path}/#{@root}/#{@name}.podspec"
  end
end
