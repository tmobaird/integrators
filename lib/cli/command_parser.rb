module Integrator
  class Cli::CommandParser
    def initialize(namespace = nil)
      @namespace = namespace
      @commands = []
      @options = []
    end

    def on_cmd(name, description, params = [], &block)
      @commands.push(Cli::Command.new(name, description, params, block))
    end

    def on_opt(shortname, longname, description)
      @options.push(Cli::Option.new(shortname, longname, description))
    end

    def parse(input)
      command = @commands.find { |command| command.name == input.first }

      if command
        args = input[1..]
        if command.params.count > 0
          args = input[1..].map do |arg|
            if arg.include? "="
              Cli::Field.new(*arg.split("="))
            else
              arg
            end
          end
        end
        command.block.call Cli::Arguments.new(args)
        return
      end

      if input.first == "-h" || input.first == "--help"
        help
        return
      end

      option = @options.find { |option| ["-#{option.shortname}", "--#{option.longname}"].include?(input.first) }

      if option
        puts "Option used #{option}"
        return
      end

      puts "Unrecognized Command: #{input}"
      help
    end

    def help
      puts "Integrators Help:"
      puts "Namespace: #{@namespace}" if @namespace
      longest_name = @commands.max_by { |command| command.name.length }.name
      @commands.sort_by { |command| command.name }.each do |command|
        puts command.help(longest_name.length)
      end
    end
  end
end
