require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate::Inequality::Methods, '#ne' do
  subject { object.ne(other) }

  let(:described_class) { InequalityMethodsSpecs::Object }
  let(:other)           { true                           }
  let(:object)          { described_class.new            }

  it { should be_kind_of(Logic::Predicate::Inequality) }
end
