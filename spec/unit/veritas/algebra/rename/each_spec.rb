require 'spec_helper'

describe Algebra::Rename, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])   }
  let(:object)   { described_class.new(relation, :id => :other_id) }
  let(:yields)   { []                                              }

  it_should_behave_like 'a command method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1 ] ])
  end

  it 'each tuple has a renamed header' do
    subject
    yields.each { |tuple| tuple.header.should equal(object.header) }
  end
end
