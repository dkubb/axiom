require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#directions' do
  before do
    @relation  = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @direction = @relation[:id].desc

    @order = Relation::Operation::Order.new(@relation, @direction)
  end

  subject { @order.directions }

  it { should be_instance_of(Array) }

  it { should == [ @direction ] }
end
