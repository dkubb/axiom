require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Attribute::Orderable, '#asc' do
  subject { object.asc }

  let(:described_class) { OrderableSpecs::Object }
  let(:object)          { described_class.new    }

  it { should be_kind_of(Relation::Operation::Order::Ascending) }
end
