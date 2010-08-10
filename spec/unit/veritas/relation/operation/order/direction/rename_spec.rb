require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Direction#rename' do
  subject { direction.rename(aliases) }

  let(:attribute) { Attribute::Integer.new(:id)                      }
  let(:klass)     { Class.new(Relation::Operation::Order::Direction) }
  let(:direction) { klass.new(attribute)                             }

  context 'with aliases matching the attribute' do
    let(:aliases) { { attribute => attribute.rename(:other_id) } }

    it { should be_kind_of(klass) }

    it { should eql(klass.new(Attribute::Integer.new(:other_id))) }
  end

  context 'with aliases not matching the attribute' do
    let(:other_attribute) { Attribute::String.new(:name)                               }
    let(:aliases)         { { other_attribute => other_attribute.rename(:other_name) } }

    it { should be_kind_of(klass) }

    it { should equal(direction) }
  end
end
