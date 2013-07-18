class SmartCase
  def initialize(o)
    @o, @when, @then = o, [], []
    instance_eval(&Proc.new) if block_given?
    self
  end

  def w(proc = nil) @when << (proc || Proc.new) end
  def t(proc = nil) @then << (proc || Proc.new) end

  def call(o = nil)
    @when.zip(@then).each do |w, t|
      return t.call(o || @o) if w.call(o || @o)
    end
    return nil
  end
end

def smart_case(o)
  SmartCase.new(o, &Proc.new).call
end