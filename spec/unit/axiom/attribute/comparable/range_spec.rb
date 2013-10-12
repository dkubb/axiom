# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Attribute::Comparable, '#range' do
  subject { object.range }

  let(:object) { described_class.new }

  let(:described_class) do
    Class.new(ComparableSpecs::Object) do
      def type
        Types::Numeric
      end
    end
  end

  it { should eql(Types::NegativeInfinity..Types::Infinity) }
end
