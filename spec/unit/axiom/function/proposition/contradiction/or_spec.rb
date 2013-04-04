# encoding: utf-8

require 'spec_helper'

describe Function::Proposition::Contradiction, '#or' do
  subject { object.or(other) }

  let(:other)  { mock('other')            }
  let(:object) { described_class.instance }

  it { should equal(other) }
end
