require 'pry'
require 'pry-nav'
module Harness
  def harness options, &block
    trainer = options[:trainer]
    animal  = options[:animal]

    trainer.send(:extend, Harness::InstanceMethods)
    trainer.harness animal
  end

  module InstanceMethods
    attr_accessor :animal_harnessed

    def harnessed? animal
      self.animal_harnessed == animal
    end

    def harness animal
      self.animal_harnessed = animal
    end
  end
end
