# encoding: utf-8

require 'spec_helper'

describe Relation::Materialized, '#directions' do
  subject { object.directions }

  let(:header) { Relation::Header.coerce([[:id, Integer]]) }
  let(:tuples) { LazyEnumerable.new                        }

  context 'with directions' do
    let(:object)     { described_class.new(header, tuples, directions) }
    let(:directions) { [header[:id]]                                   }

    it_should_behave_like 'an idempotent method'

    it { should == directions }
  end

  context 'with no directions' do
    let(:object) { described_class.new(header, tuples) }

    it_should_behave_like 'an idempotent method'

    it { should be(Relation::Operation::Sorted::DirectionSet::EMPTY) }
  end
end
