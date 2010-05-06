require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#==' do
  let(:attribute) { [ :id, Integer ]                    }
  let(:header)    { Relation::Header.new([ attribute ]) }

  subject { header == other }

  describe 'with the same header' do
    let(:other) { header }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == header)
    end
  end

  describe 'with an equivalent header' do
    let(:other) { header.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == header)
    end
  end

  describe 'with a different header' do
    let(:other) { Relation::Header.new([ [ :name, String ] ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == header)
    end
  end

  describe 'with an equivalent header of different classes' do
    let(:other) { Class.new(Relation::Header).new([ attribute ]) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == header)
    end
  end

  describe 'with an equivalent object responding to #to_ary' do
    let(:other) { [ attribute ] }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == header)
    end
  end

  describe 'with a different object responding to #to_ary' do
    let(:other) { [ [ :name, String ] ] }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == header)
    end
  end

  describe 'with equivalent attributes in a different order' do
    let(:attribute1) { [ :id,   Integer ]                               }
    let(:attribute2) { [ :name, String  ]                               }
    let(:header)     { Relation::Header.new([ attribute1, attribute2 ]) }
    let(:other)      { Relation::Header.new([ attribute2, attribute1 ]) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == header)
    end
  end
end
