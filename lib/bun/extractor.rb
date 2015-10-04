require 'natto'
require 'ltsv'

module Bun
  class Exctractor
    def self.extract_line(line)
      extracted = []
      ja_start = false
      fmt = {
        node_format: 'word:%M\ttype:%s\n',
        unk_format: 'word:%M\ttype:%s\n',
        eos_format: 'EOS\n'
      }
      nm = Natto::MeCab.new(fmt)
      nm.parse(line) do |n|
        next if n.is_eos?
        parsed = LTSV.parse(n.feature)
        ja_start = true if parsed[0][:word].is_part_of_bun?
        break if ja_start && !parsed[0][:word].is_part_of_bun?
        extracted.push(parsed[0][:word]) if parsed[0][:word].is_part_of_bun?
      end
      return nil if extracted.count == 0
      extracted.join
    end
  end
end
