# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::Exclusion::Methods, '#exclude' do
  subject { object.exclude(other) }

  let(:object)          { described_class.new.freeze    }
  let(:described_class) { ExclusionMethodsSpecs::Object }
  let(:other)           { [true, false].freeze          }

  it { should be_instance_of(Function::Predicate::Exclusion) }

  its(:left) { should be(object) }

  its(:right) { should be(other) }
end
