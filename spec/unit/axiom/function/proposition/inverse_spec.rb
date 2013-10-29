# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '#inverse' do
  subject { object.inverse }

  let(:object)           { described_class.instance                            }
  let(:described_class)  { Class.new(Function::Proposition)                    }
  let(:inverse_class)    { double('Inverse Class', instance: inverse_instance) }
  let(:inverse_instance) { double('Inverse Instance')                          }

  before do
    allow(described_class).to receive(:inverse).and_return(inverse_class)
  end

  it 'calls .inverse on the class' do
    expect(described_class).to receive(:inverse).with(no_args).and_return(inverse_class)
    subject
  end

  it 'calls .instance on the inverse class' do
    expect(inverse_class).to receive(:instance).with(no_args)
    subject
  end

  it { should be(inverse_instance) }
end
