require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Function, '#==' do
  subject { object == other }

  let(:described_class) { FunctionSpecs::Object }
  let(:other)           { described_class.new   }
  let(:object)          { described_class.new   }

  specify { expect { subject }.to raise_error(NotImplementedError, 'FunctionSpecs::Object#== must be implemented') }
end
