require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#inspect' do
  subject { predicate.inspect }

  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:predicate) { PredicateSpecs::Object.new(attribute, 1) }

  specify { expect { subject }.to raise_error(NotImplementedError, 'Veritas::Logic::Predicate#inspect must be implemented') }
end
