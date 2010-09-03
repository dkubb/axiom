require 'spec_helper'

describe 'Veritas::Optimizable#optimize' do
  subject { object.optimize }

  let(:klass)  { Class.new { include Optimizable, Immutable } }
  let(:object) { klass.new                                    }

  context 'when there is no optimizer for the class' do
    it { should equal(object) }

    it_should_behave_like 'an optimize method'
  end

  context 'when there is an optimizer for the class' do
    let(:optimized) { mock('Optimized')                     }
    let(:optimizer) { mock('Optimizer', :call => optimized) }

    before do
      klass.optimizer = optimizer
      optimized.stub!(:memoize).and_return(optimized)
    end

    it { should equal(optimized) }

    it 'calls the optimizer with the object' do
      optimizer.should_receive(:call).with(object).and_return(optimized)
      should equal(optimized)
    end

    it "memoizes the optimized value for it's own #optimize" do
      optimized.should_receive(:memoize).with(:optimize, optimized).and_return(optimized)
      should equal(optimized)
    end
  end
end
