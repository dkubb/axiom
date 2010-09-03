require 'spec_helper'

describe 'Veritas::Algebra::Rename#eql?' do
  subject { object.eql?(other) }

  let(:klass)    { Algebra::Rename                               }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:aliases)  { { :id => :other_id }                          }
  let(:object)   { klass.new(relation, aliases)                  }

  context 'with the same rename' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent rename' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different rename' do
    let(:other) { klass.new(relation, :id => :another_id) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent rename of a different class' do
    let(:other) { Class.new(klass).new(relation, aliases) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
