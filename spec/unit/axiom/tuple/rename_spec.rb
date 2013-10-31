# encoding: utf-8

require 'spec_helper'

describe Tuple, '#rename' do
  subject { object.rename(new_header) }

  let(:object)     { described_class.new(header, [1])                }
  let(:header)     { Relation::Header.coerce([[:id, Integer]])       }
  let(:new_header) { Relation::Header.coerce([[:other_id, Integer]]) }

  it { should be_instance_of(described_class) }

  its(:header) { should be(new_header) }

  its(:to_ary) { should == [1] }
end
