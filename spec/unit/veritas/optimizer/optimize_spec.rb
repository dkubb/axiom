require 'spec_helper'

describe Optimizer, '#optimize' do
  subject { object.optimize }

  let(:klass)     { Class.new(Optimizer) }
  let(:operation) { mock('Operation')    }
  let(:object)    { klass.new(operation) }

  before do
    klass.stub!(:to_s).and_return('Optimizer')
  end

  specify { expect { subject }.to raise_error(NotImplementedError, 'Optimizer#optimize must be implemented') }
end
