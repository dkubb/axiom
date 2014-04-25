# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Sorted::Descending, '.reverse' do
  subject { object.reverse }

  let(:object) { described_class }

  it { should be(Relation::Operation::Sorted::Ascending) }
end
