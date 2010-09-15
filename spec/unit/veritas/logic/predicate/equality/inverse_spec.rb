require 'spec_helper'

describe 'Veritas::Logic::Predicate::Equality#inverse' do
  subject { equality.inverse }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:equality)  { attribute.eq(1)             }

  it { should eql(attribute.ne(1)) }

  it 'is invertible' do
    subject.inverse.should equal(equality)
  end

  it_should_behave_like 'an idempotent method'
end
