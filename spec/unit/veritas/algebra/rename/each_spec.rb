require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#each' do
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])   }
  let(:rename)   { Algebra::Rename.new(relation, :id => :other_id) }
  let(:yields)   { []                                              }

  subject { rename.each { |tuple| yields << tuple } }

  it { should equal(rename) }

  it 'yields each tuple' do
    method(:subject).should change { yields.dup }.from([]).to([ [ 1 ] ])
  end

  it 'changes the header for each tuple' do
    subject
    yields.first.header.should equal(rename.header)
  end
end
