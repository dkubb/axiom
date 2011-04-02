require 'spec_helper'

describe Attribute::DateTime, '.primitive' do
  subject { object.primitive }

  let(:object) { Attribute::DateTime }

  it_should_behave_like 'an idempotent method'

  it { should equal(DateTime) }
end
