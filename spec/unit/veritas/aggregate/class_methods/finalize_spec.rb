require 'spec_helper'

describe Aggregate, '.finalize' do
  subject { object.finalize(accumulator) }

  let(:object)      { described_class     }
  let(:accumulator) { mock('Accumulator') }

  it { should equal(accumulator) }
end
