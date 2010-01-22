require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Offset#to_i' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
    @order      = Relation::Operation::Order.new(@relation, @directions)

    @offset = Relation::Operation::Offset.new(@order, 1)
  end

  subject { @offset.to_i }

  it { should == 1 }
end
