require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename#header' do
  subject { object.header }

  let(:klass)    { Optimizer::Algebra::Rename                 }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:aliases)  { { :id => :other_id }                       }
  let(:relation) { base.rename(aliases)                       }
  let(:object)   { klass.new(relation)                        }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :other_id, Integer ] ] }
end
