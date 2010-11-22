require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inclusion#inverse' do
  subject { object.inverse }

  let(:klass)      { Logic::Predicate::Inclusion      }
  let(:attribute)  { Attribute::Integer.new(:id)      }
  let(:enumerable) { [ 1 ].freeze                     }
  let(:object)     { klass.new(attribute, enumerable) }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Logic::Predicate::Exclusion) }

  its(:left) { should equal(attribute) }

  its(:right) { should equal(enumerable) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
