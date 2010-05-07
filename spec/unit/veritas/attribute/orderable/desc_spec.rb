require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Attribute::Orderable#desc' do
  subject { comparable.desc }

  let(:comparable) { OrderableSpecs::Object.new }

  it { should be_kind_of(Relation::Operation::Order::Descending) }
end
