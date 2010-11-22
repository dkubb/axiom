require 'spec_helper'

describe 'Veritas::Operation::Binary#hash' do
  subject { object.hash }

  let(:klass)  { Class.new { include Operation::Binary } }
  let(:left)   { mock('Left')                            }
  let(:right)  { mock('Right')                           }
  let(:object) { klass.new(left, right)                  }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == left.hash ^ right.hash }
end
