# encoding: utf-8

require 'spec_helper'

describe Function::Unary::Callable, '#included' do
  subject { object.included(descendant) }

  let(:object)     { Class.new(superklass).extend(self.class.described_class) }
  let(:superklass) { Class.new                                                }
  let(:descendant) { double('descendant')                                     }

  it_should_behave_like 'a command method'

  it 'delegates to the superclass #included method' do
    expect(superklass).to receive(:included).with(descendant)
    subject
  end

  it 'extends the descendant with Callable' do
    expect(descendant).to receive(:extend).with(self.class.described_class)
    subject
  end
end
