require 'spec_helper'

describe 'Veritas::Algebra::Rename#eql?' do
  subject { rename.eql?(other) }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:aliases)  { { :id => :other_id }                          }
  let(:rename)   { relation.rename(aliases)                      }

  context 'with the same rename' do
    let(:other) { rename }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(rename)
    end
  end

  context 'with an equivalent rename' do
    let(:other) { rename.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(rename)
    end
  end

  context 'with a different rename' do
    let(:other) { relation.rename(:id => :another_id) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(rename)
    end
  end

  context 'with an equivalent rename of a different class' do
    let(:other) { Class.new(Algebra::Rename).new(relation, aliases) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(rename)
    end
  end
end
