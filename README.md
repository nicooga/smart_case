smart_case
==========
A while ago came up with the idea that it would be cool if ruby `case` statements accepted blocks for the condition evaluation. `SmartCase` is the result.

### Installation [![Gem Version](https://badge.fury.io/rb/smart_case.png)](http://badge.fury.io/rb/smart_case)

```bash
$ gem install smart_case
```

### Usage

```ruby
require 'smart_case'

age = gets.chomp.to_i
smart_case(age) do
  w { |x| x < 20 }
  t { 'You are a teenager.' }

  w { |x| x >= 20 && x < 30 }
  t { 'You are a young adult' }

  w { |x| x >= 30 && x < 60 }
  t { |x| "You are an adult of age #{x}" } # Object is accesible via arguments 

  w { |x| x > 60 }
  t ->(x) { 'You are an aged adult' } # `w` and `t` accepts any callable object instead of a block
end
=> "You are an adult of age 47"
```

You can use an instance of `SmartCase` too:

```ruby
sm = SmartCase.new(nil) do # object is optional
  w { |x| x == 2 }
  t { 'Your number is 2!' }

  w { |x| x == 3 }
  t { 'Your number is 3!' }
end

sm.call 2
=> "Your number is 2!"
sm.call 3
=> "Your number is 3!"
sm.call 4
=> nil

# Add conditional clauses on the fly
sm.w { |x| x == 4 }
sm.t { 'Your number is 4!' }
sm.call 4
=> "Your number is 4!"

# or...
sm.instance_eval do
  w { |x| x == 5 }
  t { 'Your number is 5!' }
  call 5
end
=> "Your number is 5!"
```
Pass `multi: true` option to get an array of results, instead of breaking execution when an `w` statement evaluates to `true`:

```ruby
smart_case(10, multi: true) do
  w { |x| x == 10 }
  t { 'Your number is 10!' }

  w { |x| x < 100 }
  t { 'Your number is lesser than 100!' }
end
=> ["Your number is 10!", "Your number is lesser than 100!"]
```

### Contributing to smart_case
+ Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
+ Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
+ Fork the project.
+ Start a feature/bugfix branch.
+ Commit and push until you are happy with your contribution.
+ Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
+ Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright
Copyright (c) 2013 Nicolas Oga. See LICENSE.txt for
further details.
