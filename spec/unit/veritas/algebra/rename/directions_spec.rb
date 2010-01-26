require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#directions' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @aliases  = { :id => :other_id }
  end

  describe 'containing a relation' do
    before do
      @rename = Algebra::Rename.new(@relation, @aliases)
    end

    subject { @rename.directions }

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should be_empty }

    it 'should be consistent' do
      should equal(@rename.directions)
    end
  end

  describe 'containing an ordered relation' do
    before do
      @order = @relation.order([ @relation[:id] ])

      @rename = Algebra::Rename.new(@order, @aliases)
    end

    subject { @rename.directions }

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should == [ Attribute::Integer.new(:other_id).asc ] }

    it 'should be consistent' do
      should equal(@rename.directions)
    end
  end
end
