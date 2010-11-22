require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#inspect' do
  subject { object.inspect }

  let(:klass)  { ExpressionSpecs::Object }
  let(:object) { klass.new               }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{klass}#inspect must be implemented") }
end
