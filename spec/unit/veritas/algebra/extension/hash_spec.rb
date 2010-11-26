require 'spec_helper'

describe 'Veritas::Algebra::Extension#hash' do
  subject { object.hash }

  let(:klass)      { Algebra::Extension                                   }
  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:extensions) { { :test => lambda { |tuple| 1 } }                    }
  let(:object)     { klass.new(operand, extensions)                       }

  it_should_behave_like 'a hash method'

  it { should == klass.hash ^ operand.hash ^ extensions.hash }
end
