require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#empty?' do
  subject { @directions.empty? }

  describe 'with an empty set' do
    before do
      @directions = Relation::Operation::Order::DirectionSet.new([])
    end

    it { should be(true) }
  end

  describe 'with directions' do
    before do
      @attribute  = Attribute::Integer.new(:id)
      @directions = Relation::Operation::Order::DirectionSet.new([ @attribute ])
    end

    it { should be(false) }
  end
end
