# encoding: utf-8

require 'spec_helper'

describe Relation::Empty, '.new' do
  let(:object) { described_class }

  context 'with a header' do
    subject { object.new(header) }

    let(:header) { [ [ :id, Integer ] ] }

    it { should be_instance_of(object) }

    its(:header){ should == header }

    its(:tuples) { should == [] }
  end

  context 'with a header and tuples' do
    subject { object.new(header, tuples) }

    let(:header) { [ [ :id, Integer ] ] }
    let(:tuples) { mock('Tuples')       }

    it { should be_instance_of(object) }

    its(:header){ should == header }

    its(:tuples) { should equal(tuples) }
  end
end
