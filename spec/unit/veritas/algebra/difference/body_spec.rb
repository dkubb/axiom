require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Difference#body' do
  before do
    @header = [ [ :id, Integer ] ]

    @left = Relation.new(@header, [ [ 1 ] ])
  end

  subject { Algebra::Difference.new(@left, @right).body }

  describe 'with relations having similar bodies' do
    before do
      @right = @left.dup
    end

    it 'should subtract the bodies' do
      should == []
    end
  end

  describe 'with relations having different bodies' do
    before do
      @right = Relation.new(@header, [ [ 2 ] ])
    end

    it 'should subtract the bodies' do
      should == [ [ 1 ] ]
    end
  end
end
