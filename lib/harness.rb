require 'pry'
require 'pry-nav'
module Harness
  def harness options, &block
    @harness_trainer = options[:trainer]
    @harness_animal  = options[:animal]

    @harness_trainer.send(:extend, Harness::PersonInstanceMethods)
    @harness_animal.send(:extend, Harness::AnimalInstanceMethods)

    @harness_trainer.harness @harness_animal, &block
  end

  def fly
    @harness_animal.fly
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
    attr_accessor :flying

    def flying?
      self.flying
    end

    def fly
      self.flying = true
    end
  end
end
