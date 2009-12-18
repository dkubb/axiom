require File.expand_path('../../../../spec_helper', __FILE__)

include Veritas

describe Algebra::Union do
  before do
    @header = [ [ :id, Integer ] ]

    @left  = Relation.new(@header, [ [ 1 ] ])
    @right = Relation.new(@header, [ [ 2 ] ])
  end

  it { Algebra::Union.new(@left, @right).should be_kind_of(Relation) }

  it 'should union different relations' do
    Algebra::Union.new(@left, @right).should == Relation.new(@header, [ [ 1 ], [ 2 ] ])
  end

  it 'should union similar relations' do
    Algebra::Union.new(@left, @left.dup).should == Relation.new(@header, [ [ 1 ] ])
  end

  describe '.new' do
    subject { Algebra::Union.new(@left, @right) }

    it { should be_kind_of(Algebra::Union) }
  end
end
