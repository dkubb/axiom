require 'spec_helper'

describe 'Veritas::Operation::Binary#left' do
  subject { object.left }

  let(:klass)  { Class.new { include Operation::Binary } }
  let(:left)   { mock('Left')                            }
  let(:right)  { mock('Right')                           }
  let(:object) { klass.new(left, right)                  }

  it { should equal(left) }
end
