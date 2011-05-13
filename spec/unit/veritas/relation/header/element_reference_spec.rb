# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#[]' do
  subject { object[name] }

  let(:object) { described_class.new([ [ :id, Integer ] ]) }

  context 'with a known attribute name' do
    let(:name) { :id }

    it { should == [ :id, Integer ] }
  end

  context 'with an unknown attribute name' do
    let(:name) { :name }

    it { should be_nil }
  end
end
