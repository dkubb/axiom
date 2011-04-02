require 'spec_helper'

describe Algebra::Extension, '#hash' do
  subject { object.hash }

  let(:operand)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:extensions) { { :test => lambda { |tuple| 1 } }                    }
  let(:object)     { described_class.new(operand, extensions)             }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ operand.hash ^ extensions.hash }
end
