require 'spec_helper'

describe 'Veritas::Logic::Predicate::NoMatch#inverse' do
  subject { object.inverse }

  let(:klass)     { Logic::Predicate::NoMatch    }
  let(:attribute) { Attribute::String.new(:name) }
  let(:regexp)    { /Dan Kubb/.freeze            }
  let(:object)    { klass.new(attribute, regexp) }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Logic::Predicate::Match) }

  its(:left) { should equal(attribute) }

  its(:right) { should equal(regexp) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
