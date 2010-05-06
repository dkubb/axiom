require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet#eql?' do
  let(:attribute)  { Attribute::Integer.new(:id)                                 }
  let(:directions) { Relation::Operation::Order::DirectionSet.new([ attribute ]) }

  subject { directions.eql?(other) }

  describe 'with the same direction' do
    let(:other) { directions }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(directions)
    end
  end

  describe 'with an equivalent directions' do
    let(:other) { directions.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(directions)
    end
  end

  describe 'with a different directions' do
    let(:other_attribute) { Attribute::Integer.new(:name)                                     }
    let(:other)           { Relation::Operation::Order::DirectionSet.new([ other_attribute ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(directions)
    end
  end

  describe 'with an equivalent directions of a different class' do
    let(:other) { Class.new(Relation::Operation::Order::DirectionSet).new([ attribute ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(directions)
    end
  end
end
