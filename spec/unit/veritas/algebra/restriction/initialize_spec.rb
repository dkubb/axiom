require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#initialize' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  describe 'with a predicate in the block' do
    before do
      @block = lambda { |relation| proc { true } }
    end

    subject { Algebra::Restriction.new(@relation, &@block) }

    it 'should set the relation' do
      subject.relation.should equal(@relation)
    end

    it 'should set the body' do
      subject.body.should == [ [ 1 ] ]
    end
  end

  describe 'with a predicate argument' do
    subject { Algebra::Restriction.new(@relation, proc { true }) }

    it 'should set the relation' do
      subject.relation.should equal(@relation)
    end

    it 'should set the body' do
      subject.body.should == [ [ 1 ] ]
    end
  end
end
