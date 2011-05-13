# encoding: utf-8

require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe Function::Comparable, '.call' do
  subject { object.call(left, right) }

  let(:left)   { 1                                }
  let(:right)  { 1                                }
  let(:object) { PredicateComparableSpecs::Object }

  it { should be(true) }
end
