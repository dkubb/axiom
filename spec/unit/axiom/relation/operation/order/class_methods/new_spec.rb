# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order, '.new' do
  subject { object.new(relation, directions) }

  let(:header)   { [[:id, Integer], [:name, String]]   }
  let(:body)     { [[1, 'Dan Kubb'], [2, 'Alex Kubb']] }
  let(:relation) { Relation.new(header, body)          }
  let(:object)   { described_class                     }

  context 'with all attributes specified in the directions' do
    let(:directions) { [relation[:id], relation[:name]] }

    it { should be_instance_of(object) }

    its(:operand) { should equal(relation) }

    its(:directions) { should == [relation[:id].asc, relation[:name].asc] }
  end

  context 'without no attributes specified in the directions' do
    let(:directions) { [] }

    it { should be_instance_of(object) }

    its(:operand) { should equal(relation) }

    its(:directions) { should == [relation[:id].asc, relation[:name].asc] }
  end

  context 'without all attributes specified in the directions' do
    let(:directions) { [relation[:name].desc] }

    it { should be_instance_of(object) }

    its(:operand) { should equal(relation) }

    its(:directions) { should == [relation[:name].desc, relation[:id].asc] }
  end
end
