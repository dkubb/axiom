require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Exclusion::Methods#exclude' do
  subject { expression.exclude(enumerable) }

  let(:expression) { ExclusionMethodsSpecs::Object.new }
  let(:enumerable) { [ true, false ]                   }

  it { should be_kind_of(Logic::Predicate::Exclusion) }
end
