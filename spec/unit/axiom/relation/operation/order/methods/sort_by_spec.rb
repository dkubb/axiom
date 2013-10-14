# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::Methods, '#sort_by' do
  let(:object)     { Relation.new(header, LazyEnumerable.new([[1], [2]]))    }
  let(:header)     { Relation::Header.coerce([[:id, Integer]])               }
  let(:directions) { Relation::Operation::Order::DirectionSet.coerce(header) }

  context 'with a block' do
    context 'returning an array of attribute names' do
      subject { object.sort_by(&block) }

      let(:block) { ->(relation) { [relation[:id].name] } }

      it { should be_instance_of(Relation::Operation::Order) }

      its(:directions) { should eql(directions) }

      it 'behaves the same as Array#sort_by' do
        expect(subject.to_a).to eql(object.to_a.sort_by { |tuple| tuple[:id] })
      end
    end

    context 'returning an array of attributes' do
      subject { object.sort_by(&block) }

      let(:block) { ->(relation) { [relation[:id]] } }

      it { should be_instance_of(Relation::Operation::Order) }

      its(:directions) { should eql(directions) }

      it 'behaves the same as Array#sort_by' do
        expect(subject.to_a).to eql(object.to_a.sort_by { |tuple| tuple[:id] })
      end
    end

    context 'returning an array of directions' do
      subject { object.sort_by(&block) }

      let(:block) { ->(relation) { [relation[:id].desc] } }

      it { should be_instance_of(Relation::Operation::Order) }

      its(:directions) { should eql(directions.reverse) }

      it 'behaves the same as Array#sort_by' do
        expect(subject.to_a).to eql(object.to_a.sort_by { |tuple| tuple[:id] }.reverse)
      end
    end

    context 'returning a header' do
      subject { object.sort_by(&block) }

      let(:block) { ->(relation) { header } }

      it { should be_instance_of(Relation::Operation::Order) }

      its(:directions) { should eql(directions) }

      it 'behaves the same as Array#sort_by' do
        expect(subject.to_a).to eql(object.to_a.sort_by { |tuple| tuple[:id] })
      end
    end

    context 'returning a direction set' do
      subject { object.sort_by(&block) }

      let(:block) { ->(relation) { directions } }

      it { should be_instance_of(Relation::Operation::Order) }

      its(:directions) { should eql(directions) }

      it 'behaves the same as Array#sort_by' do
        expect(subject.to_a).to eql(object.to_a.sort_by { |tuple| tuple[:id] })
      end
    end
  end

  context 'without a block' do
    context 'with an array of attribute names' do
      subject { object.sort_by([header[:id].name]) }

      it { should be_instance_of(Relation::Operation::Order) }

      its(:directions) { should eql(directions) }

      it 'behaves the same as Array#sort_by' do
        expect(subject.to_a).to eql(object.to_a.sort_by { |tuple| tuple[:id] })
      end
    end

    context 'with an array of attributes' do
      subject { object.sort_by([header[:id]]) }

      it { should be_instance_of(Relation::Operation::Order) }

      its(:directions) { should eql(directions) }

      it 'behaves the same as Array#sort_by' do
        expect(subject.to_a).to eql(object.to_a.sort_by { |tuple| tuple[:id] })
      end
    end

    context 'with an array of directions' do
      subject { object.sort_by([header[:id].desc]) }

      it { should be_instance_of(Relation::Operation::Order) }

      its(:directions) { should eql(directions.reverse) }

      it 'behaves the same as Array#sort_by' do
        expect(subject.to_a).to eql(object.to_a.sort_by { |tuple| tuple[:id] }.reverse)
      end
    end

    context 'with a header' do
      subject { object.sort_by(header) }

      it { should be_instance_of(Relation::Operation::Order) }

      its(:directions) { should eql(directions) }

      it 'behaves the same as Array#sort_by' do
        expect(subject.to_a).to eql(object.to_a.sort_by { |tuple| tuple[:id] })
      end
    end

    context 'with a direction set' do
      subject { object.sort_by(directions) }

      it { should be_instance_of(Relation::Operation::Order) }

      its(:directions) { should eql(directions) }

      it 'behaves the same as Array#sort_by' do
        expect(subject.to_a).to eql(object.to_a.sort_by { |tuple| tuple[:id] })
      end
    end

    context 'with no arguments' do
      subject { object.sort_by }

      specify { expect { subject }.to raise_error }
    end
  end
end
