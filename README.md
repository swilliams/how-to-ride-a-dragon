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
  fly do
    ascend 200 feet
    move forward 50 feet
    land
  end
end
```
