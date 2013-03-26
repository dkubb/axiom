# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::NoMatch::Methods, '#no_match' do
  subject { object.no_match(other) }

  let(:described_class) { NoMatchMethodsSpecs::Object }
  let(:other)           { /Dan Kubb/                  }
  let(:object)          { described_class.new         }

  it { should be_instance_of(Function::Predicate::NoMatch) }
end
