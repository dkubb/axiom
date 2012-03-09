# encoding: utf-8

require 'spec_helper'

describe Evaluator::Context, '#method_missing' do
  let(:attribute) { Attribute::Integer.new(:id)         }
  let(:header)    { Relation::Header.new([ attribute ]) }
  let(:object)    { described_class.new(header) {}      }

  context 'with a valid attribute' do
    subject { object.id }

    it { should equal(attribute) }
  end

  context 'with a valid attribute and extra arguments' do
    subject { object.id(args) }

    let(:args) { mock('Arguments') }

    specify { expect { subject }.to raise_error(ArgumentError, 'wrong number of arguments (1 for 0)') }
  end

  context 'with an unknown attribute' do
    subject { object.unknown }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
