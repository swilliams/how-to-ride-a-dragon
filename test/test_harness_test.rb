require 'spec_helper'

class HarnessTest < Test::Unit::TestCase
  include Harness

  def setup
    @dragon = Dragon.new
    @person = Person.new
  end

  # Dragons may or may not have been harmed in the production of this DSL.
  # People most certainly were.
  def test_person_harness_dragon
    # Assert a raise here on person.harnessed
    harness trainer: @person, animal: @dragon do; end
    assert @person.harnessed?(@dragon)
  end

  def test_person_flies_dragon
    harness trainer: @person, animal: @dragon do
      fly do; end
    end
    assert @dragon.flying?
  end

  def test_dragon_moves_laterally
    harness trainer: @person, animal: @dragon do
      fly do
        course 45
      end
    end
    assert_equal 45, @dragon.direction
  end

  def test_dragon_moves_laterally_and_vertically
    harness trainer: @person, animal: @dragon do
      fly do
        course 45
        mark 20
      end
    end
    assert_equal 45, @dragon.direction
    assert_equal 20, @dragon.angle
  end

  def test_dragon_moves_over_time
    harness trainer: @person, animal: @dragon do
      fly 10.seconds do
        course 45
        mark 20
        speed 100
      end
    end


  end

  def test_dragon_descends
  end

  def test_dragon_moves_forward
  end

  def test_dragon_lands
  end

  def test_dragon_has_beards_of_experience
    # expect dragon to eat a person if it has beards of experience
  end
end
