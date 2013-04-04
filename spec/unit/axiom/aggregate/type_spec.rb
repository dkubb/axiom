# encoding: utf-8

require 'spec_helper'

describe Aggregate, '#type' do
  subject { object.type }

  let(:described_class) { Class.new(Aggregate)         }
  let(:object)          { described_class.new(operand) }
  let(:operand)         { mock('Operand')              }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#type is not implemented") }
end
