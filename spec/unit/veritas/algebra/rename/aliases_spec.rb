require 'spec_helper'

describe 'Veritas::Algebra::Rename#aliases' do
  subject { object.aliases }

  let(:klass)    { Algebra::Rename                               }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:aliases)  { { :id => :other_id }                          }
  let(:object)   { klass.new(relation, aliases)                  }

  it { should eql(klass::Aliases.coerce(relation.header, aliases)) }
end
