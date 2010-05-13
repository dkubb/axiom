require File.expand_path('../../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Inclusion::Methods#in' do
  subject { expression.in([ true, false ]) }

  let(:expression) { InclusionMethodsSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::Inclusion) }
end
