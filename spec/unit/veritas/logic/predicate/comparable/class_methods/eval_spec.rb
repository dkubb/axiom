require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Comparable.eval' do
  subject { PredicateComparableSpecs::Object.eval(1, 1) }

  it { should be(true) }
end
