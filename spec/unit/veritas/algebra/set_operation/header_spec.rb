require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::SetOperation#header' do
  before do
    @header = [ [ :id, Integer ] ]

    @left  = Relation.new(@header, [ [ 1 ] ])
    @right = Relation.new(@header, [ [ 2 ] ])
  end

  subject { SetOperationSpecs::BasicObject.new(@left, @right).header }

  it "should equal either relation's header" do
    should == @header
  end
end
