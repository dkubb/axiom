require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::DateTime#range' do
  let(:attribute) { Veritas::Attribute::DateTime.new(:datetime) }

  subject { attribute.range }

  it { should == (DateTime.new..DateTime::Infinity.new) }
end
