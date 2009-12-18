require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Union#initialize' do
  before do
    @header = [ [ :id, Integer ] ]
    @body   = [ [ 1 ] ]

    @left = Relation.new(@header, @body)
  end

  subject { Algebra::Union.new(@left, @right) }

  describe 'with similar relations' do
    before { @right = Relation.new(@header, @body) }


    it 'should set the header to be equivalent to the relations' do
      subject.header.should == @header
    end

    it 'should union the body' do
      subject.body.should == [ [ 1 ] ]
    end
  end

  describe 'with different relations' do
    before { @right = Relation.new(@header, [ [ 2 ] ]) }

    it 'should set the header to be equivalent to the relations' do
      subject.header.should == @header
    end

    it 'should union the body' do
      subject.body.should == [ [ 1 ], [ 2 ] ]
    end
  end
end
