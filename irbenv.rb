require "irb"
Bundler.require(:default)
require_relative "lib/seethe"
Pry.config.prompt_name = "Seethe" rescue nil

module Seethe
  module Console
    def self.inspect
      "Welcome to the Seethe Console!"
    end
  end
end
