require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::Orderable#desc' do
  subject { comparable.desc }

  let(:comparable) { OrderableSpecs::Object.new }

  it { should be_kind_of(Relation::Operation::Order::Descending) }
end
