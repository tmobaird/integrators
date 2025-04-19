module Integrator
  module Cli
    class Runner
      def initialize(argv)
        @argv = argv
      end

      def run
        parser = CommandParser.new
        Integrator::REGISTERED.each do |config|
          parser.on_cmd(config[:name], config[:description]) do |args|
            api_parser = CommandParser.new(config[:name])
            config[:actions].each do |action|
              parameters = config[:client].method(action).parameters
              api_parser.on_cmd(action.to_s, "Performing #{action}", parameters) do |api_args|
                required, optional = params(config[:client], action, api_args)
                response = config[:client].send(action, *required, **optional)
                output(response)
              rescue => e
                puts "Failed to perform #{config[:name]} -> #{action} (Error: #{e.message})"
              end
            end
            api_parser.parse(args.to_a)
          end
        end
        parser.parse(@argv)
      end

      private

      def params(client, action, args)
        parameters = client.method(action).parameters
        required_parameters = parameters.filter { |p| p.first == :req }.map { |p| p.last }
        optional_parameters = parameters.filter { |p| p.first == :key }.map { |p| p.last }
        required = args.reject { |arg| arg.is_a? Field }.first(required_parameters.count)

        optional = {}
        args.filter { |arg| arg.is_a? Field }.each do |field|
          optional[field.name.to_sym] = field.value
        end
        optional.filter! { |key, value| optional_parameters.include?(key) }

        [required, optional]
      end

      def output(result)
        if result.respond_to?(:each)
          result.each do |item|
            puts item.output
            puts "-" * 20
          end
        else
          puts result.output
        end
      end
    end
  end
end
