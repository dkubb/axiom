require 'spec_helper'

describe Relation::Header, '#==' do
  subject { object == other }

  let(:klass)      { Relation::Header      }
  let(:attributes) { [ [ :id, Integer ] ]  }
  let(:object)     { klass.new(attributes) }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object of subclasses' do
    let(:other) { Class.new(klass).new(attributes) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an object having different attributes' do
    let(:other_attributes) { [ [ :name, String ] ]       }
    let(:other)            { klass.new(other_attributes) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an object having equivalent attributes in a different order' do
    let(:attribute1) { [ :id,   Integer ]                    }
    let(:attribute2) { [ :name, String  ]                    }
    let(:object)     { klass.new([ attribute1, attribute2 ]) }
    let(:other)      { klass.new([ attribute2, attribute1 ]) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object responding to #to_ary' do
    let(:other) { attributes }

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
end
