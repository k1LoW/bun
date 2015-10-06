# coding: utf-8
require 'natto'
require 'ltsv'

module Bun
  class Exctractor
    def self.extract_line(line)
      line.gsub!(/>/, '> ') # @dirty
      fmt = {
        node_format: 'word:%M\ttype:%s\n',
        unk_format: 'word:%M\ttype:%s\n',
        eos_format: 'EOS\n',
        userdic: File.dirname(__FILE__) + '/userdic/symbol.dic'
      }
      @nm = Natto::MeCab.new(fmt) unless @nm
      paragraphs = []
      extracted = []
      ja_start = false
      @nm.parse(line) do |n|
        break if n.is_eos?
        parsed = LTSV.parse(n.feature)
        ja_start = true if parsed[0][:word].is_part_of_bun?
        if ja_start && !parsed[0][:word].is_part_of_bun?
          unless extracted.join.ascii_only?
            paragraphs.concat(self.separate_paragraphs(extracted.join.strip)) unless extracted.join == ''
          end
          ja_start = false
          extracted = []
          next
        end
        extracted << parsed[0][:word] if parsed[0][:word].is_part_of_bun?
      end
      unless extracted.join == '' || extracted.join.ascii_only?
        paragraphs.concat(self.separate_paragraphs(extracted.join.strip))
      end
      paragraphs
    end

    def self.separate_paragraphs(paragraphs)
      paragraphs.gsub(/([。\.]+)/, '\1\n').split('\n').map do |p|
        p.strip
      end
    end
  end
end
