require 'spec_helper'

describe Logic::Proposition::True, '#inverse' do
  subject { object.inverse }

  let(:klass)  { Logic::Proposition::True }
  let(:object) { klass.instance           }

  it_should_behave_like 'an idempotent method'

  it { should equal(Logic::Proposition::False.instance) }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
