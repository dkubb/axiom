# encoding: utf-8

require 'spec_helper'

describe Tuple, '#inspect' do
  subject { object.inspect }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { described_class.new(header, [ 1 ])         }

  it { should be_instance_of(String) }

  it { should == '{<Veritas::Attribute::Integer name: id>=>1}' }
end
