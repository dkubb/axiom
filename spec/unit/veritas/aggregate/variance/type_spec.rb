# encoding: utf-8

require 'spec_helper'

describe Aggregate::Variance, '#type' do
  subject { object.type }

  let(:object)  { described_class.new(operand) }
  let(:operand) { Attribute::Integer.new(:id)  }

  it { should equal(Attribute::Float) }
end
