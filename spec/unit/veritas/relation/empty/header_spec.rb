# encoding: utf-8

require 'spec_helper'

describe Relation::Empty, '#header' do
  subject { object.header }

  let(:header) { Relation::Header.coerce([ [ :id, Integer ] ]) }
  let(:object) { described_class.new(header)                   }

  it_should_behave_like 'an idempotent method'

  it { should equal(header) }
end
