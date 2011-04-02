require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate::Inequality::Methods, '#ne' do
  subject { object.ne(other) }

  let(:klass)   { InequalityMethodsSpecs::Object }
  let(:other)   { true                           }
  let(:object)  { klass.new                      }

  it { should be_kind_of(Logic::Predicate::Inequality) }
end
