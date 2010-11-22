require 'spec_helper'

describe 'Veritas::Logic::Proposition#eql?' do
  subject { object.eql?(other) }

  let(:klass)  { Class.new(Logic::Proposition) }
  let(:object) { klass.new                     }

  context 'with the same class' do
    let(:other) { klass.new }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end

  context 'with a different class' do
    let(:other) { Class.new(Logic::Proposition).new }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(object)
    end
  end
end
