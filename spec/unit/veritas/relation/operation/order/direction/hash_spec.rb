require 'spec_helper'

describe Relation::Operation::Order::Direction, '#hash' do
  subject { object.hash }

  let(:klass)     { Class.new(Relation::Operation::Order::Direction) }
  let(:attribute) { Attribute::Integer.new(:id)                      }
  let(:object)    { klass.new(attribute)                             }

  it_should_behave_like 'a hash method'

  it { should == klass.hash ^ attribute.hash }
end
