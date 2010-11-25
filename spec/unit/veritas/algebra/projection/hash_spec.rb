require 'spec_helper'

describe 'Veritas::Algebra::Projection#hash' do
  subject { object.hash }

  let(:klass)      { Algebra::Projection                                           }
  let(:body)       { [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 2, 'Alex Kubb'] ]   }
  let(:operand)    { Relation.new([ [ :id, Integer ], [ :name, String ] ], body)   }
  let(:attributes) { [ :id ]                                                       }
  let(:object)     { klass.new(operand, attributes)                                }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == klass.hash ^ operand.hash ^ object.header.hash }
end
