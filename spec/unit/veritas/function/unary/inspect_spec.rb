# encoding: utf-8

require 'spec_helper'

describe Function::Unary, '#inspect' do
  subject { object.inspect }

  let(:described_class) { Class.new { include Function::Unary } }
  let(:object)          { described_class.new(1)                }

  context 'when the operation ends in "@"' do
    before do
      described_class.class_eval do
        def self.operation
          :+@
        end
      end
    end

    it { should == '+(1)' }
  end

  context 'when the operation includes a downcased string' do
    before do
      described_class.class_eval do
        def self.operation
          :op
        end
      end
    end

    it { should == 'OP(1)' }
  end
end
