# encoding: utf-8

require 'spec_helper'

describe Logic::Predicate::Exclusion, '#inspect' do
  subject { object.inspect }

  let(:klass)     { Logic::Predicate::Exclusion }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:object)    { klass.new(attribute, [ 1 ]) }

  it { should == "#{attribute.inspect} ∉ #{[ 1 ].inspect}" }
end
