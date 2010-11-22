require 'spec_helper'

describe 'Veritas::Tuple#==' do
  subject { object == other }

  let(:klass)  { Tuple                                      }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { klass.new(header, [ 1 ])                   }

  context 'with the same tuple' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent tuple' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with a different tuple' do
    let(:other) { klass.new(header, [ 2 ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent tuple with a different header' do
    let(:aliases)      { Algebra::Rename::Aliases.coerce(header, :id => :other_id) }
    let(:other_header) { header.rename(aliases)                                    }
    let(:other_object) { klass.new(other_header, [ 1 ])                            }
    let(:other)        { klass.new(other_header, other_object.to_ary)              }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent tuple of a different class' do
    let(:other) { Class.new(klass).new(header, [ 1 ]) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object responding to #to_ary' do
    let(:other) { [ 1 ] }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with a different object responding to #to_ary' do
    let(:other) { [ 2 ] }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end
end
