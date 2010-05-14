require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::Orderable#asc' do
  subject { comparable.asc }

  let(:comparable) { OrderableSpecs::Object.new }

  it { should be_kind_of(Relation::Operation::Order::Ascending) }
end
