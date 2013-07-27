# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '.coerce' do
  let(:object)    { described_class             }
  let(:header)    { object.new([attribute])     }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:array)     { [[:id, Integer]]            }

  context 'with a block' do
    subject { object.coerce(argument, &block) }

    context 'when the argument is a Header' do
      let(:argument) { header                            }
      let(:block)    { proc { raise 'should not raise' } }

      it { should be(header) }
    end

    context 'when the argument responds to #to_ary' do
      let(:argument) { array }

      context 'and the block returns another attribute' do
        let(:block) { ->(attribute) { other }    }
        let(:other) { Attribute::Object.new(:id) }

        it { should be_instance_of(object) }

        it { should eql(object.new([other])) }

        its(:keys) { should be_empty }
      end

      context 'and the block does not match another attribute' do
        let(:block) { ->(attribute) { nil } }

        it { should be_instance_of(object) }

        it { should eql(header) }

        its(:keys) { should be_empty }
      end
    end

    context 'when the argument is not a Header and does not respond to #to_ary' do
      let(:argument) { Object.new            }
      let(:block)    { ->(attribute) { nil } }

      specify { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  context 'without a block' do
    subject { object.coerce(argument) }

    context 'when the argument is a Header' do
      let(:argument) { header }

      it { should be(header) }
    end

    context 'when the argument responds to #to_ary' do
      let(:argument) { array }

      it { should be_instance_of(object) }

      it { should eql(header) }

      its(:keys) { should be_empty }
    end

    context 'when the argument is not a Header and does not respond to #to_ary' do
      let(:argument) { Object.new }

      specify { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  context 'with an attribute' do
    subject { object.coerce(attribute) }

    it { should be_instance_of(object) }

    its(:to_a) { should == [attribute] }

    its(:keys) { should be_empty }
  end

  context 'with options' do
    subject { object.coerce(array, options) }

    let(:options) { { keys: [array] } }

    it { should be_instance_of(object) }

    its(:to_a) { should == array }

    its(:keys) { should == [array] }
  end
end
