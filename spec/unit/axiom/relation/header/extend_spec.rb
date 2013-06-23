# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#extend' do
  subject { object.extend(attributes) }

  let(:object) { described_class.coerce([ [ :id, Integer ] ], keys: keys) }
  let(:keys)   { Relation::Keys.new([ described_class.new ])              }

  context 'with attribute objects' do
    let(:attributes) { [ attribute ]                }
    let(:attribute)  { Attribute::String.new(:name) }

    it { should be_instance_of(described_class) }

    it 'uses the attribute object' do
      subject[:name].should equal(attribute)
    end

    its(:to_ary) { should == [ [ :id, Integer ], [ :name, String ] ] }

    its(:keys) { should equal(keys) }
  end

  context 'with Symbol attributes' do
    let(:attributes) { [ :name ] }

    it { should be_instance_of(described_class) }

    its(:to_ary) { should == [ [ :id, Integer ], [ :name, Object ] ] }

    its(:keys) { should equal(keys) }
  end
end
