# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function, '#type' do
  subject { object.type }

  let(:described_class) { FunctionSpecs::Object }
  let(:object)          { described_class.new   }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#type must be implemented") }
end
