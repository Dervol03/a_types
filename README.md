# ATypes (Advanced Data Types)

This gem provides some convenience methods to Ruby's basic data types which 
are not present in ActiveSupport and especially offers some valuable Boolean 
interpretation to Ruby's data types.

The gem comes in two flavors:
  - core extensions, for those who prefer the handier addition of methods and
    are sure they won't collide with others in their projects.
  - decorators, for those who prefer to use the decorator pattern and prefer 
    to be really prudent about possible collisions in their project (i.e. 
    because they already use ActiveSupport and don't to risk it on version 
    updates)

You may also load both flavors, if you like, they don't collide.

## Why another gem for advanced types?

While this gem has been inspired by others, like the [boolean 
gem](https://rubygems.org/gems/boolean), these gems either have not been 
updated for a very long time, don't go far enough or simply don't behave 
really consistent in what they try to achieve.

Additionally, they often only provide logic for a single data type, which 
tends to bloat one's Gemfile. Therefore, this gem unites different ideas, but
 allow you to only load what you really want to use. See the [only take what 
 you need](#only-take-what-you-need) section.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'a_types'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install a_types

## Only take what you need

Similar to ActiveSupport, you won't get anything from simply requiring the 
gem in your code.

```ruby
  require 'a_types'
```

You have to specify which parts you wish to include in your project. Let's 
assume you prefer the core extensions, then you may use following lines:

```ruby

  require 'a_types/core_ext/boolean'      # => loads Boolean extensions
  require 'a_types/core_ext/enumerable'   # => loads Enumarable extensions
  require 'a_types/core_ext/all'          # => loads all core extentions
```

You are more the decorator kind? This gem has exactly what you want:

```ruby

  require 'a_types/decorators/boolean'    # => loads ATypes::Boolean decorator
  require 'a_types/decorators/array'      # => loads ATypes::Array decorator
  require 'a_types/decorators/all'        # => loads all available decorators
```

You may also simply load everything in the gem, getting the core extension 
AND the decorators:

```ruby
  require 'a_types/all'
```  
    
    
Feel free to browse the list of files which you may require on the [project's 
homepage](https://github.com/Dervol03/a_types/tree/master/lib).

You may also find the documentation of each file there or on [rubygems.org]
(https://rubygems.org/gems/a_types).


## Examples

### Core extension

Loading the boolean extension will provide a `#to_bool` to any object.

```ruby

  require 'a_types/core_ext/boolean'
  
  'yes'.to_bool             # => true
  'not positive'.to_bool!   # => false
  -1.to_bool                # => false
   3.to_bool                # => true
```
   
### Decorators
   
Loading the boolean decorator instead will provide a `Boolean` decorator 
class, providing an interpretation of truth to any provided object without 
changing it.

```ruby
   
  require 'a_types/decorators/boolean'
  
  b = ATypes::Boolean.new('yes')
  b.content       # => 'yes'
  b.to_bool       # => true
  b.true?         # => true
  b.truthy?       # => true
  
  b2 = ATypes::Boolean.new('false')
  b2.to_bool      # => false
  b2.true?        # => falsse
  b3.truthy?      # => true
  b2.falsey?      # => false   
  
  bnil = ATypes::Boolean.new(nil)
  bnil.to_bool    # => false
  bnil.true?      # => false
  bnil.truthy?    # => false
  bnil.falsey?    # => true
    
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Dervol03/a_types.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

