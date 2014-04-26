# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '#rename' do
  subject { object.rename(aliases) }

  let(:object)  { described_class.coerce([header1, header2])              }
  let(:header1) { [[:id, Integer]]                                        }
  let(:header2) { [[:name, String]]                                       }
  let(:aliases) { Algebra::Rename::Aliases.coerce(header1, id: :other_id) }

  it { should be_instance_of(described_class) }

  it { should == [[[:other_id, Integer]], header2] }
end
