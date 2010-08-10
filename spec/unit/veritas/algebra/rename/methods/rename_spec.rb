require 'spec_helper'

describe 'Veritas::Algebra::Rename::Methods#rename' do
  subject { relation.rename(:id => :other_id) }

  let(:attribute) { Attribute::Integer.new(:id)            }
  let(:other)     { attribute.rename(:other_id)            }
  let(:relation)  { Relation.new([ attribute ], [ [ 1 ] ]) }
  let(:aliases)   { { attribute => other }                 }

  it { should be_kind_of(Algebra::Rename) }
end
