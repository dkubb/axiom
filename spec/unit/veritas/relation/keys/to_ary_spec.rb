# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '#to_ary' do
  subject { object.to_ary }

  let(:object) { described_class.coerce([ header ]) }
  let(:header) { [ [ :id ] ]                        }

  it { should be_instance_of(Array) }

  it { should == [ header ] }

  it { should be_frozen }
end
