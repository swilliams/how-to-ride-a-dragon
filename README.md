How to Ride a Dragon
====================

A dsl harness for riding a dragon

Testing
-------

``` sh
rake test
```

Using
-----

``` ruby
class Dragon
end

class Person
end

harness trainer: @person, animal: @dragon do
  fly 10.seconds do
    course 45
    mark 20
    speed 100
  end



  burn village

  land
end
```
