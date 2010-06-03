require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Comparable#inspect' do
  subject { PredicateComparableSpecs::Object.new(left, right).inspect }

  let(:left)  { mock('Expression', :inspect => '<left>')  }
  let(:right) { mock('Expression', :inspect => '<right>') }

  it { should == '<left> == <right>' }
end
