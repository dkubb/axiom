# encoding: utf-8

require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe Function::Binary::Invertible, '#inverse' do
  subject { object.inverse }

  let(:described_class) { BinarySpecs::Object               }
  let(:attribute)       { Attribute::Integer.new(:id)       }
  let(:object)          { described_class.new(attribute, 1) }

  before do
    described_class.class_eval do
      def self.inverse
        self
      end
    end
  end

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(described_class) }

  it { should_not equal(object) }

  its(:left)  { should equal(attribute) }
  its(:right) { should == 1             }

  it 'is invertible' do
    subject.inverse.should equal(object)
  end
end
