# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate, '#hash' do
  subject { object.hash }

  let(:object)          { described_class.new(left, right) }
  let(:described_class) { Class.new(Function::Predicate)   }
  let(:left)            { Attribute::Integer.new(:id)      }
  let(:right)           { 1                                }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ left.hash ^ right.hash }
end
