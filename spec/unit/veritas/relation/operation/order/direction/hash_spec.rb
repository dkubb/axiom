require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Direction#hash' do
  subject { object.hash }

  let(:klass)     { Class.new(Relation::Operation::Order::Direction) }
  let(:attribute) { Attribute::Integer.new(:id)                      }
  let(:object)    { klass.new(attribute)                             }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == klass.hash ^ attribute.hash }
end
