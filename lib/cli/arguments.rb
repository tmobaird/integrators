module Integrator
  class Cli::Arguments
    include Enumerable

    def initialize(args)
      @args = args
    end

    def each(&block)
      @args.each do |arg|
        block.call arg
      end
    end

    def [](key)
      val = if key.is_a? Symbol
        @args.find { |arg| arg.is_a?(Cli::Field) && arg.name.to_sym == key }
      else
        @args[key]
      end

      return val.value if val.is_a? Cli::Field
      val
    end

    def to_a
      output = []
      @args.each do |arg|
        if arg.is_a? Cli::Field
          output.push "#{arg.name}=#{arg.value}"
        else
          output.push arg
        end
      end
      output
    end
  end
end
