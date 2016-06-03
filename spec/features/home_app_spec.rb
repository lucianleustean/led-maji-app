require 'spec_helper'

describe 'Home page' do
  before do
    visit '/index.html'
  end

  it 'shows the application name' do
    expect(page).to have_text 'led-app'
  end
end
