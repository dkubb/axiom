require 'spec_helper'

describe Logic::Predicate::Match, '#inverse' do
  subject { object.inverse }

  let(:attribute) { Attribute::String.new(:name)           }
  let(:regexp)    { /Dan Kubb/.freeze                      }
  let(:object)    { described_class.new(attribute, regexp) }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Logic::Predicate::NoMatch) }

  its(:left) { should equal(attribute) }

  its(:right) { should equal(regexp) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
