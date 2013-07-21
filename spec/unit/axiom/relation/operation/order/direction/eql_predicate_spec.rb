# encoding: utf-8

require 'spec_helper'

[:eql?, :==].each do |method|
  describe Relation::Operation::Order::Direction, "##{method}" do
    subject { object.send(method, other) }

    let(:described_class) { Class.new(Relation::Operation::Order::Direction) }
    let(:attribute)       { Attribute::Integer.new(:id)                      }
    let(:object)          { described_class.new(attribute)                   }

    context 'with the same object' do
      let(:other) { object }

      it { should be(true) }

      it 'is symmetric' do
        should eql(other.send(method, object))
      end
    end

    context 'with an equivalent object' do
      let(:other) { object.dup }

      it { should be(true) }

      it 'is symmetric' do
        should eql(other.send(method, object))
      end
    end

    context 'with an equivalent object of a subclass' do
      let(:other) { Class.new(described_class).new(attribute) }

      it { should be(false) }

      it 'is symmetric' do
        should eql(other.send(method, object))
      end
    end

    context 'with an object having a different attribute' do
      let(:other_attribute) { Attribute::String.new(:name)         }
      let(:other)           { described_class.new(other_attribute) }

      it { should be(false) }

      it 'is symmetric' do
        should eql(other.send(method, object))
      end
    end
  end
end
