require 'spec_helper'

describe 'Veritas::Optimizer::Relation::Operation::Unary#operand' do
  subject { object.operand }

  let(:klass)     { Class.new(Optimizer::Relation::Operation::Unary) }
  let(:optimized) { mock('Optimized')                                }
  let(:operand)   { mock('Operand', :optimize => optimized)          }
  let(:relation)  { mock('Relation', :operand => operand)            }
  let(:object)    { klass.new(relation)                              }

  it { should equal(optimized) }
end
