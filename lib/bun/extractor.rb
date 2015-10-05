require 'natto'
require 'ltsv'

module Bun
  class Exctractor
    def self.extract_line(line)
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
            paragraphs << extracted.join unless extracted.join == ''
          end
          ja_start = false
          extracted = []
          next
        end
        extracted << parsed[0][:word] if parsed[0][:word].is_part_of_bun?
      end
      paragraphs << extracted.join unless extracted.join == '' || extracted.join.ascii_only?
      paragraphs
    end
  end
end
