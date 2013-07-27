# encoding: utf-8

require 'spec_helper'

describe Relation::Base, '#name' do
  subject { object.name }

  let(:object) { described_class.new(name, header, body) }
  let(:name)   { :users                                  }
  let(:header) { [[:id, Integer]]                        }
  let(:body)   { LazyEnumerable.new([[1]])               }

  it_should_behave_like 'an idempotent method'

  it { should equal(name) }
end
