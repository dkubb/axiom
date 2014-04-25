# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Absolute, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:abs) }
end
