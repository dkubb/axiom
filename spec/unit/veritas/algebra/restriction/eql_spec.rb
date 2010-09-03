require 'spec_helper'

describe 'Veritas::Algebra::Restriction#eql?' do
  subject { object.eql?(other) }

  let(:klass)    { Algebra::Restriction                          }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:object)   { klass.new(relation, proc { true })            }

  context 'with the same restriction' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent restriction' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different restriction' do
    let(:other) { klass.new(relation, proc { false }) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent restriction of a different class' do
    let(:other) { Class.new(klass).new(relation, proc { true }) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
