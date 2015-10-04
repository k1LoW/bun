require 'thor'
require 'bun/extractor'

module Bun
  class CLI < Thor
    default_command :extract
    desc 'extract', 'Extract'
    def extract
      STDIN.each do |line|
        puts Bun::Exctractor.extract_line(line)
      end
    end
  end
end
