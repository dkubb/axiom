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
      rename.insert(other).delete(other).should == rename
    end

    it 'Projection#insert and #delete of a disjoint relation are symmetrical' do
      projection = relation.project([:id])
      other      = [[4]]
      projection.insert(other).delete(other).should == projection
    end

    it 'Extension#insert and #delete of a disjoint relation are symmetrical' do
      extension = relation.extend { |r| r.add(:age, 30) }
      other     = Relation.new(relation.header, [[4, 'John Doe']]).extend(extension.extensions)
      extension.insert(other).delete(other).should == extension
    end

    it 'Restriction#insert and #delete of a disjoint relation are symmetrical' do
      restriction = relation.restrict { |r| r.id.gte(1) }
      other       = [[4, 'John Doe']]
      restriction.insert(other).delete(other).should == restriction
    end

    it 'Join#insert and #delete of a disjoint relation are symmetrical' do
      join  = relation + Relation.new([[:id, Integer]], [[1]])
      other = [[4, 'John Doe']]
      join.insert(other).delete(other).should == join
    end

    it 'Difference#insert and #delete of a disjoint relation are symmetrical' do
      difference = relation - relation
      other      = [[4, 'John Doe']]
      difference.insert(other).delete(other).should == difference
    end

    it 'Union#insert and #delete of a disjoint relation are symmetrical' do
      union  = relation | relation
      other  = [[4, 'John Doe']]
      union.insert(other).delete(other).should == union
    end

    it 'Intersection#insert and #delete of a disjoint relation are symmetrical' do
      intersection = relation & relation
      other        = [[4, 'John Doe']]
      intersection.insert(other).delete(other).should == intersection
    end

    it 'Order#insert and #delete of a disjoint relation are symmetrical' do
      order = relation.sort_by(relation.header)
      other = Relation.new(relation.header, [[4, 'John Doe']]).sort_by(relation.header)
      order.insert(other).delete(other).should == order
    end
  end
end
