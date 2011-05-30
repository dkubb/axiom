# encoding: utf-8

require 'spec_helper'

describe Relation::Materialized, '#directions' do
  subject { object.directions }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuples) { [].each                                    }

  context 'with directions' do
    let(:object)     { described_class.new(header, tuples, directions) }
    let(:directions) { [ header[:id] ]                                 }

    it_should_behave_like 'an idempotent method'

    it { should == directions }
  end

  context 'with no directions' do
    let(:object) { described_class.new(header, tuples) }

    it_should_behave_like 'an idempotent method'

    it { should equal(Relation::Operation::Order::DirectionSet::EMPTY) }
  end
end
