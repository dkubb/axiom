require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#header' do
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:aliases)  { { :id => :other_id }                          }
  let(:rename)   { Algebra::Rename.new(relation, aliases)        }

  subject { rename.header }

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :other_id, Integer ] ] }
end
