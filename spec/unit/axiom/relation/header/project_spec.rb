# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#project' do
  subject { object.project(attributes) }

  let(:object) { described_class.coerce([ [ :id, Integer ], [ :name, String ] ], keys: keys)             }
  let(:keys)   { Relation::Keys.new([ described_class.coerce([ [ :id, Integer ], [ :name, String ] ]) ]) }

  context 'with attribute objects' do
    let(:attributes) { [ attribute ]               }
    let(:attribute)  { Attribute::Integer.new(:id) }

    it { should be_instance_of(described_class) }

    it 'uses the attribute object' do
      subject[:id].should equal(attribute)
    end

    its(:to_ary) { should == [ [ :id, Integer ] ] }

    its(:keys) { should eql(Relation::Keys.new([ described_class.coerce([ [ :id, Integer ] ]) ])) }
  end

  context 'with Symbol attributes' do
    let(:attributes) { [ :id ] }

    it { should be_instance_of(described_class) }

    its(:to_ary) { should == [ [ :id, Integer ] ] }

    its(:keys) { should eql(Relation::Keys.new([ described_class.coerce([ [ :id, Integer ] ]) ])) }
  end

  context 'when the header has no keys' do
    let(:keys)       { Relation::Keys.new }
    let(:attributes) { [ :id ]            }

    it { should be_instance_of(described_class) }

    its(:to_ary) { should == [ [ :id, Integer ] ] }

    its(:keys) { should be_empty }
  end
end
