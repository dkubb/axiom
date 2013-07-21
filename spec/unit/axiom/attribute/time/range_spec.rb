# encoding: utf-8

require 'spec_helper'

describe Attribute::Time, '#range' do
  subject { object.range }

  let(:object) { described_class.new(:time) }

  it { should == (Time.at(0)..Time.at(2**31 - 1)) }
end
