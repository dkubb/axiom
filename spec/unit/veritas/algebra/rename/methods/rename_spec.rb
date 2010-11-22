require 'spec_helper'

describe 'Veritas::Algebra::Rename::Methods#rename' do
  subject { object.rename(aliases) }

  let(:klass)     { Relation                                 }
  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:aliases)   { { :id => :other_id }                     }
  let(:object)    { klass.new([ attribute ], [ [ 1 ] ].each) }

  it { should be_kind_of(Algebra::Rename) }
end
