require 'spec_helper'

describe Optimizer, '#optimizable?' do
  subject { object.optimizable? }

  let(:klass)     { Class.new(Optimizer) }
  let(:operation) { mock('Operation')    }
  let(:object)    { klass.new(operation) }

  before do
    klass.stub!(:to_s).and_return('Optimizer')
  end

  specify { expect { subject }.to raise_error(NotImplementedError, 'Optimizer#optimizable? must be implemented') }
end
