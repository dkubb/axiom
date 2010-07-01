require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Inclusion::Methods#include' do
  subject { expression.include(enumerable) }

  let(:expression) { InclusionMethodsSpecs::Object.new }
  let(:enumerable) { [ true, false ]                   }

  it { should be_kind_of(Logic::Predicate::Inclusion) }
end
