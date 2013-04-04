# encoding: utf-8

require 'spec_helper'

describe Visitable, '#accept' do
  subject { object.accept(visitor) }

  let(:described_class) { Class.new { include Visitable } }
  let(:visitor)         { mock('Visitor', :visit => nil)  }
  let(:object)          { described_class.new             }

  it_should_behave_like 'a command method'

  it 'sends self to visitor#visit' do
    visitor.should_receive(:visit).with(object)
    subject
  end
end
