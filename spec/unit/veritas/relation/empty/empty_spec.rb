require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#empty?' do
  before do
    @empty = Relation::Empty.new([ [ :id, Integer ] ])
  end

  subject { @empty.empty? }

  it { should be_true }
end
