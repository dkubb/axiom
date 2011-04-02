require 'spec_helper'

describe Algebra::Join, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:left)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])                         }
  let(:right)  { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }
  let(:object) { described_class.new(left, right)                                             }
  let(:yields) { []                                                                           }

  it_should_behave_like 'a command method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 2, 'Dan Kubb' ] ])
  end
end
