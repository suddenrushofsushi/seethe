require 'action_view'
require 'ostruct'
require 'erb'
require 'flog'
require 'ruby_parser'
require 'sexp_processor'

module Seethe
  class Complexity
    attr_reader :path, :cutoff

    def initialize(path, flog_cutoff)
      @path = path
      @cutoff = flog_cutoff
    end

    def process
      unless path.is_a? Array
        set_path(Seethe.glob_directory(@path))
      end

      totals = path.inject({}) do |totals, file|
        process_file(file, totals)
        totals
      end

      totals = totals.sort do |(ak,av), (bk,bv)|
        bv <=> av
      end

      # This really isn't necessary, but I like hashes.
      totals.inject({}) { |memo, ary| memo[ary[0]] = ary[1]; memo }
    end

    private

    def new_template(body, details={format: :html})
      ActionView::Template.new(body, "irrelevant", details.fetch(:handler) { erb_handler }, details)
    end

    def process_file(file, totals)
      begin
        sexp_parsed = parse_file(file)
        flog_totals = flog_totals_for(sexp_parsed)
        mean = flog_totals.values.select { |v| v > cutoff }.mean
        totals[file] = mean unless mean.nil?
      rescue Exception => e
        puts "Error parsing #{file} (#{e.message})"
      end
    end

    def parse_file(file)
      ruby_source = File.read(file)
      ruby_source = erb_handler.call(new_template(ruby_source)) if file.end_with?(".erb")
      RubyParser.new.parse(ruby_source)
    end

    def flog_totals_for(sexp)
      flog = Flog.new
      flog.process(sexp)
      flog.calculate_total_scores
      flog.totals
    end

    def erb_handler
      @erb_handler ||= ActionView::Template::Handlers::ERB.new
    end

    def set_path(path)
      @path = path
    end
  end
end

