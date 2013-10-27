# encoding: utf-8

require 'spec_helper'

describe Aggregate, '.default' do
  subject { object.default }

  let(:object)  { Class.new(described_class) }
  let(:default) { double('default')          }

  before do
    object.const_set(:DEFAULT, default)
  end

  it { should be(default) }
end
