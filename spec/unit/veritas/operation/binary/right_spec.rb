require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Relation::Binary#right' do
  before do
    @left  = mock('Left')
    @right = mock('Right')

    @binary_operation = BinaryOperationSpecs::Object.new(@left, @right)
  end

  subject { @binary_operation.right }

  it { should equal(@right) }
end
