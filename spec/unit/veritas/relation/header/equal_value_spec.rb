require 'spec_helper'

describe 'Veritas::Relation::Header#==' do
  subject { object == other }

  let(:klass)     { Relation::Header         }
  let(:attribute) { [ :id, Integer ]         }
  let(:object)    { klass.new([ attribute ]) }

  context 'with the same header' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent header' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with a different header' do
    let(:other) { klass.new([ [ :name, String ] ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent header of different classes' do
    let(:other) { Class.new(klass).new([ attribute ]) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object responding to #to_ary' do
    let(:other) { [ attribute ] }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with a different object responding to #to_ary' do
    let(:other) { [ [ :name, String ] ] }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with equivalent attributes in a different order' do
    let(:attribute1) { [ :id,   Integer ]                    }
    let(:attribute2) { [ :name, String  ]                    }
    let(:object)     { klass.new([ attribute1, attribute2 ]) }
    let(:other)      { klass.new([ attribute2, attribute1 ]) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end
end
