require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction#rename' do
  before do
    @attribute = Attribute::Integer.new(:id)
    @klass     = Class.new(Relation::Operation::Order::Direction)

    @direction = @klass.new(@attribute)
  end

  subject { @direction.rename(:other_id) }

  it { should be_kind_of(@klass) }

  it { should eql(@klass.new(Attribute::Integer.new(:other_id))) }
end
