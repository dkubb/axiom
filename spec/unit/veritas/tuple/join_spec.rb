# encoding: utf-8

require 'spec_helper'

describe Tuple, '#join' do
  subject { object.join(new_header, values) }

  let(:header)     { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:new_header) { header | [ [ :name, String ] ]             }
  let(:values)     { [ 'Dan Kubb' ]                             }
  let(:object)     { described_class.new(header, [ 1 ])         }

  it { should be_instance_of(described_class) }

  its(:header) { should equal(new_header) }

  its(:to_ary) { should == [ 1, 'Dan Kubb' ] }
end
