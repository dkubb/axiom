require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::BinaryConnective#hash' do
  subject { connective.hash }

  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:left)       { Logic::Predicate::Equality.new(header[:id], 1)                }
  let(:right)      { Logic::Predicate::Equality.new(header[:id], 2)                }
  let(:connective) { BinaryConnectiveSpecs::Object.new(left, right)                }

  it { should be_kind_of(Integer) }

  it { should == left.hash ^ right.hash }

  it_should_behave_like 'an idempotent method'
end
