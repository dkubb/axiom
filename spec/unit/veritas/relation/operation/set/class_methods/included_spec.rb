# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Set, '.included' do
  subject { object }

  let(:object) { self.class.described_type }
  let(:klass)  { Class.new                 }

  it 'extends the klass' do
    klass.singleton_class.should_not include(self.class.described_type::ClassMethods)
    klass.send(:include, subject)
    klass.singleton_class.should include(self.class.described_type::ClassMethods)
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
