# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::Methods, '#sort' do
  subject { object.sort }

  let(:object)     { Relation.new(header, LazyEnumerable.new([[1], [2]]))    }
  let(:header)     { Relation::Header.coerce([[:id, Integer]])               }
  let(:directions) { Relation::Operation::Order::DirectionSet.coerce(header) }

  it { should be_instance_of(Relation::Operation::Order) }

  its(:directions) { should eql(directions) }

  it 'behaves the same as Array#sort_by' do
    expect(subject.to_a).to eql(object.to_a.sort_by { |tuple| tuple[:id] })
  end
end
