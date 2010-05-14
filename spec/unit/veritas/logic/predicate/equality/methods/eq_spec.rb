require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Equality::Methods#eq' do
  subject { expression.eq(true) }

  let(:expression) { EqualityMethodsSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::Equality) }
end
