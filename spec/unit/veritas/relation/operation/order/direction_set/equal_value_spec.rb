require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::DirectionSet#==' do
  subject { directions == other }

  let(:attribute)  { Attribute::Integer.new(:id)                                 }
  let(:directions) { Relation::Operation::Order::DirectionSet.new([ attribute ]) }

  context 'with the same direction' do
    let(:other) { directions }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == directions)
    end
  end

  context 'with an equivalent directions' do
    let(:other) { directions.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == directions)
    end
  end

  context 'with a different directions' do
    let(:other_attribute) { Attribute::Integer.new(:name)                                     }
    let(:other)           { Relation::Operation::Order::DirectionSet.new([ other_attribute ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == directions)
    end
  end

  context 'with an equivalent directions of a different class' do
    let(:other) { Class.new(Relation::Operation::Order::DirectionSet).new([ attribute ]) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == directions)
    end
  end
end
