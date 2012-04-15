# encoding: utf-8

require 'spec_helper'

describe Function::Unary::Callable, '#included' do
  subject { object.included(descendant) }

  let(:object)     { Class.new(superklass).extend(self.class.described_type) }
  let(:superklass) { Class.new                                               }
  let(:descendant) { mock('descendant')                                      }

  it_should_behave_like 'a command method'

  it 'delegates to the superclass #included method' do
    superklass.should_receive(:included).with(descendant)
    subject
  end

  it 'extends the descendant with Callable' do
    descendant.should_receive(:extend).with(self.class.described_type)
    subject
  end
end
