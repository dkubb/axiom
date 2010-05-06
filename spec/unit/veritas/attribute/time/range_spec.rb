require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Time#range' do
  let(:attribute) { Veritas::Attribute::Time.new(:time) }

  subject { attribute.range }

  it { should == (Time.at(0)..Time.at(2**31-1)) }
end
