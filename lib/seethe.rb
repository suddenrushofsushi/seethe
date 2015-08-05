require_relative "seethe/version"

module Seethe

  class << self
    def inspect
      "Seethe #{Seethe::VERSION} on #{Seethe::RELEASE_DATE}"
    end
  end

end
