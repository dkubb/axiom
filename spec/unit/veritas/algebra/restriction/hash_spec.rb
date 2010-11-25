require 'spec_helper'

describe 'Veritas::Algebra::Restriction#hash' do
  subject { object.hash }

  let(:klass)     { Algebra::Restriction                          }
  let(:operand)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:predicate) { proc { true }                                 }
  let(:object)    { klass.new(operand, predicate)                 }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == operand.hash ^ predicate.hash }
end
