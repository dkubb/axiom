# encoding: utf-8

require 'spec_helper'

describe Algebra::Restriction::Methods, '#restrict' do
  let(:object)          { described_class.new(header, body)                             }
  let(:header)          { [ [ :id, Integer ], [ :name, String ] ]                       }
  let(:body)            { LazyEnumerable.new([ [ 1, 'Dan Kubb' ], [ 2, 'Alex Kubb' ] ]) }
  let(:described_class) { Relation                                                      }
  let(:tautology)       { Function::Proposition::Tautology.instance                     }

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

  context 'with a Hash' do
    subject { object.restrict(predicate) }

    let(:predicate) { { :id => 1, :name => 'Dan Kubb' } }

    it { should be_instance_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should eql(tautology.and(object[:id].eq(1).and(object[:name].eq('Dan Kubb'))))
    end

    it 'behaves the same as Enumerable#select' do
      should == object.select { |tuple| tuple[:id] == 1 and tuple[:name] == 'Dan Kubb' }
    end
  end

  context 'with an Array' do
    subject { object.restrict(predicate) }

    let(:predicate) { [ [ :id, 1 ], [ :name, 'Dan Kubb' ] ] }

    it { should be_instance_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should eql(tautology.and(object[:id].eq(1).and(object[:name].eq('Dan Kubb'))))
    end

    it 'behaves the same as Enumerable#select' do
      should == object.select { |tuple| tuple[:id] == 1 and tuple[:name] == 'Dan Kubb' }
    end
  end
end
