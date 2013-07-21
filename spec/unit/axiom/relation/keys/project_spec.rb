# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '#project' do
  subject { object.project(attributes) }

  let(:object) { described_class.coerce([header]) }
  let(:header) { [id, name]                       }
  let(:id)     { [:id]                            }
  let(:name)   { [:name]                          }

  context 'with attributes that do not change the keys' do
    let(:attributes) { [id, name] }

    it { should equal(object) }
  end

  context 'with attributes that change the keys' do
    let(:attributes) { [id] }

    it { should be_instance_of(described_class) }

    it { should == [[id]] }
  end

  context 'with attributes that clear the keys' do
    let(:attributes) { [] }

    it { should be_instance_of(described_class) }

    it { should be_empty }
  end
end
