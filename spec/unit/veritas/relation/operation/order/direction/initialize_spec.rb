require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction#initialize' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @klass     = Class.new(Relation::Operation::Order::Direction)
  end

  subject { @klass.new(@attribute) }

  it 'should set the attribute' do
    subject.attribute.should equal(@attribute)
  end
end
