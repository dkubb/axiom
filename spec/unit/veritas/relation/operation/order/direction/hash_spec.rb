require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Direction#hash' do
  subject { direction.hash }

  let(:attribute) { Attribute::Integer.new(:id)                      }
  let(:klass)     { Class.new(Relation::Operation::Order::Direction) }
  let(:direction) { klass.new(attribute)                             }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Integer) }

  it { should == direction.attribute.hash }
end
