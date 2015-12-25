#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'largest_series_product'

# Rubocop directives
# rubocop:disable Style/AlignParameters:
#
class Seriestest < Minitest::Test
  def test_largest_product_of_a_tiny_number
    series = Series.new('12')
    assert_equal 2, series.largest_product(2)
  end

  def test_another_tiny_number
    series = Series.new('19')
    assert_equal 9, series.largest_product(2)
  end

  def test_largest_product_of_2
    skip
    series = Series.new('0123456789')
    assert_equal 72, series.largest_product(2),
      'Largest product of all sets of 2 result from 8 and 9'
  end

  def test_largest_product_of_2_shuffled
    skip
    series = Series.new('576802143')
    assert_equal 48, series.largest_product(2),
      'Largest product of all sets of 2 result from 6 and 8'
  end

  def test_largest_product_of_3
    skip
    series = Series.new('0123456789')
    assert_equal 504, series.largest_product(3)
  end

  def test_largest_product_of_3_shuffled
    skip
    series = Series.new('1027839564')
    assert_equal 270, series.largest_product(3)
  end

  def test_largest_product_of_5
    skip
    series = Series.new('0123456789')
    assert_equal 15_120, series.largest_product(5)
  end

  def test_some_big_number
    skip
    s = '73167176531330624919225119674426574742355349194934'
    series = Series.new(s)
    assert_equal 23_520, series.largest_product(6)
  end

  def test_some_other_big_number
    skip
    s = '52677741234314237566414902593461595376319419139427'
    series = Series.new(s)
    assert_equal 28_350, series.largest_product(6)
  end

  def test_identity
    skip
    series = Series.new('')
    assert_equal 1, series.largest_product(0),
      'Identity of an empty group is 1'
  end

  def test_slices_bigger_than_number
    skip
    series = Series.new('123')
    assert_raises ArgumentError do
      series.largest_product(4)
    end
  end
end
