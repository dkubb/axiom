require 'spec_helper'

[ :union, :| ].each do |method|
  describe "Veritas::Relation::Operation::Order::DirectionSet##{method}" do
    subject { object.send(method, other) }

    let(:klass)      { Relation::Operation::Order::DirectionSet }
    let(:attribute1) { Attribute::Integer.new(:id)              }
    let(:attribute2) { Attribute::String.new(:name)             }
    let(:object)     { klass.new([ attribute1 ])                }
    let(:other)      { klass.new([ attribute2 ])                }

    it { should be_kind_of(klass) }

    it { should == [ attribute1.asc, attribute2.asc ] }
  end
end
