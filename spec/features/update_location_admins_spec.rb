require "spec_helper"

feature "Update a location's admins", :vcr do
  background do
    login_admin
  end

  scenario "when location doesn't have any admins" do
    visit_location_with_no_phone
    page.should have_no_selector(
      :xpath, "//input[@type='text' and @name='admin_emails[]']")
  end

  scenario "by adding 2 new admins", :js => true do
    visit_location_with_no_phone
    add_two_admins
    visit_location_with_no_phone
    total_admins = page.
      all(:xpath, "//input[@type='text' and @name='admin_emails[]']")
    total_admins.length.should eq 2
    delete_all_admins
    visit_location_with_no_phone
    page.should have_no_selector(
      :xpath, "//input[@type='text' and @name='admin_emails[]']")
  end

  scenario "with empty admin", :js => true do
    visit_test_location
    click_link "Add an admin"
    page.should have_selector(
      :xpath, "//input[@type='text' and @name='admin_emails[]']")
    click_button "Save changes"
    visit_test_location
    page.should have_no_selector(
      :xpath, "//input[@type='text' and @name='admin_emails[]']")
  end

  scenario "with 2 admins but one is empty", :js => true do
    visit_test_location
    click_link "Add an admin"
    fill_in "admin_emails[]", with: "moncef@samaritanhousesanmateo.org"
    click_link "Add an admin"
    click_button "Save changes"
    visit_test_location
    total_admins = page.
      all(:xpath, "//input[@type='text' and @name='admin_emails[]']")
    total_admins.length.should eq 1
    delete_admin
  end

  scenario "with valid admin", :js => true do
    visit_test_location
    click_link "Add an admin"
    fill_in "admin_emails[]", with: "moncef@samaritanhousesanmateo.org"
    click_button "Save changes"
    visit_test_location
    find_field('admin_emails[]').value.should eq "moncef@samaritanhousesanmateo.org"
    delete_admin
  end

  scenario "with invalid admin", :js => true do
    visit_test_location
    click_link "Add an admin"
    fill_in "admin_emails[]", with: "moncefsamaritanhousesanmateo.org"
    click_button "Save changes"
    expect(page).to have_content "Please enter a valid admin email address"
  end
end