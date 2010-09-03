require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate#right' do
  subject { object.right }

  let(:klass)     { Optimizer::Logic::Predicate                           }
  let(:left)      { mock('Left')                                          }
  let(:right)     { mock('Right')                                         }
  let(:predicate) { Class.new(Veritas::Logic::Predicate).new(left, right) }
  let(:object)    { klass.new(predicate)                                  }

  it { should equal(right) }
end
