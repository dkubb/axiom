# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '#extend' do
  subject { object.extend(attributes) }

  let(:object)    { described_class.coerce([ header ]) }
  let(:header)    { []                                 }

  context 'with attributes that do not change the keys' do
    let(:attributes) { [] }

    it { should equal(object) }
  end

  context 'with attributes that change the keys' do
    let(:attributes) { [ :id ] }

    it { should be_instance_of(described_class) }

    it { should == [ attributes ] }
  end
end
