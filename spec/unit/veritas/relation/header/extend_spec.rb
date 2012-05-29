# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#extend' do
  subject { object.extend(attributes) }

  let(:object) { described_class.new([ [ :id, Integer ], [ :name, String ] ]) }

  context 'with Symbol attributes' do
    let(:attributes) { [ :age ] }

    it { should be_instance_of(described_class) }

    it 'coerces and appends attributes' do
      should == [ [ :id, Integer ], [ :name, String ], [ :age, Object ] ]
    end
  end

  context 'with attribute objects' do
    let(:attributes) { [ attribute ]                }
    let(:attribute)  { Attribute::Integer.new(:age) }

    it { should be_instance_of(described_class) }

    it 'uses the attribute object' do
      subject[:age].should equal(attribute)
    end

    it 'appends attributes' do
      should == [ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ]
    end
  end
end
