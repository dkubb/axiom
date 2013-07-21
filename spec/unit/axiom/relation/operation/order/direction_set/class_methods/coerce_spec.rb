# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::DirectionSet, '.coerce' do
  subject { object.coerce(argument) }

  let(:object)        { described_class             }
  let(:direction_set) { object.new([attribute.asc]) }
  let(:array)         { [[:id, Integer]]            }
  let(:attribute)     { Attribute::Integer.new(:id) }

  context 'with a block' do
    subject { object.coerce(argument, &block) }

    context 'when the argument is a DirectionSet' do
      let(:argument) { direction_set                     }
      let(:block)    { proc { raise 'should not raise' } }

      it { should equal(direction_set) }
    end

    context 'when the argument responds to #to_ary' do
      let(:argument) { array }

      context 'and the block returns another attribute' do
        let(:block) { ->(attribute) { other }        }
        let(:other) { Attribute::String.new(:id).asc }

        it { should be_instance_of(object) }

        it { should eql(object.new([other])) }
      end

      context 'and the block does not match another attribute' do
        let(:block) { ->(attribute) { nil } }

        it { should be_instance_of(object) }

        it { should eql(direction_set) }
      end
    end

    context 'when the argument is not a DirectionSet and does not respond to #to_ary' do
      let(:argument) { Object.new            }
      let(:block)    { ->(attribute) { nil } }

      specify { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  context 'without a block' do
    subject { object.coerce(argument) }

    context 'when the argument is a DirectionSet' do
      let(:argument) { direction_set }

      it { should equal(direction_set) }
    end

    context 'when the argument responds to #to_ary' do
      let(:argument) { array }

      it { should be_instance_of(object) }

      it { should eql(direction_set) }
    end

    context 'when the argument is not a DirectionSet and does not respond to #to_ary' do
      let(:argument) { Object.new }

      specify { expect { subject }.to raise_error(NoMethodError) }
    end
  end

end
