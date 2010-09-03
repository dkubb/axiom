require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Comparable.call' do
  subject { PredicateComparableSpecs::Object.call(1, 1) }

  it { should be(true) }
end
