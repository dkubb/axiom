require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas:Operation::Binary#left' do
  before do
    @left  = mock('Left')
    @right = mock('Right')

    @binary_operation = BinaryOperationSpecs::Object.new(@left, @right)
  end

  subject { @binary_operation.left }

  it { should equal(@left) }
end
