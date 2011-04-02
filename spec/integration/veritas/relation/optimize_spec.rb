require 'spec_helper'

describe Relation, '#optimize' do
  subject { object.optimize(*args) }

  let(:object) { described_class.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }

  before do
    object.should be_instance_of(described_class)
  end

  context 'with no optimizer' do
    let(:args) { [] }

    it 'calls self.class.optimizer' do
      described_class.should_receive(:optimizer).and_return(nil)
      subject
    end

    it { should equal(object) }

    it_should_behave_like 'an optimize method'
  end

  context 'with an optimizer' do
    let(:optimized) { described_class.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
    let(:args)      { [ lambda { |relation| optimized } ]                       }

    it { should equal(optimized) }

    it_should_behave_like 'an optimize method'
  end
end
