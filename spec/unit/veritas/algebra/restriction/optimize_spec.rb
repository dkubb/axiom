require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#optimize' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
  end

  subject { @restriction.optimize }

  describe 'with a true proposition' do
    before do
      @proposition = @relation[:id].eq(@relation[:id])
      @restriction = Algebra::Restriction.new(@relation, @proposition)
    end

    it { should equal(@relation) }
  end

  describe 'with a false proposition' do
    before do
      @proposition = @relation[:id].ne(@relation[:id])
      @restriction = Algebra::Restriction.new(@relation, @proposition)
    end

    it { should be_instance_of(Relation) }

    it { subject.header.should equal(@relation.header) }

    it { should == [] }
  end

  describe 'without a proposition' do
    before do
      @predicate   = @relation[:id].eq(1)
      @restriction = Algebra::Restriction.new(@relation, @predicate)
    end

    it { should be_kind_of(Algebra::Restriction) }

    it 'should set the predicate' do
      subject.predicate.should equal(@predicate)
    end

    it { subject.relation.should equal(@relation) }
  end

  describe 'with an empty relation' do
    before do
      @empty       = Relation::Empty.new([ [ :id, Integer ] ])
      @predicate   = @empty.header[:id].gte(1)
      @restriction = Algebra::Restriction.new(@empty, @predicate)
    end

    it { should be_kind_of(Relation::Empty) }

    it { should == @empty }
  end
end
