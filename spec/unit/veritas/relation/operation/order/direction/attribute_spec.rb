require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction#attribute' do
  let(:attribute) { Attribute::Integer.new(:id)                      }
  let(:klass)     { Class.new(Relation::Operation::Order::Direction) }
  let(:direction) { klass.new(attribute)                             }

  subject { direction.attribute }

  it { should equal(attribute) }
end
