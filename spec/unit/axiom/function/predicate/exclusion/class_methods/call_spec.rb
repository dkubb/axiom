# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::Exclusion, '.call' do
  subject { object.call(left, right) }

  let(:object) { described_class }
  let(:left)   { 1               }

  context 'when right responds to #cover?' do
    # Create class that only delegates #cover?
    let(:coverable) do
      Class.new do
        def initialize(object)
          @object = object
        end

        def cover?(value)
          @object.cover?(value)
        end
      end
    end

    context 'when left is excluded in right' do
      let(:right) { coverable.new(1..1) }

      it { should be(false) }
    end

    context 'when left is not excluded in right' do
      let(:right) { coverable.new(0..0) }

      it { should be(true) }
    end
  end

  context 'when right responds to #include?' do

    context 'when left is excluded in right' do
      let(:right) { [1] }

      it { should be(false) }
    end

    context 'when left is not excluded in right' do
      let(:right) { [0] }

      it { should be(true) }
    end
  end
end
