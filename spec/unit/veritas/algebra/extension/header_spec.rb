require 'spec_helper'

describe 'Veritas::Algebra::Extension#header' do
  subject { object.header }

  let(:klass)      { Algebra::Extension                                   }
  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:extensions) { { :test => lambda { |tuple| 1 } }                    }
  let(:object)     { klass.new(operand, extensions)                       }

  it { should be_kind_of(Relation::Header) }

  it { should == [ [ :id, Integer ], [ :test, Object ] ] }

  it_should_behave_like 'an idempotent method'
end
