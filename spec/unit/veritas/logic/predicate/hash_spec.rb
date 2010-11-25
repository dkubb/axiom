require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#hash' do
  subject { object.hash }

  let(:klass)  { PredicateSpecs::Object      }
  let(:left)   { Attribute::Integer.new(:id) }
  let(:right)  { 1                           }
  let(:object) { klass.new(left, right)      }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == klass.hash ^ left.hash ^ right.hash }
end
