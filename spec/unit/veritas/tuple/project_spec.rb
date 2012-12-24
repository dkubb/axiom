# encoding: utf-8

require 'spec_helper'

describe Tuple, '#project' do
  subject { object.project(reversed_header) }

  let(:header)          { Relation::Header.coerce([ [ :name, String ], [ :id, Integer ] ]) }
  let(:reversed_header) { Relation::Header.new(header.to_a.reverse)                        }
  let(:object)          { described_class.new(header, [ 'Dan Kubb', 1 ])                   }

  it { should be_instance_of(described_class) }

  its(:header) { should equal(reversed_header) }

  its(:to_ary) { should == [ 1, 'Dan Kubb' ] }
end
