# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::Match::Methods, '#match' do
  subject { object.match(other) }

  let(:described_class) { MatchMethodsSpecs::Object }
  let(:other)           { /Dan Kubb/                }
  let(:object)          { described_class.new       }

  it { should be_kind_of(Function::Predicate::Match) }
end
