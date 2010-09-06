require 'spec_helper'

describe 'Veritas::Relation::Materialized.new' do
  subject { object.new(header, tuples, directions) }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuples) { [ [ 1 ] ]                                  }
  let(:object) { Relation::Materialized                     }

  context 'with directions' do
    let(:directions) { [ header[:id] ] }

    it { should be_instance_of(Relation::Materialized) }

    its(:header) { should equal(header) }

    its(:directions) { should == directions }

    it { should == tuples }
  end

  context 'without directions' do
    let(:directions) { nil }

    it { should be_instance_of(Relation::Materialized) }

    its(:header) { should equal(header) }

    its(:directions) { should equal(Relation::Operation::Order::DirectionSet::EMPTY) }

    it { should == tuples }
  end
end
