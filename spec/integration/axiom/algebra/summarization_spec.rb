# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization do
  subject { relation.summarize(summarize_per) { |r| r.add(:count) { |accumulator, _| accumulator.to_i + 1 } } }

  let(:header)    { [[:name, String], [:qty, Integer]]                       }
  let(:relation)  { Relation.new(header, [['Dan Kubb', 1], ['John Doe', 1]]) }
  let(:by_header) { header.values_at(0)                                      }

  context 'summarize on the same set' do
    let(:summarize_per) { Relation.new(by_header, [['Dan Kubb'], ['John Doe']]) }

    it 'returns a relation with a single tuple' do
      should == [['Dan Kubb', 1], ['John Doe', 1]]
    end
  end

  context 'summarize on a smaller set' do
    let(:summarize_per) { Relation.new(by_header, [['Dan Kubb']]) }

    it 'returns a relation with a single tuple' do
      should == [['Dan Kubb', 1]]
    end
  end

  context 'summarize on a larger set' do
    let(:summarize_per) { Relation.new(by_header, [['Dan Kubb'], ['Dane Largy']]) }

    it 'returns a relation with a single tuple' do
      should == [['Dan Kubb', 1], ['Dane Largy', nil]]
    end
  end
end
