# encoding: utf-8

require 'spec_helper'

describe Evaluator::Context, '#yield' do
  subject { object.yield }

  let(:attribute)    { Attribute::Integer.new(:id)                  }
  let(:header)       { Relation::Header.new([attribute])            }
  let(:return_value) { double('Return Value')                       }
  let(:object)       { described_class.new(header) { return_value } }

  it { should be(return_value) }
end
