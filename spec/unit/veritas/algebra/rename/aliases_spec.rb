require 'spec_helper'

describe 'Veritas::Algebra::Rename#aliases' do
  subject { rename.aliases }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:aliases)  { { :id => :other_id }                          }
  let(:rename)   { Algebra::Rename.new(relation, aliases)        }

  it { should equal(aliases) }
end
