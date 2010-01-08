require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction#hash' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @klass     = Class.new(Relation::Operation::Order::Direction)

    @direction = @klass.new(@attribute)
  end

  subject { @direction.hash }

  it { should be_kind_of(Integer) }

  it { should == @direction.attribute.hash }
end
