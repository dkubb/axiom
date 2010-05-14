require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThan::Methods#gt' do
  subject { expression.gt(1) }

  let(:expression) { GreaterThanMethodsSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::GreaterThan) }
end
