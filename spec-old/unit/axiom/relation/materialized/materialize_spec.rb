# encoding: utf-8

require 'spec_helper'

describe Relation::Materialized, '#materialize' do
  subject { object.materialize }

  let(:object) { described_class.new([[:id, Integer]], [[1]]) }

  it { should be(object) }
end
