module Integrator
  class Cli::Option
    attr_reader :shortname, :longname, :description

    def initialize(shortname, longname, description)
      @shortname = shortname
      @longname = longname
      @description = description
    end
  end
end
