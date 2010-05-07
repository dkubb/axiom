require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute::Time#range' do
  subject { attribute.range }

  let(:attribute) { Veritas::Attribute::Time.new(:time) }

  it { should == (Time.at(0)..Time.at(2**31-1)) }
end
