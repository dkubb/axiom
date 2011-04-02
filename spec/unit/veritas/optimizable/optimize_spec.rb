require 'spec_helper'

describe Optimizable, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new { include Optimizable, Immutable } }
  let(:object)          { described_class.new                          }

  context 'when there is no optimizer for the class' do
    it { should equal(object) }

    it_should_behave_like 'an optimize method'
  end

  context 'when there is an optimizer for the class' do
    let(:optimized) { mock('Optimized')                     }
    let(:optimizer) { mock('Optimizer', :call => optimized) }

    before do
      described_class.optimizer = optimizer
      optimized.stub!(:optimize).and_return(optimized)
    end

    it { should equal(optimized) }

    it 'calls the optimizer with the object' do
      optimizer.should_receive(:call).with(object).and_return(optimized)
      should equal(optimized)
    end

    it '#optimize the optimized object' do
      optimized.should_receive(:optimize).with(no_args).and_return(optimized)
      should equal(optimized)
    end
  end
end
