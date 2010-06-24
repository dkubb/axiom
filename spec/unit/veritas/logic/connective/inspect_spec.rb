require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective#inspect' do
  subject { connective.inspect }

  let(:connective) { ConnectiveSpecs::Object.new }

  specify { expect { subject }.to raise_error(NotImplementedError, 'ConnectiveSpecs::Object#inspect must be implemented') }
end
