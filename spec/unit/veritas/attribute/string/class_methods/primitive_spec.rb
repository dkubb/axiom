require 'spec_helper'

describe Attribute::String, '.primitive' do
  subject { object.primitive }

  let(:object) { Attribute::String }

  it_should_behave_like 'an idempotent method'

  it { should equal(String) }
end
