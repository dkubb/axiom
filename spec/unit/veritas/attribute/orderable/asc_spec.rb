require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::Orderable#asc' do
  subject { object.asc }

  let(:klass)  { OrderableSpecs::Object }
  let(:object) { klass.new              }

  it { should be_kind_of(Relation::Operation::Order::Ascending) }
end
