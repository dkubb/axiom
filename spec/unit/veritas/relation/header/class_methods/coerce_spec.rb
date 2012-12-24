# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '.coerce' do
  subject { object.coerce(argument) }

  let(:object) { described_class }

  context 'when the argument is a Header' do
    let(:argument) { object.new([ Attribute::Integer.new(:id) ]) }

    it { should equal(argument) }
  end

  context 'when the argument responds to #to_ary' do
    let(:argument) { [ [ :id, Integer ] ] }

    it { should be_instance_of(object) }

    it { should == argument }
  end

  context 'when the argument is not a Header and does not respond to #to_ary' do
    let(:argument) { Object.new }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
