# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate, '#inverse' do
  subject { object.inverse }

  let(:object) { described_class.new(1, 1) }

  specify { expect { subject }.to raise_error(NoMethodError) }

  it 'calls the class inverse method' do
    described_class.should_receive(:inverse).and_return(described_class)
    should eql(object)
  end
end
