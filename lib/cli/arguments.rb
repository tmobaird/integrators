module Integrator
  module Cli
    class Arguments
      include Enumerable

      attr_reader :variables

      def initialize(args)
        @args = args
        @variables = new_hash
        parse
      end

      def new_hash
        Hash.new { |h, k| h[k] = new_hash }
      end

      def each(&block)
        @args.each do |arg|
          block.call arg
        end
      end

      def at(index)
        @args[index]
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

      private

      def parse
        @args.filter { |arg| arg.is_a? Cli::Field }.each do |arg|
          if arg.name.include?(".")
            parts = arg.name.split(".")
            deep_set(variables, parts, arg.value)
          end
        end
      end

      def deep_set(hash, keys, value)
        last_key = keys.pop
        current = hash
        keys.each do |key|
          current = current[key]
        end

        current[last_key] = value
      end
    end
  end
end
