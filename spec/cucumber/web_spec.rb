require 'spec_helper'

describe Cucumber::Web do
  it 'extends paths' do
    subject.should be_a(Cucumber::Web::Paths)
  end

  it 'extends selectors' do
    subject.should be_a(Cucumber::Web::Selectors)
  end
end
