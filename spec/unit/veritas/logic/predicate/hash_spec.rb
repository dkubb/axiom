require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate, '#hash' do
  subject { object.hash }

  let(:left)   { Attribute::Integer.new(:id)      }
  let(:right)  { 1                                }
  let(:object) { described_class.new(left, right) }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ left.hash ^ right.hash }
end
