require 'spec_helper'

describe 'Veritas::Attribute::Object.primitive' do
  subject { object.primitive }

  let(:object) { Attribute::Object }

  it_should_behave_like 'an idempotent method'

  it { should equal(Object) }
end
