require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

methods = [ :inverse ]
methods << '!' if respond_to?('!')  # available in Ruby 1.9

methods.each do |method|
  describe Function::Function, "##{method}" do
    subject { object.send(method) }

    let(:described_class) { FunctionSpecs::Object }
    let(:object)          { described_class.new   }

    specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#inverse must be implemented") }
  end
end
