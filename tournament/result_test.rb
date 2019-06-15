require 'minitest/autorun'
require 'minitest/pride'
require_relative 'result'

class ResultTest < Minitest::Test
  # .from_raw
  def test_it_creates_a_result_for_each_team
    raw = "Allegoric Alaskans;Blithering Badgers;win"

    results = Result.from_raw(raw)

    assert_equal results.length, 2
    assert results.all? { |result| result.is_a? Result }
    assert(results.find { |result| result.team == "Allegoric Alaskans" })

    result = results.find { |result| result.team == "Allegoric Alaskans" }
    assert_equal result.result, "win"

    result = results.find { |result| result.team == "Blithering Badgers" }
    assert_equal result.result, "loss"
  end
end