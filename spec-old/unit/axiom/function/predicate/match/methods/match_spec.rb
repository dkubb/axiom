# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::Match::Methods, '#match' do
  subject { object.match(other) }

  let(:object)          { described_class.new.freeze }
  let(:described_class) { MatchMethodsSpecs::Object  }
  let(:other)           { /Dan Kubb/.freeze          }

  it { should be_instance_of(Function::Predicate::Match) }

  its(:left) { should be(object) }

  its(:right) { should be(other) }
end
