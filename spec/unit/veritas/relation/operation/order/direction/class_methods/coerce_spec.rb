require File.expand_path('../../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction.coerce' do
  subject { klass.coerce(object) }

  let(:attribute) { Attribute::Integer.new(:id)                      }
  let(:klass)     { Class.new(Relation::Operation::Order::Direction) }

  context 'when the object is a Direction' do
    let(:object) { Relation::Operation::Order::Ascending.new(attribute) }

    it { should equal(object) }
  end

  context 'when the object is an Attribute' do
    let(:object) { attribute }

    it { should eql(klass.new(attribute)) }
  end
end
