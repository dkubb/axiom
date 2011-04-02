require 'spec_helper'

describe Attribute::Date, '.primitive' do
  subject { object.primitive }

  let(:object) { Attribute::Date }

  it_should_behave_like 'an idempotent method'

  it { should equal(Date) }
end
