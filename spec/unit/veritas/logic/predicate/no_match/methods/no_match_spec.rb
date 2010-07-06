require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::NoMatch::Methods#no_match' do
  subject { expression.no_match(/Dan Kubb/) }

  let(:expression) { NoMatchMethodsSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::NoMatch) }
end
