require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Comparable#complement' do
  subject { comparable.complement }

  let(:left)       { mock('Expression:Left')                           }
  let(:right)      { mock('Expression:Right')                          }
  let(:comparable) { PredicateComparableSpecs::Object.new(left, right) }

  it { should be_kind_of(PredicateComparableSpecs::Object) }

  its(:left)  { should equal(left)  }
  its(:right) { should equal(right) }

  it_should_behave_like 'an idempotent method'
end
