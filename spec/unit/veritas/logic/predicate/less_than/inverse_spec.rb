require 'spec_helper'

describe Logic::Predicate::LessThan, '#inverse' do
  subject { object.inverse }

  let(:klass)     { Logic::Predicate::LessThan  }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:object)    { klass.new(attribute, 1)     }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Logic::Predicate::GreaterThanOrEqualTo) }

  its(:left) { should equal(attribute) }

  its(:right) { should == 1 }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
