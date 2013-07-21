# encoding: utf-8

require 'spec_helper'

describe Relation::Empty, '#empty?' do
  subject { object.empty? }

  let(:object) { described_class.new([[:id, Integer]]) }

  it { should be(true) }
end
