# encoding: utf-8

require 'spec_helper'

describe Relation, '#replace' do
  subject { object.replace(other) }

  let(:header) { [ [ :id, Integer ] ]            }
  let(:object) { Relation.new(header, [ [ 1 ] ]) }
  let(:tuples) { [ [ 2 ] ]                       }

  context 'when other is a Relation' do
    let(:other) { Relation.new([ [ :id, Integer ] ], tuples) }

    it { should be_kind_of(Relation) }

    its(:header) { should == header }

    it 'returns the expected tuples' do
      should == other
    end
  end

  context 'when other is an Enumerable' do
    let(:other) { tuples }

    it { should be_kind_of(Relation) }

    its(:header) { should == header }

    it 'returns the expected tuples' do
      should == other
    end
  end
end
