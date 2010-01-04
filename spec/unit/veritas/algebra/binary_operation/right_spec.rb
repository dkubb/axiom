require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::BinaryOperation#right' do
  before do
    header = [ [ :id, Integer ] ]

    @left  = Relation.new(header, [ [ 1 ] ])
    @right = Relation.new(header, [ [ 2 ] ])
  end

  subject { BinaryOperationSpecs::Object.new(@left, @right).right }

  it { should equal(@right) }
end
