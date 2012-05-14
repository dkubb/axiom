# encoding: utf-8

require 'spec_helper'

describe Algebra::Rename::Aliases, '#inverse' do
  subject { object.inverse }

  let(:object)    { described_class.new(aliases) }
  let(:attribute) { Attribute::Integer.new(:id)  }

  context 'when aliases are empty' do
    let(:aliases) { {} }

    it_should_behave_like 'an invertible method'

    it { should be_instance_of(described_class) }

    its(:to_hash) { should == {} }
  end

  context 'when aliases are not empty' do
    let(:aliases) { { attribute => attribute.rename(:other_id) } }

    it_should_behave_like 'an invertible method'

    it { should be_instance_of(described_class) }

    its(:to_hash) { should == { attribute.rename(:other_id) => attribute } }
  end
end
