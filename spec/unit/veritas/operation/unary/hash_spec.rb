require 'spec_helper'

describe 'Veritas::Operation::Unary#hash' do
  subject { object.hash }

  let(:klass)   { Class.new { include Operation::Unary } }
  let(:operand) { mock('Operand')                        }
  let(:object)  { klass.new(operand)                     }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == operand.hash }
end
