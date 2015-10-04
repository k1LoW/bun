require 'natto'
require 'ltsv'
require 'pp'

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
        ja_start = true unless parsed[0][:word].ascii_only?
        break if ja_start && parsed[0][:word].ascii_only?
        extracted.push(parsed[0][:word]) unless parsed[0][:word].ascii_only?
      end
      extracted.join
    end
  end
end
