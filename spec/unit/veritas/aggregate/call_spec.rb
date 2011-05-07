require 'spec_helper'

describe Aggregate, '#call' do
  subject { object.call(nil, tuple) }

  let(:described_class) { Class.new(Aggregate)                }
  let(:object)          { described_class.new(attribute)      }
  let(:attribute)       { Attribute::Integer.new(:id)         }
  let(:header)          { Relation::Header.new([ attribute ]) }
  let(:tuple)           { Tuple.new(header, [ 1 ])            }

  context 'when operand is an attribute' do
    before do
      described_class.class_eval do
        def self.call(accumulator, value)
          value
        end
      end
    end

    it { should == 1 }
  end

  context 'when operand is a literal value' do
    let(:object) { described_class.new(2) }

    before do
      described_class.class_eval do
        def self.call(accumulator, value)
          value
        end
      end
    end

    it { should == 2 }
  end

  context 'when .call is not defined' do
    specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class.name}.call must be implemented") }
  end
end
