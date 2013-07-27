# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '#inverse' do
  subject { object.inverse }

  let(:described_class)  { Class.new(Function::Proposition)                    }
  let(:inverse_class)    { double('Inverse Class', instance: inverse_instance) }
  let(:inverse_instance) { double('Inverse Instance')                          }
  let(:object)           { described_class.new                                 }

  before do
    described_class.stub(inverse: inverse_class)
  end

  it 'calls .inverse on the class' do
    described_class.should_receive(:inverse).with(no_args).and_return(inverse_class)
    subject
  end

  it 'calls .instance on the inverse class' do
    inverse_class.should_receive(:instance).with(no_args)
    subject
  end

  it { should be(inverse_instance) }
end
