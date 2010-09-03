require 'spec_helper'

describe 'Veritas::Algebra::Rename#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)    { Algebra::Rename                               }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:object)   { klass.new(relation, :id => :other_id)         }
  let(:yields)   { []                                            }

  it { should equal(object) }

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.from([]).to([ [ 1 ] ])
  end

  it 'changes the header for each tuple' do
    subject
    yields.first.header.should equal(object.header)
  end
end
