# encoding: utf-8

require 'spec_helper'

describe Tuple, '#hash' do
  subject { object.hash }

  let(:header) { Relation::Header.coerce([ [ :id, Integer ] ]) }
  let(:data)   { [ 1 ]                                         }
  let(:object) { described_class.new(header, data)             }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ Hash[header.zip(data)].hash }
end
