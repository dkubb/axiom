# encoding: utf-8

require 'spec_helper'

describe Tuple, '.coerce' do
  subject { object.coerce(header, argument) }

  let(:header) { Relation::Header.coerce([[:id, Integer]]) }
  let(:object) { described_class                           }
  let(:tuple)  { object.new(header, [1])                   }

  context 'when the argument is a Tuple' do
    let(:argument) { tuple }

    it { should be(argument) }
  end

  context 'when the argument responds to #to_ary' do
    let(:argument) { [1] }

    it { should be_instance_of(object) }

    it { should eql(tuple) }
  end

  context 'when the argument is not a Tuple and does not respond to #to_ary' do
    let(:argument) { { id: 1 } }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
