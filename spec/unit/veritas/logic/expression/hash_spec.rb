require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Expression, '#hash' do
  subject { object.hash }

  let(:klass)  { ExpressionSpecs::Object }
  let(:object) { klass.new               }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{klass}#hash must be implemented") }
end
