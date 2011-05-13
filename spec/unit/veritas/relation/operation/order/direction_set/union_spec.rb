# encoding: utf-8

require 'spec_helper'

[ :union, :| ].each do |method|
  describe Relation::Operation::Order::DirectionSet, "##{method}" do
    subject { object.send(method, other) }

    let(:attribute1) { Attribute::Integer.new(:id)         }
    let(:attribute2) { Attribute::String.new(:name)        }
    let(:object)     { described_class.new([ attribute1 ]) }
    let(:other)      { described_class.new([ attribute2 ]) }

    it { should be_kind_of(described_class) }

    it { should == [ attribute1.asc, attribute2.asc ] }
  end
end
