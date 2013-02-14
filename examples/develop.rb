require_relative '../lib/linepipe'
require 'minitest/autorun'

class DevelopTest < MiniTest::Unit::TestCase
  def linepipe
    @linepipe ||= Linepipe.develop do
      data {
        %w(foo bar baz)
      }

      step("Upcasing") { |data|
        data.map(&:upcase)
      }

      step("Reversing") { |data|
        data.reverse
      }

      step("Sorting") { |data|
        data.sort
      }

      expect { |data|
        data == %w(BAR BAZ FOO)
      }
    end
  end

  def test_upcasing
    assert_equal %w(A B), linepipe['Upcasing'].apply(%w(a b))
  end

  def test_reversing
    assert_equal %w(b a), linepipe['Reversing'].apply(%w(a b))
  end

  def test_sorting
    assert_equal %w(a b c), linepipe['Sorting'].apply(%w(c a b))
  end
end
