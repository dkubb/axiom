require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Combine.combine_tuples' do
  subject { Relation::Operation::Combine.combine_tuples(header, [ 1 ], [ [ 'Dan Kubb' ] ]) { |tuple| yields << tuple } }

  let(:header) { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:yields) { []                                                            }

  it 'yields each combined tuple' do
    method(:subject).should change { yields.dup }.from([]).to([ [ 1, 'Dan Kubb' ] ])
  end
end
