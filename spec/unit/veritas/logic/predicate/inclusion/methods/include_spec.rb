require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Inclusion::Methods#include' do
  subject { expression.include([ true, false ]) }

  let(:expression) { InclusionMethodsSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::Inclusion) }
end
