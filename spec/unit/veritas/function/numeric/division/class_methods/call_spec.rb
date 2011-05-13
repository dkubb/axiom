# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Division, '.call' do
  subject { object.call(left, right) }

  let(:object) { described_class }
  let(:left)   { 2               }
  let(:right)  { 2               }

  it { should == 1 }
end
