# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function, '#eql?' do
  subject { object.eql?(other) }

  let(:described_class) { FunctionSpecs::Object }
  let(:other)           { described_class.new   }
  let(:object)          { described_class.new   }

  specify { expect { subject }.to raise_error(NotImplementedError, 'FunctionSpecs::Object#eql? must be implemented') }
end
