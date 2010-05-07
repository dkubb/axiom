require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#header' do
  subject { relation.header }

  let(:header)   { [ [ :id, Integer ] ]            }
  let(:relation) { Relation.new(header, [ [ 1 ] ]) }

  it { should be_kind_of(Relation::Header) }

  it { should == header }
end
