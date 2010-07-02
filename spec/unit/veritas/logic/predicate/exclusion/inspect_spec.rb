# encoding: utf-8

require 'spec_helper'

describe 'Veritas::Logic::Predicate::Exclusion#inspect' do
  subject { exclusion.inspect }

  let(:klass)     { Logic::Predicate::Exclusion }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:exclusion) { klass.new(attribute, [ 1 ]) }

  it { should == "#{attribute.inspect} ∉ #{[ 1 ].inspect}" }
end
