# encoding: utf-8

require 'spec_helper'

describe Aggregate::Variance, '.default' do
  subject { object.default }

  let(:object) { described_class }

  it_should_behave_like 'an idempotent method'

  it { should be_frozen }

  it { should == [ 0, nil, 0.0 ] }
end
