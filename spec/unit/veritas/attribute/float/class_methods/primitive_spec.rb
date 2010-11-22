require 'spec_helper'

describe 'Veritas::Attribute::Float.primitive' do
  subject { object.primitive }

  let(:object) { Attribute::Float }

  it_should_behave_like 'an idempotent method'

  it { should equal(Float) }
end
