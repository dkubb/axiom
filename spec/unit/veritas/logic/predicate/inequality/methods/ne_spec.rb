require File.expand_path('../../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Inequality::Methods#ne' do
  subject { expression.ne(:active => true) }

  let(:expression) { InequalityMethodsSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::Inequality) }
end
