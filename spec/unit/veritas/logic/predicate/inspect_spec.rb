require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#inspect' do
  subject { object.inspect }

  let(:klass)     { PredicateSpecs::Object      }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:object)    { klass.new(attribute, 1)     }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{klass}#inspect must be implemented") }
end
