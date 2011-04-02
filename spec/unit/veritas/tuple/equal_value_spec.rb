require 'spec_helper'

describe Tuple, '#==' do
  subject { object == other }

  let(:klass)  { Tuple                                      }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:data)   { [ 1 ]                                      }
  let(:object) { klass.new(header, data)                    }

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

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(klass).new(header, data) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an object having a different header' do
    let(:other_header) { Relation::Header.new([ [ :id, Numeric ] ]) }
    let(:other_data)   { data                                       }
    let(:other)        { klass.new(other_header, other_data)        }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an object having different data' do
    let(:other_header) { header                              }
    let(:other_data)   { [ 2 ]                               }
    let(:other)        { klass.new(other_header, other_data) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object responding to #to_ary' do
    let(:other) { data }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with a different object responding to #to_ary' do
    let(:other) { [ 2 ] }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end
end
