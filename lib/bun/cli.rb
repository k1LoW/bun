require 'thor'
require 'bun/extractor'

module Bun
  class CLI < Thor
    default_command :extract
    desc 'extract', 'Extract'
    def extract
      STDIN.each do |line|
        paragraphs = Bun::Exctractor.extract_line(line)
        paragraphs.each do |p|
          puts p
        end unless paragraphs.count == 0
      end
    end
  end
end
