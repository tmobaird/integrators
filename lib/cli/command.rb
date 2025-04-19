module Integrator
  class Cli::Command
    attr_reader :name, :description, :params, :block

    def initialize(name, description, params, block)
      @name = name
      @description = description
      @params = params
      @block = block
    end

    def help
      output = "#{@name}  #{@description}"
      output += " (Arguments: #{params_help})" if params.count > 0
      output
    end

    def params_help
      @params.map { |param| "#{param.last}: #{(param.first == :req) ? "Required" : "Optional"}" }.join(", ")
    end
  end
end
