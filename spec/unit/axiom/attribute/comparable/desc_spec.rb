# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Attribute::Comparable, '#desc' do
  subject { object.desc }

  let(:described_class) { ComparableSpecs::Object }
  let(:object)          { described_class.new     }

  it { should be_instance_of(Relation::Operation::Order::Descending) }
end
