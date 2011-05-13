# encoding: utf-8

require 'spec_helper'

describe Attribute::Date, '#range' do
  subject { object.range }

  let(:object) { described_class.new(:date) }

  it { should == (Date.new..Date::Infinity.new) }
end
