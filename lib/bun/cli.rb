require 'thor'
require 'bun/extractor'
require 'pp'

module Bun
  class CLI < Thor
    default_command :extract
    desc 'extract', 'Extract Japanese text'
    option :number, type: :boolean, aliases: '-n'
    def extract(*files)
      files = files[0] if files.is_a?(Array) && files[0].is_a?(Array) # @dirty
      files = [files] if !files.nil? && files.is_a?(String) # @dirty
      # files
      files.each do |file|
        file_path = file.to_s.gsub(/\e\[\d{1,3}[mK]/, '')
        File.open(file_path, 'r') do |f|
          f.readlines.each_with_index do |line, i|
            paragraphs = Bun::Exctractor.extract_line(line)
            paragraphs.each do |p|
              if options[:number]
                puts file_path + ':' + i.to_s + ":\t" + p
              else
                puts file_path + ":\t" + p
              end
            end unless paragraphs.count == 0
          end
        end if File.exist?(file_path)
      end
      # STDIN
      STDIN.each_with_index do |line, i|
        paragraphs = Bun::Exctractor.extract_line(line)
        paragraphs.each do |p|
          if options[:number]
            puts i.to_s + ":\t" + p
          else
            puts p
          end
        end unless paragraphs.count == 0
      end
    end

    def method_missing(*files)
      extract(files)
    end
  end
end
