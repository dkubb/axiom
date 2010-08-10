require 'spec_helper'

describe 'Veritas::Algebra::Rename::Aliases#==' do
  subject { object == other }

  let(:klass)     { Algebra::Rename::Aliases                     }
  let(:attribute) { Attribute::Integer.new(:id)                  }
  let(:aliases)   { { attribute => attribute.rename(:other_id) } }
  let(:object)    { klass.new(aliases)                           }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with a different object' do
    let(:other) { klass.new(attribute => attribute.rename(:another_id)) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object of a different class' do
    let(:other) { Class.new(klass).new(aliases) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end
end
