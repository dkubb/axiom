# encoding: utf-8

require 'spec_helper'

# tests that tuple enumerators do not get frozen

class MutableEnumerator < Enumerator
  attr_reader :mutable_array
  def initialize(tuple_source)
    @mutable_array = []
    super() do |y|
      @mutable_array << Date.new
      tuple_source.each do |t|
        y << t
      end
    end
  end
end

describe Relation do
  context 'Relations do not freeze tuple enumerators' do
    let(:tuple_enumerator) do
      MutableEnumerator.new([ [ 1, 'John Doe' ], [ 2, 'Jane Doe' ], [ 3, 'Jane Roe' ] ])
    end
    let(:relation) do
      Relation.new(
        [ [ :id, Integer ], [ :name, String, { :required => false } ] ],
        tuple_enumerator
      )
    end

    it 'Relation tuples can be marshalled to array' do
      tuples = relation.to_a
      tuples.length.should == 3
      tuple_enumerator.mutable_array.length.should == 3
    end

    it 'Relation enumerator mutability survives restriction' do
      tuples = relation.restrict { |r| r.name.match(/^Jane/) }.to_a
      tuples.length.should == 2
      tuple_enumerator.mutable_array.length.should == 3
    end

  end
end
