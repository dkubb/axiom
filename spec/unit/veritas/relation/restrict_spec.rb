require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#restrict' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  describe 'with predicate arguments' do
    before do
      @predicate = @relation[:id].eq(1)
    end

    subject { @relation.restrict(@predicate) }

    it { should be_kind_of(Algebra::Restriction) }

    it 'should set the predicate' do
      subject.predicate.should == @predicate
    end
  end

  describe 'with a block' do
    before do
      @block = lambda { |relation| relation[:id].eq(1) }
    end

    subject { @relation.restrict(&@block) }

    it { should be_kind_of(Algebra::Restriction) }

    it 'should set the predicate' do
      subject.predicate.should == @block.call(@relation)
    end
  end
end
