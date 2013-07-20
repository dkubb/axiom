# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function, '#rename' do
  subject { object.rename(aliases) }

  let(:described_class) { FunctionSpecs::Object }
  let(:aliases)         { double('Aliases')     }
  let(:object)          { described_class.new   }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#rename is not implemented") }
end
