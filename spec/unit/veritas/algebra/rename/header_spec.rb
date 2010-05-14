require 'spec_helper'

describe 'Veritas::Algebra::Rename#header' do
  subject { rename.header }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:aliases)  { { :id => :other_id }                          }
  let(:rename)   { Algebra::Rename.new(relation, aliases)        }

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :other_id, Integer ] ] }
end
