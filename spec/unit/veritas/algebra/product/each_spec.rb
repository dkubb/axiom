# encoding: utf-8

require 'spec_helper'

describe Algebra::Product, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:header) { Relation::Header.coerce([ [ :id, Integer ], [ :name, String ] ])             }
  let(:left)   { Relation.new(header.project([ :id   ]), [ [ 1 ], [ 2 ] ])                    }
  let(:right)  { Relation.new(header.project([ :name ]), [ [ 'Dan Kubb' ], [ 'Alex Kubb' ] ]) }
  let(:object) { described_class.new(left, right)                                             }
  let(:yields) { []                                                                           }

  it_should_behave_like 'an #each method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1, 'Dan Kubb' ], [ 1, 'Alex Kubb' ], [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb' ] ])
  end
end
