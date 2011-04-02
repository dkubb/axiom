require 'spec_helper'

describe Attribute::Boolean, '.primitive' do
  subject { object.primitive }

  let(:object) { Attribute::Boolean }

  it_should_behave_like 'an idempotent method'

  it { should equal(TrueClass) }
end
