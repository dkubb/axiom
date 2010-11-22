require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Direction#attribute' do
  subject { object.attribute }

  let(:klass)     { Class.new(Relation::Operation::Order::Direction) }
  let(:attribute) { Attribute::Integer.new(:id)                      }
  let(:object)    { klass.new(attribute)                             }

  it { should equal(attribute) }
end
