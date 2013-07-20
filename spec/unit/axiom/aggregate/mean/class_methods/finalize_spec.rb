# encoding: utf-8

require 'spec_helper'

describe Aggregate::Mean, '.finalize' do
  subject { object.finalize(accumulator) }

  let(:object)      { described_class }
  let(:accumulator) { [ count, mean ] }
  let(:count)       { double('Count') }
  let(:mean)        { double('Mean')  }

  it_should_behave_like 'an idempotent method'

  it { should equal(mean) }
end
