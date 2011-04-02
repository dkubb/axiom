require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate::NoMatch::Methods, '#no_match' do
  subject { object.no_match(other) }

  let(:described_class) { NoMatchMethodsSpecs::Object }
  let(:other)           { /Dan Kubb/                  }
  let(:object)          { described_class.new         }

  it { should be_kind_of(Logic::Predicate::NoMatch) }
end
