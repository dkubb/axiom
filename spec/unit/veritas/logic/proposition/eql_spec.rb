require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Proposition#eql?' do
  subject { proposition.eql?(other) }

  let(:proposition) { PropositionSpecs::Object.new }

  context 'with the same class' do
    let(:other) { PropositionSpecs::Object.new }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(proposition)
    end
  end

  context 'with a different class' do
    let(:other) { Class.new(Logic::Proposition).new }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(proposition)
    end
  end
end
