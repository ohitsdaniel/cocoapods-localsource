require "minitest/autorun"
require_relative "../lib/cocoapods-localsource/LocalModuleManager.rb"

class LocalModuleManagerTest < Minitest::Test
  def setup
    LocalModuleManager.clear
  end

  def test_startsWithEmpty_allModules
    assert_equal LocalModuleManager.all_modules, {}
  end

  def test_addsModuleA_asLocalModule
    expectedModule = LocalModule.new("TestModules", "A", "A")

    LocalModuleManager.addLocalPath("TestModules")

    assert_equal LocalModuleManager.all_modules["A"], expectedModule
  end

  def test_ModuleB_DoesNotExist
    LocalModuleManager.addLocalPath("TestModules")

    assert_nil LocalModuleManager.all_modules["B"]
  end

  def test_A_isUnresolved
    LocalModuleManager.addLocalPath("TestModules")

    refute LocalModuleManager.resolved?("A")
  end

  def test_set_resolved_asresolved
    LocalModuleManager.addLocalPath("TestModules")

    LocalModuleManager.set_resolved("A")

    assert LocalModuleManager.resolved?("A")
  end

  def test_A_isLocal
    LocalModuleManager.addLocalPath("TestModules")

    assert LocalModuleManager.local?("A")
  end

  def test_B_isNotLocal
    LocalModuleManager.addLocalPath("TestModules")

    refute LocalModuleManager.local?("B")
  end

  def test_raises_addingDuplicatePath
    LocalModuleManager.addLocalPath("TestModules")

    assert_raises ("") { LocalModuleManager.addLocalPath("TestModules") }
  end

  def test_addLocalPath_addsToLocalPaths
    LocalModuleManager.addLocalPath("TestModules")

    assert_includes LocalModuleManager.local_paths, "TestModules"
  end

  def test_raises_addingDuplicateModule
    LocalModuleManager.addLocalPath("TestModules")

    assert_raises ("") { LocalModuleManager.addLocalPath("TestModules_Copy") }
  end

  def test_clear_removesAllModules
    LocalModuleManager.addLocalPath("TestModules")

    LocalModuleManager.clear

    assert_equal LocalModuleManager.all_modules, {}
  end

  def test_clear_clearsAllModules
    LocalModuleManager.addLocalPath("TestModules")

    LocalModuleManager.clear

    assert_equal LocalModuleManager.all_modules, {}
  end

  def test_clear_clearsResolvedModules
    LocalModuleManager.addLocalPath("TestModules")

    LocalModuleManager.clear

    assert_equal LocalModuleManager.resolved_modules, {}
  end

  def test_clear_clearsAllModules
    LocalModuleManager.addLocalPath("TestModules")

    LocalModuleManager.clear

    assert_equal LocalModuleManager.all_modules, {}
  end

  def test_clear_clearsLocalPaths
    LocalModuleManager.addLocalPath("TestModules")

    LocalModuleManager.clear

    assert_equal LocalModuleManager.local_paths, []
  end
end
