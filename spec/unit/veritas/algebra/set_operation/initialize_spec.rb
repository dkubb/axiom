require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::SetOperation#initialize' do
  before do
    header = [ [ :id, Integer ] ]

    @left  = Relation.new(header, [ [ 1 ] ])
    @right = Relation.new(header, [ [ 2 ] ])
  end

  subject { SetOperationSpecs::BasicObject.new(@left, @right) }

  it 'should set the left' do
    subject.left.should equal(@left)
  end

  it 'should set the right' do
    subject.right.should equal(@right)
  end
end
