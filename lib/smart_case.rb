class SmartCase
  def initialize(o = nil)
    @o, @when, @then = o, [], []
    instance_eval(&Proc.new) if block_given?
    self
  end

  def w(proc = nil) @when << (proc || Proc.new) end
  def t(proc = nil) @then << (proc || Proc.new) end 

  def call(o = nil, multi: nil)
    raise ArgumentError unless @when.size == @then.size

    if multi
      result = @when.zip(@then).map do |w, t|
        w.call(o || @o) ? t.call(o || @o) : nil
      end
      return result
    else
      @when.zip(@then).each do |w, t|
        return t.call(o || @o) if w.call(o || @o)
      end
    end

    return nil
  end
end

def smart_case(o, multi: nil, &block)
  SmartCase.new(o, &block).call(multi: multi)
end