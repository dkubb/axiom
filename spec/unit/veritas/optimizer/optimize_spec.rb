require 'spec_helper'

describe Optimizer, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new(Optimizer)           }
  let(:operation)       { mock('Operation')              }
  let(:object)          { described_class.new(operation) }

  before do
    described_class.stub!(:to_s).and_return('Optimizer')
  end

  specify { expect { subject }.to raise_error(NotImplementedError, 'Optimizer#optimize must be implemented') }
end
