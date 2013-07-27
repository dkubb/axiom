# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '.coerce' do
  subject { object.coerce(argument) }

  let(:object) { described_class }

  context 'when the arguments are Keys' do
    let(:argument) { object.new([[[:id]]]) }

    it { should be(argument) }
  end

  context 'when the argument responds to #to_ary' do
    let(:argument) { [[[:id]]] }

    it { should be_instance_of(object) }

    it { should == [Relation::Header.coerce([:id])] }
  end

  context 'when the argument is not a Keys and does not respond to #to_ary' do
    let(:argument) { Object.new }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
