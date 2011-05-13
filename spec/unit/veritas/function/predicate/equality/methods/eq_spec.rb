# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::Equality::Methods, '#eq' do
  subject { object.eq(other) }

  let(:described_class) { EqualityMethodsSpecs::Object }
  let(:other)           { true                         }
  let(:object)          { described_class.new          }

  it { should be_kind_of(Function::Predicate::Equality) }
end
