# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function, '#type' do
  subject { object.type }

  let(:described_class) { FunctionSpecs::Object }
  let(:object)          { described_class.new   }
  let(:type)            { double('type')        }

  before do
    described_class.should_receive(:type).and_return(type)
  end

  it 'delegates to the class type' do
    should be(type)
  end
end
