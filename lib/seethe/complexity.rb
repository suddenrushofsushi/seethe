require 'action_view'
require 'ostruct'
require 'erb'
require 'flog'
require 'ruby_parser'
require 'sexp_processor'

module Seethe
  class Complexity
    def initialize(path, flog_cutoff)
      @path = path
      @cutoff = flog_cutoff
    end

    def new_template(body, details={format: :html})
      ActionView::Template.new(body, "irrelevant", details.fetch(:handler) { erb_handler }, details)
    end

    def process
      unless @path.is_a? Array
        @path = Seethe.glob_directory(@path)
      end
      totals = @path.inject({}) do |totals, file|
        begin
          ruby_source = File.read(file)
          ruby_source = erb_handler.call(new_template(ruby_source)) if file.end_with?(".erb")
          sexp_parsed = RubyParser.new.parse(ruby_source)

          flog_totals = flog_totals_for(sexp_parsed) 
          mean = flog_totals.map { |k,v| v }.select { |v| v > @cutoff }.mean
          totals[file] = mean unless mean.nil?
        rescue Exception => e
          puts "Error parsing #{file} (#{e.message})"
        end
        totals
      end

      totals = totals.sort do |(ak,av), (bk,bv)|
        bv <=> av
      end

      # This really isn't necessary, but I like hashes.
      totals.inject({}) { |memo, ary| memo[ary[0]] = ary[1]; memo }
    end

    def flog_totals_for(sexp)
      flog = Flog.new
      flog.process(sexp)
      flog.calculate_total_scores
      flog.totals
    end

    private

    def erb_handler
      @erb_handler ||= ActionView::Template::Handlers::ERB.new
    end
  end
end


