require 'spec_helper'

describe 'Veritas::Algebra::Rename#wrap' do
  subject { rename.wrap { |relation| relation } }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:aliases)  { { :id => :other_id }                          }
  let(:rename)   { Algebra::Rename.new(relation, aliases)        }
  let(:yields)   { []                                            }

  it { should_not be_equal(rename) }

  it { should be_kind_of(Algebra::Rename) }

  it 'yields the relations' do
    expect {
      rename.wrap { |relation| yields << relation; relation }
    }.to change { yields.dup }.from([]).to([ relation ])
  end

  it 'sets the relation with the block return values' do
    operation = rename.wrap { relation }
    operation.operand.should equal(relation)
  end

  its(:aliases) { should eql(Algebra::Rename::Aliases.coerce(relation.header, aliases)) }
end
