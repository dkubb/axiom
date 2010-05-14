require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::LessThan::Methods#lt' do
  subject { expression.lt(1) }

  let(:expression) { LessThanMethodsSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::LessThan) }
end
