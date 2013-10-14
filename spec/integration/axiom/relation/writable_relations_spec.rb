# encoding: utf-8

require 'spec_helper'

describe Relation do
  context 'Relations are writable' do
    let(:relation) do
      Relation.new(
        [[:id, Integer], [:name, String, { required: false }]],
        [[1, 'John Doe'], [2, 'Jane Doe'], [3, 'Jane Roe']]
      )
    end

    it 'Rename#insert and #delete of a disjoint relation are symmetrical' do
      rename = relation.rename(id: :other_id)
      other  = [[4, 'John Doe']]
      expect(rename.insert(other).delete(other)).to eq(rename)
    end

    it 'Projection#insert and #delete of a disjoint relation are symmetrical' do
      projection = relation.project([:id])
      other      = [[4]]
      expect(projection.insert(other).delete(other)).to eq(projection)
    end

    it 'Extension#insert and #delete of a disjoint relation are symmetrical' do
      extension = relation.extend { |r| r.add(:age, 30) }
      other     = Relation.new(relation.header, [[4, 'John Doe']]).extend(extension.extensions)
      expect(extension.insert(other).delete(other)).to eq(extension)
    end

    it 'Restriction#insert and #delete of a disjoint relation are symmetrical' do
      restriction = relation.restrict { |r| r.id.gte(1) }
      other       = [[4, 'John Doe']]
      expect(restriction.insert(other).delete(other)).to eq(restriction)
    end

    it 'Join#insert and #delete of a disjoint relation are symmetrical' do
      join  = relation + Relation.new([[:id, Integer]], [[1]])
      other = [[4, 'John Doe']]
      expect(join.insert(other).delete(other)).to eq(join)
    end

    it 'Difference#insert and #delete of a disjoint relation are symmetrical' do
      difference = relation - relation
      other      = [[4, 'John Doe']]
      expect(difference.insert(other).delete(other)).to eq(difference)
    end

    it 'Union#insert and #delete of a disjoint relation are symmetrical' do
      union  = relation | relation
      other  = [[4, 'John Doe']]
      expect(union.insert(other).delete(other)).to eq(union)
    end

    it 'Intersection#insert and #delete of a disjoint relation are symmetrical' do
      intersection = relation & relation
      other        = [[4, 'John Doe']]
      expect(intersection.insert(other).delete(other)).to eq(intersection)
    end

    it 'Order#insert and #delete of a disjoint relation are symmetrical' do
      order = relation.sort_by(relation.header)
      other = Relation.new(relation.header, [[4, 'John Doe']]).sort_by(relation.header)
      expect(order.insert(other).delete(other)).to eq(order)
    end
  end
end
