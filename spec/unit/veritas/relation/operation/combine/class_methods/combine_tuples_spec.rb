require 'spec_helper'

describe 'Veritas::Relation::Operation::Combine.combine_tuples' do
  subject { Relation::Operation::Combine.combine_tuples(header, [ 1 ], [ [ 'Dan Kubb' ] ]) { |tuple| yields << tuple } }

  let(:header) { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:yields) { []                                                            }

  it 'yields each combined tuple' do
    expect { subject }.to change { yields.dup }.from([]).to([ [ 1, 'Dan Kubb' ] ])
  end
end
