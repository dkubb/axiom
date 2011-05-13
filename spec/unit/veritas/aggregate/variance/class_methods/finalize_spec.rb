# encoding: utf-8

require 'spec_helper'

describe Aggregate::Variance, '.finalize' do
  subject { object.finalize(accumulator) }

  let(:object)         { described_class                 }
  let(:accumulator)    { [ count, mean, sum_of_squares ] }
  let(:count)          { 6                               }
  let(:mean)           { 3.5                             }
  let(:sum_of_squares) { 17.5                            }

  it { should be_close(2.91, 0.01) }
end
