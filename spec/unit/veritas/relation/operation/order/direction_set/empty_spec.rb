require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#empty?' do
  subject { directions.empty? }

  describe 'with an empty set' do
    let(:directions) { Relation::Operation::Order::DirectionSet.new([]) }

    it { should be(true) }
  end

  describe 'with directions' do
    let(:attribute)  { Attribute::Integer.new(:id)                                 }
    let(:directions) { Relation::Operation::Order::DirectionSet.new([ attribute ]) }

    it { should be(false) }
  end
end
