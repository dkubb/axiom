# encoding: utf-8

require 'spec_helper'

describe Comparator::Methods, '#==' do
  subject { object == other }

  let(:described_class) { Class.new { include Comparator::Methods } }
  let(:object)          { described_class.new                       }

  before do
    described_class.class_eval do
      extend Comparator
      include Immutable
      compare :nil?
    end
  end

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object of a sibling class' do
    let(:other) { Class.new.new }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end
end
