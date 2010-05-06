require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Operation::Binary#left' do
  let(:left)             { mock('Left')                                  }
  let(:right)            { mock('Right')                                 }
  let(:binary_operation) { BinaryOperationSpecs::Object.new(left, right) }

  subject { binary_operation.left }

  it { should equal(left) }
end
