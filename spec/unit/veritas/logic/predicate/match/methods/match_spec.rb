require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate::Match::Methods#match' do
  subject { expression.match(/Dan Kubb/) }

  let(:expression) { MatchMethodsSpecs::Object.new }

  it { should be_kind_of(Logic::Predicate::Match) }
end
