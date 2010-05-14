require 'spec_helper'

describe 'Veritas::Tuple#==' do
  subject { tuple == other }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                   }

  context 'with the same tuple' do
    let(:other) { tuple }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == tuple)
    end
  end

  context 'with an equivalent tuple' do
    let(:other) { tuple.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == tuple)
    end
  end

  context 'with a different tuple' do
    let(:other) { Tuple.new(header, [ 2 ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == tuple)
    end
  end

  context 'with an equivalent tuple with a different header' do
    let(:other_header) { header.rename(:id => :other_id)             }
    let(:other_tuple)  { Tuple.new(other_header, [ 1 ])              }
    let(:other)        { Tuple.new(other_header, other_tuple.to_ary) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == tuple)
    end
  end

  context 'with an equivalent tuple of a different class' do
    let(:other) { Class.new(Tuple).new(header, [ 1 ]) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == tuple)
    end
  end

  context 'with an equivalent object responding to #to_ary' do
    let(:other) { [ 1 ] }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == tuple)
    end
  end

  context 'with a different object responding to #to_ary' do
    let(:other) { [ 2 ] }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == tuple)
    end
  end
end
