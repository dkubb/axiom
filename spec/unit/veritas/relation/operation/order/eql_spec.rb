require 'spec_helper'

describe 'Veritas::Relation::Operation::Order#eql?' do
  subject { object.eql?(other) }

  let(:klass)      { Relation::Operation::Order                           }
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:directions) { relation.header                                      }
  let(:object)     { klass.new(relation, directions)                      }

  context 'with the same order' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent order' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different order' do
    let(:other) { klass.new(object, [ relation[:id].desc ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent order of a different class' do
    let(:other) { Class.new(klass).new(object, directions) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

end
