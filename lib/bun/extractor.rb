require 'natto'
require 'ltsv'

module Bun
  class Exctractor
    def self.extract_line(line)
      extracted = []
      ja_start = false
      self.natto
      @nm.parse(line) do |n|
        next if n.is_eos?
        parsed = LTSV.parse(n.feature)
        ja_start = true if parsed[0][:word].is_part_of_bun?
        if ja_start && !parsed[0][:word].is_part_of_bun?
          break unless extracted.join.ascii_only?
          ja_start = false
          extracted = []
        end
        extracted << parsed[0][:word] if parsed[0][:word].is_part_of_bun?
      end
      return nil if extracted.count == 0
      extracted.join unless extracted.join.ascii_only?
    end

    def self.natto
      fmt = {
        node_format: 'word:%M\ttype:%s\n',
        unk_format: 'word:%M\ttype:%s\n',
        eos_format: 'EOS\n',
        userdic: File.dirname(__FILE__) + '/userdic/symbol.dic'
      }
      @nm = Natto::MeCab.new(fmt) unless @nm
    end
  end
end
