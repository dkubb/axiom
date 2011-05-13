# encoding: utf-8

require 'spec_helper'

[ :union, :| ].each do |method|
  describe Algebra::Rename::Aliases, "##{method}" do
    subject { object.send(method, other) }

    let(:attribute) { Attribute::Integer.new(:id)                  }
    let(:aliases)   { { attribute => attribute.rename(:other_id) } }
    let(:object)    { described_class.new(aliases)                 }

    context 'when other is empty' do
      let(:other) { {} }

      it { should be_kind_of(described_class) }

      it 'does nothing' do
        should == object
      end
    end

    context 'when other contains duplicate attributes' do
      let(:other) { described_class.new(attribute => attribute.rename(:another_id)) }

      it { should be_kind_of(described_class) }

      it 'ignores duplicate attributes' do
        should == described_class.new(attribute => attribute.rename(:other_id))
      end
    end

    context 'when other contains new attributes' do
      let(:other_attribute) { Attribute::String.new(:name)                                                }
      let(:other)           { described_class.new(other_attribute => other_attribute.rename(:other_name)) }

      it { should be_kind_of(described_class) }

      it 'allows new attributes' do
        should == described_class.new(attribute => attribute.rename(:other_id), other_attribute => other_attribute.rename(:other_name))
      end
    end

    context 'when other has an original attribute that is renamed to a different name' do
      let(:other_attribute) { Attribute::Integer.new(:original_id)                                }
      let(:other)           { described_class.new(other_attribute => other_attribute.rename(:id)) }

      it { should be_kind_of(described_class) }

      it 'simplifies the rename' do
        should == described_class.new(other_attribute => attribute.rename(:other_id))
      end
    end

    context 'when other has an original attribute that is renamed to the same name' do
      let(:other_attribute) { Attribute::Integer.new(:other_id)                                   }
      let(:other)           { described_class.new(other_attribute => other_attribute.rename(:id)) }

      it { should be_kind_of(described_class) }

      it 'eliminates the name' do
        should == described_class.new({})
      end
    end
  end
end
