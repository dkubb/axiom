require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#eql?' do
  let(:header)   { [ [ :id, Integer ] ]         }
  let(:tuples)   { [ [ 1 ] ]                    }
  let(:relation) { Relation.new(header, tuples) }

  subject { relation.eql?(other) }

  describe 'with the same relation' do
    let(:other) { relation }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(relation)
    end
  end

  describe 'with an equivalent relation' do
    let(:other) { relation.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(relation)
    end
  end

  describe 'with a different relation' do
    let(:other) { Relation.new(header, [ [ 2 ] ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(relation)
    end
  end

  describe 'with an equivalent relation of a different class' do
    let(:other) { Class.new(Relation).new(header, tuples) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(relation)
    end
  end
end
