require 'spec_helper'

describe 'Veritas::Operation::Binary#new_optimized_operation' do
  subject { binary_operation.new_optimized_operation }

  let(:klass)            { Class.new { include Operation::Binary } }
  let(:left)             { mock('Left')                            }
  let(:right)            { mock('Right')                           }
  let(:binary_operation) { klass.new(left, right)                  }

  before do
    klass.class_eval do
      def new(left, right)
        self.class.new(left, right)
      end
    end
  end

  it { should be_kind_of(klass) }

  its(:left) { should equal(left) }

  its(:right) { should equal(right) }
end
