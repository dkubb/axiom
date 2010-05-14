require 'spec_helper'

describe 'Veritas::Algebra::Product#each' do
  subject { product.each { |tuple| yields << tuple } }

  let(:header)  { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])                }
  let(:left)    { Relation.new(header.project([ :id   ]), [ [ 1 ], [ 2 ] ])                    }
  let(:right)   { Relation.new(header.project([ :name ]), [ [ 'Dan Kubb' ], [ 'Alex Kubb' ] ]) }
  let(:product) { Algebra::Product.new(left, right)                                            }
  let(:yields)  { []                                                                           }

  it { should equal(product) }

  it 'yields the product' do
    method(:subject).should change { yields.dup }.
      from([]).
      to([ [ 1, 'Dan Kubb' ], [ 1, 'Alex Kubb' ], [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb' ] ])
  end
end
