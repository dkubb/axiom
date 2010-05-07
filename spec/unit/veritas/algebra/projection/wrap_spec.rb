require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection#wrap' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:header)     { relation.header                               }
  let(:projection) { Algebra::Projection.new(relation, [ :id ])    }
  let(:yields)     { []                                            }

  subject { projection.wrap(header) { |relation| relation } }

  it { should_not be_equal(projection) }

  it { should be_kind_of(Algebra::Projection) }

  it 'yields the relations' do
    expect {
      projection.wrap(header) { |relation| yields << relation; relation }
    }.to change { yields.dup }.from([]).to([ relation ])
  end

  it 'sets the relation with the block return values' do
    relation = mock('relation')
    operation = projection.wrap(header) { relation }
    operation.relation.should equal(relation)
  end

  it 'sets the header' do
    subject.header.should == header
  end
end
