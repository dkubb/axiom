require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#predicate' do
  before do
    @header  = Relation::Header.new([ [ :id, Integer ] ])
    @aliases = { :id => :other_id }
  end

  subject { @rename.predicate }

  describe 'containing an empty relation' do
    before do
      @empty = Relation::Empty.new(@header)

      @rename = Algebra::Rename.new(@empty, @aliases)
    end

    it { should == Algebra::Restriction::False.instance }
  end

  describe 'containing a relation' do
    before do
      @relation = Relation.new(@header, [ [ 1 ] ])

      @rename = Algebra::Rename.new(@relation, @aliases)
    end

    it { should == Algebra::Restriction::True.instance }
  end

  describe 'containing a relation with a predicate' do
    before do
      @relation    = Relation.new(@header, [ [ 1 ], [ 2 ] ])
      @restriction = @relation.restrict { |r| r[:id].eq(1) }

      @rename = Algebra::Rename.new(@restriction, @aliases)
    end

    it { should == Attribute::Integer.new(:other_id).eq(1) }
  end
end
