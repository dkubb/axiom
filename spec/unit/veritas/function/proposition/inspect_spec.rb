# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '#inspect' do
  subject { object.inspect }

  let(:described_class) { Class.new(Function::Proposition) }
  let(:object)          { described_class.new              }

  before do
    described_class.stub!(:name).and_return('Veritas::Function::Proposition')
  end

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class.name}.call must be implemented") }
end
