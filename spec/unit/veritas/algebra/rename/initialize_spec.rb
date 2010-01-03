require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#initialize' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @aliases  = { :id => :other_id }
  end

  describe 'with aliases' do
    subject { Algebra::Rename.new(@relation, @aliases) }

    it 'should set the relation' do
      subject.relation.should equal(@relation)
    end

    it 'should set the header' do
      subject.header.should == [ [ :other_id, Integer ] ]
    end
  end

  describe 'with no aliases' do
    subject { Algebra::Rename.new(@relation) }

    it { method(:subject).should raise_error(ArgumentError) }
  end
end
