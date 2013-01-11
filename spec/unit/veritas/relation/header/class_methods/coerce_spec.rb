# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '.coerce' do
  let(:object) { described_class                             }
  let(:header) { object.new([ Attribute::Integer.new(:id) ]) }
  let(:array)  { [ [ :id, Integer ] ]                        }

  context 'with a block' do
    subject { object.coerce(argument, &block) }

    context 'when the argument is a Header' do
      let(:argument) { header                            }
      let(:block)    { proc { raise 'should not raise' } }

      it { should equal(header) }
    end

    context 'when the argument responds to #to_ary' do
      let(:argument) { array }

      context 'and the block returns another attribute' do
        let(:block) { lambda { |attribute| other } }
        let(:other) { Attribute::Object.new(:id)   }

        it { should be_instance_of(object) }

        it { should eql(object.new([ other ])) }
      end

      context 'and the block does not match another attribute' do
        let(:block) { lambda { |attribute| nil } }

        it { should be_instance_of(object) }

        it { should eql(header) }
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

    context 'when the argument is a Header' do
      let(:argument) { header }

      it { should equal(header) }
    end

    context 'when the argument responds to #to_ary' do
      let(:argument) { array }

      it { should be_instance_of(object) }

      it { should eql(header) }
    end

    context 'when the argument is not a Header and does not respond to #to_ary' do
      let(:argument) { Object.new }

      specify { expect { subject }.to raise_error(NoMethodError) }
    end
  end
end
