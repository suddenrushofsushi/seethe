require 'shellwords'

module Seethe
  class Churn
    def initialize(path, churn_cutoff)
      @command = "git log --oneline --no-merges {path}"
      @path = path
      @cutoff = churn_cutoff
    end

    def process
      files = Seethe.glob_directory(@path)
      churn = files.inject({}) do |memo, file|
        begin
          commit_cmd = "#{@command.sub("{path}", file)} | wc -l"
          commits = `#{commit_cmd}`.to_i
          memo[file] = commits if commits > @cutoff
        rescue Exception => e
          puts "Error getting git commits for #{file} (#{e.message})"
        end
        memo
      end

      churn = churn.sort do |(ak,av), (bk,bv)|
        bv <=> av
      end

      churn.inject({}) { |memo, ary| memo[ary[0]] = ary[1]; memo }

    end

  end
end

