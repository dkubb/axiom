# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#project' do
  subject { object.project(attributes) }

  let(:attributes) { [ :id ]                                                      }
  let(:object)     { described_class.new([ [ :id, Integer ], [ :name, String ] ]) }

  it { should be_kind_of(described_class) }

  it { should == [ [ :id, Integer ] ] }
end
