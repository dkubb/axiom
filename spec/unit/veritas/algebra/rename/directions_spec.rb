require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#directions' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @aliases  = { :id => :other_id }
  end

  subject { @rename.directions }

  describe 'containing a relation' do
    before do
      @rename = Algebra::Rename.new(@relation, @aliases)
    end

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should be_empty }

    it 'is consistent' do
      should equal(@rename.directions)
    end
  end

  describe 'containing an ordered relation' do
    before do
      @order = @relation.order([ @relation[:id] ])

      @rename = Algebra::Rename.new(@order, @aliases)
    end

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should == [ Attribute::Integer.new(:other_id).asc ] }

    it 'is consistent' do
      should equal(@rename.directions)
    end
  end
end
