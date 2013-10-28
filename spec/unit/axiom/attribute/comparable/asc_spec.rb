# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Attribute::Comparable, '#asc' do
  subject { object.asc }

  let(:object)          { described_class.new     }
  let(:described_class) { ComparableSpecs::Object }

  it { should be_instance_of(Relation::Operation::Sorted::Ascending) }

  its(:attribute) { should be(object) }
end
