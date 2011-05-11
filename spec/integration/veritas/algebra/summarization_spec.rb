require 'spec_helper'

describe Algebra::Summarization do
  subject { relation.summarize(by) { |r| r.add(:count) { |accumulator, _| accumulator.to_i + 1 } } }

  let(:header)    { [ [ :name, String ], [ :qty, Integer ] ]                       }
  let(:relation)  { Relation.new(header, [ [ 'Dan Kubb', 1 ], [ 'John Doe', 1 ] ]) }
  let(:by_header) { header.values_at(0)                                            }

  context 'summarize on the same set' do
    let(:by) { Relation.new(by_header, [ [ 'Dan Kubb' ], [ 'John Doe' ] ]) }

    it 'returns a relation with a single tuple' do
      should == [ [ 'Dan Kubb', 1 ], [ 'John Doe', 1 ] ]
    end
  end

  context 'summarize on a smaller set' do
    let(:by) { Relation.new(by_header, [ [ 'Dan Kubb' ] ]) }

    it 'returns a relation with a single tuple' do
      should == [ [ 'Dan Kubb', 1 ] ]
    end
  end

  context 'summarize on a larger set' do
    let(:by) { Relation.new(by_header, [ [ 'Dan Kubb' ], [ 'Dane Largy' ] ]) }

    it 'returns a relation with a single tuple' do
      pending 'TODO: fix error when Proc-based aggregate functions can have a default accumulator specified' do
        should == [ [ 'Dan Kubb', 1 ], [ 'Dane Largy', 0 ] ]
      end
    end
  end
end
