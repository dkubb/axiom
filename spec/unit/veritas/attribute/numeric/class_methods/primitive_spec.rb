require 'spec_helper'

describe Attribute::Numeric, '.primitive' do
  subject { object.primitive }

  let(:object) { described_class }

  it_should_behave_like 'an idempotent method'

  it { should equal(Numeric) }
end
