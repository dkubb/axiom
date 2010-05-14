require 'spec_helper'

describe 'Veritas::Attribute#inspect' do
  subject { attribute.inspect }

  let(:attribute) { Attribute::Integer.new(:id) }

  it { should be_kind_of(String) }

  it { should == '<Attribute::Integer name: id>' }
end
