# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate, '#inspect' do
  subject { object.inspect }

  let(:attribute) { Attribute::Integer.new(:id)       }
  let(:object)    { described_class.new(attribute, 1) }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#inspect must be implemented") }
end
