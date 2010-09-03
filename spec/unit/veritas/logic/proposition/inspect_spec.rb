require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Proposition#inspect' do
  subject { proposition.inspect }

  let(:proposition) { PropositionSpecs::Object.new }

  specify { expect { subject }.to raise_error(NotImplementedError, 'Veritas::Logic::Proposition.call must be implemented') }
end
