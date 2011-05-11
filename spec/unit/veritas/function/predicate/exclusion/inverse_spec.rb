require 'spec_helper'

describe Function::Predicate::Exclusion, '#inverse' do
  subject { object.inverse }

  let(:attribute)  { Attribute::Integer.new(:id)                }
  let(:enumerable) { [ 1 ].freeze                               }
  let(:object)     { described_class.new(attribute, enumerable) }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Function::Predicate::Inclusion) }

  its(:left) { should equal(attribute) }

  its(:right) { should equal(enumerable) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
