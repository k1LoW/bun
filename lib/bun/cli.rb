require 'thor'
require 'bun/extractor'

module Bun
  class CLI < Thor
    default_command :extract
    desc 'extract', 'Extract'
    def extract
      STDIN.each do |line|
        extracted = Bun::Exctractor.extract_line(line)
        puts extracted unless extracted.nil?
      end
    end
  end
end
