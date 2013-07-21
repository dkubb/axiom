# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '.new' do
  let(:object) { described_class              }
  let(:id)     { Attribute::Integer.new(:id)  }
  let(:name)   { Attribute::String.new(:name) }
  let(:age)    { Attribute::Integer.new(:age) }

  context 'with no arguments' do
    subject { object.new }

    it { should be_instance_of(object) }

    it { should be_empty }
  end

  context 'with attributes' do
    subject { object.new(attributes) }

    let(:attributes) { [id, name] }

    it { should be_instance_of(object) }

    it { should == attributes }

    it 'does not freeze the attributes' do
      attributes.should_not be_frozen
      expect { subject }.to_not change(attributes, :frozen?)
    end
  end

  context 'with attributes and options' do
    subject { object.new(attributes, options) }

    let(:attributes) { [id, name] }
    let(:options)    { {}         }

    it { should be_instance_of(object) }

    it { should == attributes }

    it 'does not freeze the attributes' do
      attributes.should_not be_frozen
      expect { subject }.to_not change(attributes, :frozen?)
    end

    it 'does not freeze the options' do
      options.should_not be_frozen
      expect { subject }.to_not change(options, :frozen?)
    end
  end

  context 'with attributes that contain duplicates' do
    subject { object.new([id, id, name, name, name, age]) }

    specify { expect { subject }.to raise_error(DuplicateNameError, 'duplicate names: [:id, :name]') }
  end

  context 'with an argument that does not respond to #to_ary' do
    subject { object.new(Object.new) }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
