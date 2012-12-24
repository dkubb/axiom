# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#extend' do
  subject { object.extend(attributes) }

  let(:object) { described_class.coerce([ [ :id, Integer ], [ :name, String ] ]) }

  context 'with attribute objects' do
    let(:attributes) { [ attribute ]                }
    let(:attribute)  { Attribute::Integer.new(:age) }

    it { should be_instance_of(described_class) }

    it 'uses the attribute object' do
      subject[:age].should equal(attribute)
    end

    its(:to_ary) { should == [ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ] }
  end

  context 'with Symbol attributes' do
    let(:attributes) { [ :age ] }

    it { should be_instance_of(described_class) }

    its(:to_ary) { should == [ [ :id, Integer ], [ :name, String ], [ :age, Object ] ] }
  end
end
