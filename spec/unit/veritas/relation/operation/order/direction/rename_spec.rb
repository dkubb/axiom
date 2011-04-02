require 'spec_helper'

describe Relation::Operation::Order::Direction, '#rename' do
  subject { object.rename(aliases) }

  let(:described_class) { Class.new(Relation::Operation::Order::Direction) }
  let(:attribute)       { Attribute::Integer.new(:id)                      }
  let(:header)          { Relation::Header.new([ attribute ])              }
  let(:object)          { described_class.new(attribute)                   }

  context 'with aliases matching the attribute' do
    let(:aliases) { Algebra::Rename::Aliases.coerce(header, :id => :other_id) }

    it { should be_kind_of(described_class) }

    its(:attribute) { should == attribute.rename(:other_id) }
  end

  context 'with aliases not matching the attribute' do
    let(:other_attribute) { Attribute::String.new(:name)                                        }
    let(:other_header)    { Relation::Header.new([ other_attribute ])                           }
    let(:aliases)         { Algebra::Rename::Aliases.coerce(other_header, :name => :other_name) }

    it { should equal(object) }
  end
end
