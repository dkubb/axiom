# encoding: utf-8

require 'spec_helper'

describe Algebra::Restriction, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:object)   { described_class.new(relation, proc { true })  }
  let(:yields)   { []                                            }

  it_should_behave_like 'an #each method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1 ] ])
  end
end
