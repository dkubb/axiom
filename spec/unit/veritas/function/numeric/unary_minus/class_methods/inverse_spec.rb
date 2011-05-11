require 'spec_helper'

describe Function::Numeric::UnaryMinus, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it { should equal(Function::Numeric::UnaryPlus) }
end
