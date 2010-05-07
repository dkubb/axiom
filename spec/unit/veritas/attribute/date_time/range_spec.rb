require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::DateTime#range' do
  subject { attribute.range }

  let(:attribute) { Veritas::Attribute::DateTime.new(:datetime) }

  it { should == (DateTime.new..DateTime::Infinity.new) }
end
