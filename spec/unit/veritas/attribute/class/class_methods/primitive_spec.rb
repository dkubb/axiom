require 'spec_helper'

describe 'Veritas::Attribute::Class.primitive' do
  subject { object.primitive }

  let(:object) { Attribute::Class }

  it_should_behave_like 'an idempotent method'

  it { should equal(Class) }
end
