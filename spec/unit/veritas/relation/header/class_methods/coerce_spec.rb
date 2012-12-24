# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '.coerce' do
  context 'with a block' do
    subject { object.coerce(argument, &block) }

    let(:object) { described_class }

    context 'when the argument is a Header' do
      let(:argument) { object.new([ Attribute::Integer.new(:id) ]) }
      let(:block)    { proc { raise 'should not raise' }           }

      it { should equal(argument) }
   end

    context 'when the argument responds to #to_ary' do
      let(:argument) { [ [ :id, Integer ] ] }

      context 'and the block returns another attribute' do
        let(:block) { lambda { |attribute| other } }
        let(:other) { Attribute::Object.new(:id)   }

        it { should be_instance_of(object) }

        it { should == [ other ] }
      end

      context 'and the block does not match another attribute' do
        let(:block) { lambda { |attribute| nil } }

        it { should be_instance_of(object) }

        it { should == argument }
      end
    end

    context 'when the argument is not a Header and does not respond to #to_ary' do
      let(:argument) { Object.new                 }
      let(:block)    { lambda { |attribute| nil } }

      specify { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  context 'without a block' do
    subject { object.coerce(argument) }

    let(:object) { described_class }

    context 'when the argument is a Header' do
      let(:argument) { object.new([ Attribute::Integer.new(:id) ]) }

      it { should equal(argument) }
    end

    context 'when the argument responds to #to_ary' do
      let(:argument) { [ [ :id, Integer ] ] }

      it { should be_instance_of(object) }

      it { should == argument }
    end

    context 'when the argument is not a Header and does not respond to #to_ary' do
      let(:argument) { Object.new }

      specify { expect { subject }.to raise_error(NoMethodError) }
    end
  end
end
