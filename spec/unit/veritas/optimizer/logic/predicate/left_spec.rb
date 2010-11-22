require 'spec_helper'

describe 'Veritas::Optimizer::Logic::Predicate#left' do
  subject { object.left }

  let(:klass)     { Optimizer::Logic::Predicate                           }
  let(:left)      { mock('Left')                                          }
  let(:right)     { mock('Right')                                         }
  let(:predicate) { Class.new(Logic::Predicate).new(left, right) }
  let(:object)    { klass.new(predicate)                                  }

  it { should equal(left) }
end
