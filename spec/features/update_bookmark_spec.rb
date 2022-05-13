feature 'updating bookmarks' do
  scenario 'user can update a bookmark' do

    Bookmark.create(url: 'http://www.reddit.com/', title: 'Reddit')
    visit '/bookmarks'
    first('.bookmark').click_button 'Update'
    fill_in :title, with: 'Google'
    fill_in :url, with: 'http://www.google.com'
    click_button 'Update bookmark'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Reddit', href: 'http://www.reddit.com/')
    expect(page).to have_link('Google', href: 'http://www.google.com')
  end
end