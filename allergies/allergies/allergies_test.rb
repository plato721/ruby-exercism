require 'minitest/autorun'
require 'minitest/pride'
require './allergies.rb'

class AllergiesTest < Minitest::Test
  def setup
    @all = ["cats", "pollen", "chocolate", "tomatoes", "strawberries", "shellfish",
      "peanuts", "eggs"]
    @tester = Allergies.new(255)
  end

  def test_255_returns_all_allergies
    tester = Allergies.new(255)

    assert_equal tester.allergies_for, @all
  end

  def test_34_returns_choco_and_peanuts
    tester = Allergies.new(34)

    assert tester.allergies_for.include?("chocolate")
    assert tester.allergies_for.include?("peanuts")
  end

  def test_3_eggs_and_peanuts
    tester = Allergies.new(3)

    assert tester.allergies_for.include?("eggs")
    assert tester.allergies_for.include?("peanuts")
  end

  def test_128_returns_cat
    assert @tester.allergies_for(128).include?("cats")
  end

  def test_224_returns_cats_pol_choco
    expected = ["cats", "pollen", "chocolate"]
    assert_equal @tester.allergies_for(224), expected
  end



end