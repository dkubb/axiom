require 'spec_helper'

describe 'Veritas::Relation#eql?' do
  subject { object.eql?(other) }

  let(:klass)  { Relation                }
  let(:header) { [ [ :id, Integer ] ]    }
  let(:body)   { [ [ 1 ] ].each          }  # use an Enumerator
  let(:object) { klass.new(header, body) }

  before do
    object.should be_instance_of(klass)
  end

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(Relation).new(header, body) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different header' do
    let(:other_header) { [ [ :id, Numeric ] ]                   }
    let(:other_body)   { body                                   }
    let(:other)        { Relation.new(other_header, other_body) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an object having a different body' do
    let(:other_header) { header                                 }
    let(:other_body)   { [ [ 2 ] ].each                         }
    let(:other)        { Relation.new(other_header, other_body) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
