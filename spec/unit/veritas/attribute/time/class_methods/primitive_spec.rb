require 'spec_helper'

describe 'Veritas::Attribute::Time.primitive' do
  subject { object.primitive }

  let(:object) { Attribute::Time }

  it_should_behave_like 'an idempotent method'

  it { should equal(Time) }
end
