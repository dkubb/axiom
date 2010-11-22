require 'spec_helper'

describe 'Veritas::Tuple#eql?' do
  subject { object.eql?(other) }

  let(:klass)  { Tuple                                      }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { klass.new(header, [ 1 ])                   }

  context 'with the same tuple' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent tuple' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different tuple' do
    let(:other) { klass.new(header, [ 2 ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent tuple with a different header' do
    let(:aliases)      { Algebra::Rename::Aliases.coerce(header, :id => :other_id) }
    let(:other_header) { header.rename(aliases)                                    }
    let(:other)        { klass.new(other_header, object.to_ary)                    }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent tuple of a different class' do
    let(:other) { Class.new(klass).new(header, [ 1 ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with an equivalent object responding to #to_ary' do
    let(:other) { [ 1 ] }

    it { should be(false) }

    specification = proc do
      should == other.eql?(object)
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
      should == other.eql?(object)
    end
  end
end
