# encoding: utf-8

require 'spec_helper'

describe Aggregate, '.finalize' do
  subject { object.finalize(accumulator) }

  let(:object)      { described_class       }
  let(:accumulator) { double('Accumulator') }

  it { should be(accumulator) }
end
