require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThanOrEqualTo::Methods#gte' do
  subject { expression.gte(1) }

  let(:expression) { GreaterThanOrEqualToMethodsSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::GreaterThanOrEqualTo) }
end
