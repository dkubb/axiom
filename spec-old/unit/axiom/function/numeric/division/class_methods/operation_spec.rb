# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::Division, '.operation' do
  subject { object.operation }

  let(:object) { described_class }

  it { should be(:/) }
end
