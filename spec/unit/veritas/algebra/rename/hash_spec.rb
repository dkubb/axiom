require 'spec_helper'

describe 'Veritas::Algebra::Rename#hash' do
  subject { object.hash }

  let(:klass)   { Algebra::Rename                               }
  let(:operand) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:aliases) { { :id => :other_id }                          }
  let(:object)  { klass.new(operand, aliases)                   }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == operand.hash ^ aliases.hash }
end
