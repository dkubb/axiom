require 'spec_helper'

describe Function::Numeric::Subtraction, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:-) }
end
