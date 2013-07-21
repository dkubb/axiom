# encoding: utf-8

require 'spec_helper'

describe Relation::Empty, '#size' do
  subject { object.size }

  let(:object) { described_class.new([[:id, Integer]]) }

  it { should eql(0) }
end
