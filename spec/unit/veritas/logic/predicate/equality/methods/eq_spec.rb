require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Equality::Methods#eq' do
  subject { object.eq(other) }

  let(:klass)   { EqualityMethodsSpecs::Object }
  let(:other)   { true                         }
  let(:object)  { klass.new                    }

  it { should be_kind_of(Logic::Predicate::Equality) }
end
