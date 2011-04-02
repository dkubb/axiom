require 'spec_helper'

describe Attribute::DateTime, '#range' do
  subject { object.range }

  let(:object) { described_class.new(:datetime) }

  it { should == (DateTime.new..DateTime::Infinity.new) }
end
