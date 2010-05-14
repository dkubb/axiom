require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Operation::Binary#hash' do
  subject { binary_operation.hash }

  let(:left)             { mock('Left')                                  }
  let(:right)            { mock('Right')                                 }
  let(:binary_operation) { BinaryOperationSpecs::Object.new(left, right) }

  it { should be_kind_of(Integer) }

  it { should == left.hash ^ right.hash }
end
