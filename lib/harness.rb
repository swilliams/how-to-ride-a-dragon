require 'pry'
require 'pry-nav'

# should probably move this to another class, but whatevs
class Fixnum
  def seconds
    self
  end

  def minutes
    self * 60
  end
end

module Harness
  def harness options, &block
    @harness_trainer = options[:trainer]
    @harness_animal  = options[:animal]

    @harness_trainer.send(:extend, Harness::PersonInstanceMethods)
    @harness_animal.send(:extend, Harness::AnimalInstanceMethods)

    @harness_trainer.harness @harness_animal, &block
  end

  def fly(duration = 1.minutes, &block)
    @harness_animal.fly(duration, &block)
  end

  module PersonInstanceMethods
    attr_accessor :animal_harnessed

    def harnessed? animal
      self.animal_harnessed == animal
    end

    def harness animal, &block
      self.animal_harnessed = animal
      yield block
    end
  end

  module AnimalInstanceMethods
    attr_accessor :flying, :direction, :angle, :speed, :duration

    def flying?
      self.flying
    end

    def fly(duration, &block)
      self.duration = duration
      self.flying = true
      instance_eval(&block)
    end

    def course(direction)
      self.direction = direction
    end

    def mark(angle)
      self.angle = angle
    end

    def speed(s)
      self.speed = s
    end
  end
end
