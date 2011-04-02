require 'spec_helper'

describe Attribute, '#required?' do
  subject { object.required? }

  let(:klass) { Attribute::Integer }

  context 'without :required option passed to constructor' do
    let(:object) { klass.new(:id) }

    it { should be(true) }
  end

  context 'with :required => true option passed to constructor' do
    let(:object) { klass.new(:id, :required => true) }

    it { should be(true) }
  end

  context 'with :required => false option passed to constructor' do
    let(:object) { klass.new(:id, :required => false) }

    it { should be(false) }
  end
end
