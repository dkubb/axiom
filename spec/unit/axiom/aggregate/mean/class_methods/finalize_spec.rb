# encoding: utf-8

require 'spec_helper'

describe Aggregate::Mean, '.finalize' do
  subject { object.finalize(accumulator) }

  let(:object)      { described_class }
  let(:accumulator) { [ count, mean ] }
  let(:count)       { mock('Count')   }
  let(:mean)        { mock('Mean')    }

  it_should_behave_like 'an idempotent method'

  it { should equal(mean) }
end
