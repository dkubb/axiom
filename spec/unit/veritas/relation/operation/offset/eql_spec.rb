require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset#eql?' do
  subject { object.eql?(other) }

  let(:klass)    { Relation::Operation::Offset                                 }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:order)    { relation.order                                              }
  let(:object)   { klass.new(order, 1)                                         }

  context 'with the same offset' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent offset' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different offset' do
    let(:other) { object.drop(0) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent offset of a different class' do
    let(:other) { Class.new(Relation::Operation::Offset).new(object, 1) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

end
