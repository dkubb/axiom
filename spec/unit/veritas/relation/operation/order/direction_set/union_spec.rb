require File.expand_path('../../../../../../../spec_helper', __FILE__)

[ :union, :| ].each do |method|
  describe "Veritas::Relation::Operation::Order::DirectionSet##{method}" do
    before do
      @attribute1 = Attribute::Integer.new(:id)
      @attribute2 = Attribute::String.new(:name)

      @directions = Relation::Operation::Order::DirectionSet.new([ @attribute1 ])
      @other      = Relation::Operation::Order::DirectionSet.new([ @attribute2 ])
    end

    subject { @directions.send(method, @other) }

    it { should be_kind_of(Relation::Operation::Order::DirectionSet) }

    it { should == [ @attribute1.asc, @attribute2.asc ] }
  end
end
