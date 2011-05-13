# encoding: utf-8

require 'spec_helper'

describe Algebra::Restriction::Methods, '#restrict' do
  let(:described_class) { Relation                                                  }
  let(:object)          { described_class.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:block)           { lambda { |relation| relation[:id].eq(1) }                 }

  subject { object.restrict(&block) }

  it { should be_kind_of(Algebra::Restriction) }

  it 'sets the predicate' do
    subject.predicate.should eql(block.call(object))
  end

  it 'behaves the same as Enumerable#select' do
    should == object.select { |tuple| tuple[:id] == 1 }
  end
end
