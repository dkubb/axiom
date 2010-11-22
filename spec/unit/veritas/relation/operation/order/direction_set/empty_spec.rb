require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::DirectionSet#empty?' do
  subject { object.empty? }

  let(:klass)  { Relation::Operation::Order::DirectionSet }
  let(:object) { klass.new(attributes)                    }

  context 'with an empty set' do
    let(:attributes) { [] }

    it { should be(true) }
  end

  context 'with directions' do
    let(:attributes) { [ Attribute::Integer.new(:id) ] }

    it { should be(false) }
  end
end
