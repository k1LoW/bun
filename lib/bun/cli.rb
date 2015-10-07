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
      if !files.empty?
        files.each do |file|
          file_path = file.to_s.gsub(/\e\[\d{1,3}[mK]/, '') # strinp console character
          File.open(file_path, 'r') do |f|
            f.readlines.each_with_index do |line, i|
              puts_line(file_path, i, line).strip
            end
          end if File.exist?(file_path)
        end
      else
        # STDIN
        STDIN.each_with_index do |line, i|
          puts_line(nil, i, line)
        end
      end
    end

    def method_missing(*files)
      extract(files)
    end

    private

    def puts_line(prefix, i, line)
      prefix += ':' unless prefix.nil?
      paragraphs = Bun::Exctractor.extract_line(line)
      paragraphs.each do |p|
        if options[:number]
          puts prefix.to_s + i.to_s + ":\t" + p
        else
          l = prefix.to_s + "\t" + p
          puts l.strip
        end
      end unless paragraphs.count == 0
    end
  end
end
