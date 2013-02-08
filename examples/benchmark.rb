require_relative '../lib/linepipe'

Linepipe.benchmark(100_000) do
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
    data == %w(BAZ BAR FOO)
  }
end