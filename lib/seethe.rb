require 'descriptive_statistics'

require_relative "seethe/version"
require_relative "seethe/churn"
require_relative "seethe/complexity"

module Seethe
  class << self
    def inspect
      "Seethe #{Seethe::VERSION} on #{Seethe::RELEASE_DATE}"
    end

    def chdir(path = ".")
      Dir.chdir(File.expand_path(path))
    end

    def glob_directory(path)
      Dir.glob(File.join(path, "**/*.*rb"))
    end

    def complect(path, flog_cutoff = 60, churn_cutoff = 10)
      complexity = Seethe::Complexity.new(path, flog_cutoff).process
      churn = Seethe::Churn.new(path, churn_cutoff).process

      complexity.select do |k,v|
        churn.has_key? k
      end
    end

    def report(path, flog_cutoff = 60, churn_cutoff = 10)
      complect(path, flog_cutoff, churn_cutoff).each do |k,v|
        puts "#{k}\t#{v}"
      end
    end

  end
end

Seethe.chdir
