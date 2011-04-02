require 'spec_helper'

describe Logic::Expression, '#optimize' do
  subject { object.optimize(*args) }

  let(:klass)  { Class.new(Logic::Expression) }
  let(:object) { klass.new                    }

  before do
    klass.class_eval do
      def eql?(other)
        instance_of?(other.class)
      end
    end
  end

  context 'with no optimizer' do
    let(:args) { [] }

    it 'calls self.class.optimizer' do
      klass.should_receive(:optimizer).and_return(nil)
      subject
    end

    it 'returns self' do
      should equal(object)
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an optimizer' do
    let(:optimized) { klass.new                           }
    let(:args)      { [ lambda { |relation| optimized } ] }

    it 'returns an optimized expression' do
      should equal(optimized)
    end

    it_should_behave_like 'an optimize method'
  end
end
