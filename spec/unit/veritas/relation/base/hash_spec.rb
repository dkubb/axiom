# encoding: utf-8

require 'spec_helper'

describe Relation::Base, '#hash' do
  subject { object.hash }

  let(:name)   { 'users'.freeze                                }
  let(:header) { Relation::Header.coerce([ [ :id, Integer ] ]) }
  let(:body)   { LazyEnumerable.new                            }
  let(:object) { described_class.new(name, header, body)       }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ header.hash ^ body.to_set.hash ^ name.hash }
end
