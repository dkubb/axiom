require 'spec_helper'

describe Logic::Proposition, '#eql?' do
  subject { object.eql?(other) }

  let(:described_class) { Class.new(Logic::Proposition) }
  let(:object)          { described_class.new           }

  context 'with the same class' do
    let(:other) { described_class.new }

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
