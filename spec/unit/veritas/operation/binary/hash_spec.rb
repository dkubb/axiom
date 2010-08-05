require 'spec_helper'

describe 'Veritas::Operation::Binary#hash' do
  subject { binary_operation.hash }

  let(:klass)            { Class.new { include Operation::Binary } }
  let(:left)             { mock('Left')                            }
  let(:right)            { mock('Right')                           }
  let(:binary_operation) { klass.new(left, right)                  }

  it { should be_kind_of(Integer) }

  it { should == left.hash ^ right.hash }

  it_should_behave_like 'an idempotent method'
end
