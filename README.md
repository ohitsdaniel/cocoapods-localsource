**cocoapods-localsource** allows to import local development pods without specifying a path.

## Installation 
```bash
 $ gem install cocoapods-localsource
```

## Usage 
In your apps `Podfile`, require the gem and define the local module directory by passing the path to `local_source`. 

```ruby 
  require 'cocoapods-localsource'

  local_source './LocalModules'

  target 'LocalModulesExample' do
    pod 'Cool' # local development, no longer requires a defined :path
  end
```

## Benefits over using a Spec Repository
Using this cocoapods plugin allows us to keep all our source code in one central repository while keeping the benefits of a modularized app architecture. As all local dependencies are imported as development pods, engineers can edit source code without having to unlock the files.

## Example project

An example project can be found [here](https://github.com/ohitsdaniel/cocoapods-localsource-example). 
