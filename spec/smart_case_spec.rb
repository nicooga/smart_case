require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SmartCase do
  it 'succeeds' do
    c = SmartCase.new(2) do
      w { |x| x == 2 }
      t { 'Your number is 2!' }

      w { |x| x == 3 }
      t { 'Your number is 3!' }
    end

    expect(c.call).to eq('Your number is 2!')
    expect(c.call(3)).to eq('Your number is 3!')
  end

  it 'accepts procs' do
    c = SmartCase.new(2) do
      w ->(x) { x == 2 }
      t ->(x) { 'Your number is 2!' }

      w ->(x) { x == 3 }
      t ->(x) { 'Your number is 3!' }
    end

    expect(c.call).to eq('Your number is 2!')
    expect(c.call(3)).to eq('Your number is 3!')
  end

  it 'integrates into Kernel' do
    1.upto(100) do |x|
      expect(smart_case(x) do
        w { |o| o == x }
        t { "Your number is #{x}!" }

        w { |o| o == 3 }
        t { "Your number is #{x+1}!" }
      end).to eq("Your number is #{x}!")
    end
  end

  it 'should fail with bad syntax' do
    expect do
      smart_case(Object.new) do
        w { |o| o == x }
        t { "Your number is #{x}!" }

        w { |o| o == 3 }
      end
    end.to raise_error(ArgumentError)
  end

  it 'should have a multlipart feature' do
    sm = smart_case(10, multi: true) do
      w { |x| x == 10 }
      t { 'Your number is 10!' }

      w { |x| x < 100 }
      t { 'Your number is lesser than 100!' }
    end

    expect(sm).to eq(['Your number is 10!', 'Your number is lesser than 100!'])
  end
end