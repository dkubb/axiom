# encoding: utf-8

require 'spec_helper'

describe Relation::Empty, '.new' do
  let(:object) { described_class  }
  let(:header) { [[:id, Integer]] }

  subject { object.new(header) }

  it { should be_instance_of(object) }

  its(:header) { should == header }

  its(:tuples) { should be_empty }
end
