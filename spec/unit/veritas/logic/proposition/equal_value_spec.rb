require 'spec_helper'

describe Logic::Proposition, '#==' do
  subject { object == other }

  let(:described_class) { Class.new(Logic::Proposition) }
  let(:object)          { described_class.new           }

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == object)
    end
  end

  context 'with a different class' do
    let(:other) { Class.new(Logic::Proposition).new }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == object)
    end
  end
end
