# encoding: utf-8

require 'spec_helper'

describe Attribute::Relation, '#new_relation' do
  subject { object.new_relation(tuples) }

  let(:object) { described_class.new(:ids, header: header) }
  let(:header) { [[:id, Integer]]                          }
  let(:tuples) { [[1]]                                     }

  it 'returns the expected relation' do
    expect(subject).to eql(Relation.new(header, tuples))
  end
end
