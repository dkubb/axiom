require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Exclusion::Methods#exclude' do
  subject { object.exclude(other) }

  let(:klass)  { ExclusionMethodsSpecs::Object }
  let(:other)  { [ true, false ]               }
  let(:object) { klass.new                     }

  it { should be_kind_of(Logic::Predicate::Exclusion) }
end
