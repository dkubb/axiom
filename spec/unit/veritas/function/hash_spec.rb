require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Function, '#hash' do
  subject { object.hash }

  let(:described_class) { FunctionSpecs::Object }
  let(:object)          { described_class.new   }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#hash must be implemented") }
end
