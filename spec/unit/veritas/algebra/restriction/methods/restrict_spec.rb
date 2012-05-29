# encoding: utf-8

require 'spec_helper'

describe Algebra::Restriction::Methods, '#restrict' do
  let(:object)          { described_class.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:described_class) { Relation                                                  }

  context 'with a predicate' do
    subject { object.restrict(predicate) }

    let(:predicate) { object[:id].eq(1) }

    it { should be_instance_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should equal(predicate)
    end

    it 'behaves the same as Enumerable#select' do
      should == object.select { |tuple| tuple[:id] == 1 }
    end
  end

  context 'with a block' do
    subject do
      object.restrict { |context| context.id.eq(1) }
    end

    it { should be_instance_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should eql(object[:id].eq(1))
    end

    it 'behaves the same as Enumerable#select' do
      should == object.select { |tuple| tuple[:id] == 1 }
    end
  end
end
