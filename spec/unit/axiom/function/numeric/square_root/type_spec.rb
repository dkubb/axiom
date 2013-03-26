# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::SquareRoot, '#type' do
  subject { object.type }

  let(:object) { described_class.new(4) }

  it { should equal(Attribute::Float) }
end
