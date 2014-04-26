# encoding: utf-8

require 'spec_helper'

describe Relation::Materialized, '#size' do
  subject { object.size }

  let(:object) { described_class.new([[:id, Integer]], [[1]]) }

  it_should_behave_like 'an idempotent method'

  it { should == 1 }
end
