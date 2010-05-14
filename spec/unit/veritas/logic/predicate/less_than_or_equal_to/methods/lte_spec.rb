require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo::Methods#lte' do
  subject { expression.lte(1) }

  let(:expression) { LessThanOrEqualToMethodsSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::LessThanOrEqualTo) }
end
