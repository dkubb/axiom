require 'spec_helper'

describe 'Veritas::Relation::Operation::Combination.combine_tuples' do
  subject { object.combine_tuples(header, left_tuple, right_tuples) { |tuple| yields << tuple } }

  let(:left_header)  { Relation::Header.new([ [ :id,   Integer ] ] ) }
  let(:right_header) { Relation::Header.new([ [ :name, String  ] ] ) }
  let(:left_tuple)   { Tuple.new(left_header,  [ 1 ])                }
  let(:right_tuples) { [ Tuple.new(right_header, [ 'Dan Kubb' ]) ]   }
  let(:header)       { left_header | right_header                    }
  let(:object)       { Relation::Operation::Combination              }
  let(:yields)       { []                                            }

  it 'yields each combined tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1, 'Dan Kubb' ] ])
  end
end
