# coding: utf-8
require 'natto'
require 'ltsv'

module Bun
  class Exctractor
    def self.extract_line(line)
      line.strip!
      line.gsub!(/([>"'])/, '\1 ') # @dirty
      fmt = {
        node_format: 'word:%M\ttype:%s\tfeature:%H\n',
        unk_format: 'word:%M\ttype:%s\tfeature:%H\n',
        eos_format: 'EOS\n',
        userdic: File.dirname(__FILE__) + '/userdic/symbol.dic'
      }
      @nm = Natto::MeCab.new(fmt) unless @nm
      paragraphs = []
      extracted = []
      bun_start = false
      last_feature = nil
      @nm.parse(line) do |n|
        break if n.is_eos?
        parsed = LTSV.parse(n.feature)
        word = parsed[0][:word]
        feature = parsed[0][:feature].split(',').first
        bun_start = true if word.is_part_of_bun?
        if bun_start && !word.is_part_of_bun?
          if !extracted.join.ascii_only? && extracted.join != ''
            paragraphs.concat(self.separate_paragraphs(extracted.join.strip))
          end
          bun_start = false
          extracted = []
          last_feature = feature
          next
        end
        extracted << word if word.is_part_of_bun?
        last_feature = feature
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
