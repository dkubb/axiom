# encoding: utf-8

require 'spec_helper'

describe Algebra::Rename::Aliases, '#hash' do
  subject { object.hash }

  let(:attribute) { Attribute::Integer.new(:id)                  }
  let(:aliases)   { { attribute => attribute.rename(:other_id) } }
  let(:object)    { described_class.new(aliases)                 }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ aliases.hash }
end
