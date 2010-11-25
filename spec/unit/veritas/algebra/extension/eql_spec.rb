require 'spec_helper'

describe 'Veritas::Algebra::Extension#eql?' do
  subject { object.eql?(other) }

  let(:klass)      { Algebra::Extension                                   }
  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:extensions) { { :test => lambda { |tuple| 1 } }                    }
  let(:object)     { klass.new(operand, extensions)                       }

  context 'with the same extension' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent extension' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent extension of a different class' do
    let(:other) { Class.new(klass).new(operand, extensions) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an extension having a different operand' do
    let(:other_operand)    { Relation.new([ [ :id, Integer ] ], [ [ 3 ] ]) }
    let(:other_extensions) { extensions                                    }
    let(:other)            { klass.new(other_operand, other_extensions)    }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an extension having different extensions' do
    let(:other_operand)    { operand                                    }
    let(:other_extensions) { { :text => lambda { |tuple| 2 } }          }
    let(:other)            { klass.new(other_operand, other_extensions) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
