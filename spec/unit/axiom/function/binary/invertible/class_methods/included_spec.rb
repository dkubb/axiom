# encoding: utf-8

require 'spec_helper'

describe Function::Binary::Invertible, '.included' do
  subject { object }

  let(:object) { described_class }
  let(:klass)  { Class.new       }

  before do
    allow(klass).to receive(:memoize)
  end

  it 'memoizes the inverse method' do
    expect(klass).to receive(:memoize).with(:inverse)
    klass.send(:include, subject)
  end

  it 'delegates to the ancestor' do
    included_ancestor = false
    mod = Module.new do
      define_method(:included) { |_| included_ancestor = true }
    end
    subject.extend mod
    expect { klass.send(:include, subject) }
      .to change { included_ancestor }.from(false).to(true)
  end
end
