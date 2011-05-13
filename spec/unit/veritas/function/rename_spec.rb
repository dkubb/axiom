# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Function, '#rename' do
  subject { object.rename(aliases) }

  let(:described_class) { FunctionSpecs::Object }
  let(:aliases)         { mock('Aliases')       }
  let(:object)          { described_class.new   }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#rename must be implemented") }
end
