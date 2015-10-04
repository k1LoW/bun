require 'spec_helper'
require 'yaml'
require 'pp'

TESTSETS = File.dirname(__FILE__) + "/testsets/testset.yml";

describe Bun::Exctractor do
  YAML.load_file(TESTSETS).each do |e|
    it 'extract_line( ' + e['target'] + ' )'do
      expect(Bun::Exctractor.extract_line(e['target'])).to eql(e['extracted'])
    end
  end
end
