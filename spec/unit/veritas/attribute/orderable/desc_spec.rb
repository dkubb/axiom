require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Attribute::Orderable, '#desc' do
  subject { object.desc }

  let(:klass)  { OrderableSpecs::Object }
  let(:object) { klass.new              }

  it { should be_kind_of(Relation::Operation::Order::Descending) }
end
