require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::NoMatch::Methods#no_match' do
  subject { object.no_match(other) }

  let(:klass)  { NoMatchMethodsSpecs::Object }
  let(:other)  { /Dan Kubb/                  }
  let(:object) { klass.new                   }

  it { should be_kind_of(Logic::Predicate::NoMatch) }
end
