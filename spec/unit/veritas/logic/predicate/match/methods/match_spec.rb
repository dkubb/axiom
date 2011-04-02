require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate::Match::Methods, '#match' do
  subject { object.match(other) }

  let(:klass)  { MatchMethodsSpecs::Object }
  let(:other)  { /Dan Kubb/                }
  let(:object) { klass.new                 }

  it { should be_kind_of(Logic::Predicate::Match) }
end
