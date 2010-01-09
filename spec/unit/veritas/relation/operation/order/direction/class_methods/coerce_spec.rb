require File.expand_path('../../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction.coerce' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @klass     = Class.new(Relation::Operation::Order::Direction)
  end

  subject { @klass.coerce(@object) }

  describe 'when the object is a Direction' do
    before do
      @object = Relation::Operation::Order::Ascending.new(@attribute)
    end

    it { should equal(@object) }
  end

  describe 'when the object is an Attribute' do
    before do
      @object = @attribute
    end

    it { should eql(@klass.new(@attribute)) }
  end
end
