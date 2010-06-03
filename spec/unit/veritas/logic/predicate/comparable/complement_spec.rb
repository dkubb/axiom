require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Comparable#complement' do
  subject { PredicateComparableSpecs::Object.new(left, right).complement }

  let(:left)  { mock('Expression') }
  let(:right) { mock('Expression') }

  it { should be_kind_of(PredicateComparableSpecs::Complement) }

  its(:left)  { should equal(left)  }
  its(:right) { should equal(right) }
end
