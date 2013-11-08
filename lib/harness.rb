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

  def to_radians
    self * Math::PI / 180
  end
end

class Coords
  attr_accessor :x, :y, :z

  def initialize(x, y, z)
    self.x = x
    self.y = y
    self.z = z
  end

  def to_s
    "{x: #{self.x}, y: #{self.y}, z: #{self.z}}"
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
    # calculate distance
    # total distance traveled = speed * time
    # ground distance traveled = total_distance * cos(angle)

    total_dist = total_dist_traveled(@harness_animal.land_speed, duration)
    ground_dist = calculate_adjacent(total_dist, @harness_animal.angle).floor
    x = calculate_adjacent(ground_dist, @harness_animal.direction).floor
    y = calculate_opposite(ground_dist, @harness_animal.direction).floor
    z = calculate_adjacent(total_dist, @harness_animal.angle).floor
    @harness_animal.coords = Coords.new x, y, z
  end

  def total_dist_traveled(speed, time)
    speed * time
  end

  def calculate_adjacent(hyp, angle)
    hyp * Math::cos(angle.to_radians)
  end

  def calculate_opposite(hyp, angle)
    hyp * Math::sin(angle.to_radians)
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
    attr_accessor :flying, :direction, :angle, :land_speed, :duration, :coords

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
      self.land_speed = s
    end
  end
end
