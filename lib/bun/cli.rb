require 'thor'
require 'bun/extractor'

module Bun
  class CLI < Thor
    desc 'extract', 'Extract'
    def extract
      stdin = stdin_read
      puts Bun::Exctractor.extract_line(stdin)
    end

    private

    def stdin_read
      $stdin.read
    end
  end
end
