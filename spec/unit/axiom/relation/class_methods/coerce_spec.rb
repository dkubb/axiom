# encoding: utf-8

require 'spec_helper'

describe Relation, '.coerce' do
  subject { object.coerce(header, argument) }

  let(:header)   { [ [ :id, Integer ] ]            }
  let(:object)   { described_class                 }
  let(:relation) { Relation.new(header, [ [ 1 ] ]) }

  context 'when the argument is a Relation' do
    let(:argument) { relation }

    it { should equal(relation) }
  end

  context 'when the argument is an Array' do
    let(:argument) { [ [ 1 ] ] }

    it { should eql(relation) }
  end
end
