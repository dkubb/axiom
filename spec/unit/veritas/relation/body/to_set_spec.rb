require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Body#to_set' do
  before do
    header = mock('Header')

    @tuple = mock('Tuple')
    @body  = Relation::Body.new(header, [ @tuple ])
  end

  subject { @body.to_set }

  it { should be_kind_of(Set) }

  it { should == Set[ @tuple ] }
end
