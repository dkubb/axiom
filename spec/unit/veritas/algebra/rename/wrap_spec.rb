require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#wrap' do
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:aliases)  { { :id => :other_id }                          }
  let(:rename)   { Algebra::Rename.new(relation, aliases)        }
  let(:yields)   { []                                            }

  subject { rename.wrap { |relation| relation } }

  it { should_not be_equal(rename) }

  it { should be_kind_of(Algebra::Rename) }

  it 'yields the relations' do
    lambda {
      rename.wrap { |relation| yields << relation; relation }
    }.should change { yields.dup }.from([]).to([ relation ])
  end

  it 'sets the relation with the block return values' do
    relation = mock('relation')
    operation = rename.wrap { relation }
    operation.relation.should equal(relation)
  end

  it 'sets the aliases' do
    subject.aliases.should == aliases
  end
end
