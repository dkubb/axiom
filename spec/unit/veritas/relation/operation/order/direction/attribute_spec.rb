require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Direction#attribute' do
  subject { direction.attribute }

  let(:attribute) { Attribute::Integer.new(:id)                      }
  let(:klass)     { Class.new(Relation::Operation::Order::Direction) }
  let(:direction) { klass.new(attribute)                             }

  it { should equal(attribute) }
end
