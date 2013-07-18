require 'smart_case'
require 'benchmark'

Benchmark.bmbm do |x|
  n = rand(1..100)

  x.report('traditional case') do
    1000.times do
      case n
      when 1..33 then 'Your number is between 1 and 33'
      when 33..66 then 'Your number is between 33 and 66'
      when 66..100 then 'Your number is between 66 and 100'
      end
    end
  end

  x.report('smart_case') do
    1000.times do
      smart_case n do
        w { |x| (1..33) === x }
        t { 'Your number is between 1 and 33' }

        w { |x| (33..66) === x }
        t { 'Your number is between 33 and 66' }

        w { |x| (66..100) === x }
        t { 'Your number is between 66 and 100' }
      end
    end
  end
end