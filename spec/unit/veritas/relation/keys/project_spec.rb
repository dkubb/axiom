# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '#project' do
  subject { object.project(attributes) }

  let(:object)         { described_class.new([ header ])                        }
  let(:header)         { Relation::Header.new([ id_attribute, name_attribute ]) }
  let(:id_attribute)   { Attribute::Integer.new(:id)                            }
  let(:name_attribute) { Attribute::String.new(:name)                           }

  context 'with attributes that do not change the keys' do
    let(:attributes) { [ id_attribute, name_attribute ] }

    it { should equal(object) }
  end

  context 'with attributes that change the keys' do
    let(:attributes) { [ id_attribute ] }

    it { should be_instance_of(described_class) }

    it { should == described_class.new([ Relation::Header.coerce([ id_attribute ]) ]) }
  end

  context 'with attributes that clear the keys' do
    let(:attributes) { [] }

    it { should be_instance_of(described_class) }

    it { should == described_class.new }
  end
end
