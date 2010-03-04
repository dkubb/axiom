require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection#directions' do
  before do
    @relation = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])
  end

  subject { @projection.directions }

  describe 'containing a relation' do
    before do
      @projection = @relation.project([ :id ])
    end

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should be_empty }

    it 'should be consistent' do
      should equal(@projection.directions)
    end
  end

  describe 'containing an ordered relation' do
    before do
      @order = @relation.order { |r| r.header }

      @projection = @order.project([ :id ])
    end

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should == [ @order[:id].asc ] }

    it 'should be consistent' do
      should equal(@projection.directions)
    end
  end
end
