# encoding: utf-8

require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe Relation::Operation::Binary::ClassMethods, '#new' do
  subject { object.new(left, right) }

  let(:original_left)  { Relation.new([[:id,   Integer]], [[1]])          }
  let(:original_right) { Relation.new([[:name, String]],  [['Dan Kubb']]) }
  let(:object)         { BinaryRelationOperationSpecs::Object             }

  context 'with left and right sorted' do
    let(:left)  { original_left.sort_by  { |r| r.id   } }
    let(:right) { original_right.sort_by { |r| r.name } }

    it { should be_instance_of(object) }
  end

  context 'with left and right unsorted' do
    let(:left)  { original_left  }
    let(:right) { original_right }

    it { should be_instance_of(object) }
  end

  context 'with left sorted, and right unsorted' do
    let(:left)  { original_left.sort_by { |r| r.id } }
    let(:right) { original_right                     }

    specify { expect { subject }.to raise_error(RelationMismatchError, 'both relations must be sorted or neither may be sorted') }
  end

  context 'with right sorted, and left unsorted' do
    let(:left)  { original_left                         }
    let(:right) { original_right.sort_by { |r| r.name } }

    specify { expect { subject }.to raise_error(RelationMismatchError, 'both relations must be sorted or neither may be sorted') }
  end
end
