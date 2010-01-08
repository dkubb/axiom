require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction#attribute' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @klass     = Class.new(Relation::Operation::Order::Direction)

    @direction = @klass.new(@attribute)
  end

  subject { @direction.attribute }

  it { should equal(@attribute) }
end
