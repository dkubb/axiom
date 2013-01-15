# encoding: utf-8

require 'spec_helper'

describe Function::Unary::Invertible, '.included' do
  subject { object }

  let(:object) { self.class.described_type }
  let(:klass)  { Class.new                 }

  before do
    klass.stub(:memoize)
  end

  it 'memoizes the inverse method' do
    klass.should_receive(:memoize).with(:inverse)
    klass.send(:include, subject)
  end

  it 'delegates to the ancestor' do
    included_ancestor = false
    subject.extend Module.new {
      define_method(:included) { |_| included_ancestor = true }
    }
    expect {
      klass.send(:include, subject)
    }.to change { included_ancestor }.from(false).to(true)
  end
end
