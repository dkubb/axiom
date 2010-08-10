require 'spec_helper'

describe 'Veritas::Tuple#eql?' do
  subject { tuple.eql?(other) }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                   }

  context 'with the same tuple' do
    let(:other) { tuple }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(tuple)
    end
  end

  context 'with an equivalent tuple' do
    let(:other) { tuple.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(tuple)
    end
  end

  context 'with a different tuple' do
    let(:other) { Tuple.new(header, [ 2 ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(tuple)
    end
  end

  context 'with an equivalent tuple with a different header' do
    let(:other_header) { header.rename(header[:id] => header[:id].rename(:other_id)) }
    let(:other)        { Tuple.new(other_header, tuple.to_ary)                       }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(tuple)
    end
  end

  context 'with an equivalent tuple of a different class' do
    let(:other) { Class.new(Tuple).new(header, [ 1 ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(tuple)
    end
  end

  context 'with an equivalent object responding to #to_ary' do
    let(:other) { [ 1 ] }

    it { should be(false) }

    specification = proc do
      should == other.eql?(tuple)
    end

    it 'is symmetric' do
      if RUBY_PLATFORM[/java/]
        pending('Array#eql? does not call other#to_ary in JRuby', &specification)
      else
        instance_eval(&specification)
      end
    end
  end

  context 'with a different object responding to #to_ary' do
    let(:other) { [ 2 ] }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(tuple)
    end
  end
end
