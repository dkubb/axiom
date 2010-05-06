require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::Orderable#desc' do
  let(:comparable) { OrderableSpecs::Object.new }

  subject { comparable.desc }

  it { should be_kind_of(Relation::Operation::Order::Descending) }
end
