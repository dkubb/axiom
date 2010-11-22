require 'spec_helper'

describe 'Veritas::Relation::Operation::Limit#eql?' do
  subject { object.eql?(other) }

  let(:klass)    { Relation::Operation::Limit                                  }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:order)    { relation.order                                              }
  let(:object)   { klass.new(order, 1)                                         }

  context 'with the same limit' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent limit' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different limit' do
    let(:other) { klass.new(order, 2) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent limit of a different class' do
    let(:other) { Class.new(klass).new(order, 1) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
