class CubaLIbre
  def self.define(&block)
    @block = block
  end

  def self.run(argv=nil)
    @path = []
    @argv = (argv || ARGV).dup

    instance_eval(&@block)
  end

  def self.consume(pattern)
    action = @argv.shift

    return false unless action

    @path << action

    match = action.match(/\A#{pattern}\z/)

    return false unless match

    @captures.push(*match.captures)

    true
  end

  def self.match(matcher)
    case matcher
    when String then consume(matcher)
    when Regexp then consume(matcher)
    when Symbol then consume(matcher)
    when Proc   then matcher.call
    else
      matcher
    end
  end

  def self.on(*args, &block)
    try do
      @captures = []

      return unless args.all?{ |arg| match(arg) }

      yield(*@captures)

      exit 0
    end
  end

  def self.try
    argv = @argv.dup
    yield
  ensure
    @argv = argv
  end

  def self._param(name)
    argv = @argv.dup
    argv << nil if argv.size.odd?
    Hash[*argv][name]
  end

  def self.param(name)
    lambda { _param(name).tap { |val| @captures << val if val } }
  end

  def self.bool(name)
    @captures << true if @argv.include?(name)
    true
  end

  def self.plugin(mixin)
    extend mixin
  end

  def self.argv
    @argv
  end

  def self.default; true end
end
