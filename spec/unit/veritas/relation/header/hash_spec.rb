require 'spec_helper'

describe Relation::Header, '#hash' do
  subject { object.hash }

  let(:attributes) { [ Attribute::Integer.new(:id) ] }
  let(:object)     { described_class.new(attributes) }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ attributes.hash }
end
