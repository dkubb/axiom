require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::Comparable, '#inspect' do
  subject { object.inspect }

  let(:described_class) { PredicateComparableSpecs::Object          }
  let(:left)            { mock('Expression', :inspect => '<left>')  }
  let(:right)           { mock('Expression', :inspect => '<right>') }
  let(:object)          { described_class.new(left, right)          }

  it { should == '<left> == <right>' }
end
