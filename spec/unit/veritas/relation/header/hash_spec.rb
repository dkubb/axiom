# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#hash' do
  subject { object.hash }

  let(:object)    { described_class.new([ attribute ], :keys => keys) }
  let(:attribute) { Attribute::Integer.new(:id)                       }
  let(:keys)      { Relation::Keys.new                                }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ Set[attribute].hash ^ keys.hash }
end
