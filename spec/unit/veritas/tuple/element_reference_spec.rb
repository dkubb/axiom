# encoding: utf-8

require 'spec_helper'

describe Tuple, '#[]' do
  subject { object[attribute] }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { described_class.new(header, [ 1 ])         }

  context 'with a known attribute' do
    let(:attribute) { header[:id] }

    it { should == 1 }
  end

  context 'with an unknown attribute' do
    let(:attribute) { Attribute::Integer.new(:other_id) }

    it { should be_nil }
  end
end
