require 'spec_helper'

describe 'Veritas::Attribute::DateTime#range' do
  subject { attribute.range }

  let(:attribute) { Veritas::Attribute::DateTime.new(:datetime) }

  it { should == (DateTime.new..DateTime::Infinity.new) }
end
