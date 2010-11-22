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

  context 'with the same relation' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent relation' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different relation' do
    let(:other) { Relation.new(header, [ [ 2 ] ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent relation of a different class' do
    let(:other) { Class.new(Relation).new(header, body) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
