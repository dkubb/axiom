require 'spec_helper'

describe Aggregate::StandardDeviation, '.finalize' do
  subject { object.finalize(accumulator) }

  let(:object)         { described_class                 }
  let(:accumulator)    { [ count, mean, sum_of_squares ] }
  let(:count)          { 6                               }
  let(:mean)           { 3.5                             }
  let(:sum_of_squares) { 17.5                            }

  it { should be_close(1.70, 0.01) }
end
