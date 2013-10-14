# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Sorted, '.new' do
  subject { object.new(relation, directions) }

  let(:object)   { described_class                     }
  let(:relation) { Relation.new(header, body)          }
  let(:header)   { [[:id, Integer], [:name, String]]   }
  let(:body)     { [[1, 'Dan Kubb'], [2, 'Alex Kubb']] }

  context 'attribute names' do
    context 'full header' do
      let(:directions) { [:id, :name] }

      it { should be_instance_of(object) }

      its(:operand) { should be(relation) }

      its(:directions) { should == [relation[:id].asc, relation[:name].asc] }
    end

    context 'partial header' do
      let(:directions) { [:name] }

      it { should be_instance_of(object) }

      its(:operand) { should be(relation) }

      its(:directions) { should == [relation[:name].asc, relation[:id].asc] }
    end
  end

  context 'attributes' do
    context 'full header' do
      let(:directions) { [relation[:id], relation[:name]] }

      it { should be_instance_of(object) }

      its(:operand) { should be(relation) }

      its(:directions) { should == [relation[:id].asc, relation[:name].asc] }
    end

    context 'partial header' do
      let(:directions) { [relation[:name]] }

      it { should be_instance_of(object) }

      its(:operand) { should be(relation) }

      its(:directions) { should == [relation[:name].asc, relation[:id].asc] }
    end
  end

  context 'array of directions' do
    context 'full header' do
      let(:directions) { [relation[:id].desc, relation[:name].desc] }

      it { should be_instance_of(object) }

      its(:operand) { should be(relation) }

      its(:directions) { should == [relation[:id].desc, relation[:name].desc] }
    end

    context 'partial header' do
      let(:directions) { [relation[:name].desc] }

      it { should be_instance_of(object) }

      its(:operand) { should be(relation) }

      its(:directions) { should == [relation[:name].desc, relation[:id].asc] }
    end
  end

  context 'header' do
    context 'full header' do
      let(:directions) { relation.header }

      it { should be_instance_of(object) }

      its(:operand) { should be(relation) }

      its(:directions) { should == [relation[:id].asc, relation[:name].asc] }
    end

    context 'partial header' do
      let(:directions) { relation.header.project([:name]) }

      it { should be_instance_of(object) }

      its(:operand) { should be(relation) }

      its(:directions) { should == [relation[:name].asc, relation[:id].asc] }
    end
  end

  context 'direction set' do
    context 'full header' do
      let(:directions) do
        Relation::Operation::Sorted::DirectionSet.new([relation[:id].desc, relation[:name].desc])
      end

      it { should be_instance_of(object) }

      its(:operand) { should be(relation) }

      its(:directions) { should be(directions) }
    end

    context 'partial header' do
      let(:directions) do
        Relation::Operation::Sorted::DirectionSet.new([relation[:name].desc])
      end

      it { should be_instance_of(object) }

      its(:operand) { should be(relation) }

      its(:directions) { should == [relation[:name].desc, relation[:id].asc] }
    end
  end

  context 'no attributes' do
    let(:directions) { [] }

    it { should be_instance_of(object) }

    its(:operand) { should be(relation) }

    its(:directions) { should == [relation[:id].asc, relation[:name].asc] }
  end
end
