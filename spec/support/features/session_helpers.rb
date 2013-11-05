module Features
  module SessionHelpers

    def visit_test_location
      visit("/admin-test-location")
    end

    def visit_location_with_no_phone
      visit("/location-with-no-phone")
    end

    def add_phone_number
      click_link "Add a new number"
      fill_in "number[]", with: "7035551212"
      fill_in "vanity_number[]", with: "703555-ABCD"
      fill_in "extension[]", with: "x1223"
      fill_in "department[]", with: "CalFresh"
      click_button "Save changes"
    end

    def delete_phone_number
      click_link "Delete this number permanently"
      click_button "Save changes"
    end

    def add_contact
      click_link "Add a new contact"
      fill_in "names[]", with: "Moncef"
      fill_in "titles[]", with: "Director"
      fill_in "contact_emails[]", with: "email@email.org"
      fill_in "contact_phones[]", with: "703-555-1212"
      fill_in "contact_faxes[]", with: "703-555-1234"
      click_button "Save changes"
    end

    def delete_contact
      click_link "Delete this contact permanently"
      click_button "Save changes"
    end

    def add_fax_number
      click_link "Add a new fax number"
      fill_in "fax_number[]", with: "2025551212"
      fill_in "fax_department[]", with: "CalFresh"
      click_button "Save changes"
    end

    def add_url
      click_link "Add a new website"
      fill_in "urls[]", with: "http://monfresh.com"
      click_button "Save changes"
    end

    def add_two_urls
      click_link "Add a new website"
      fill_in "urls[]", with: "http://ruby.com"
      click_link "Add a new website"
      urls = page.all(:xpath, "//input[@type='text' and @name='urls[]']")
      fill_in urls[-1][:id], with: "http://monfresh.com"
      click_button "Save changes"
    end

    def delete_url
      click_link "Delete this website permanently"
      click_button "Save changes"
    end

    def delete_two_urls
      delete_links = all("a", :text => "Delete this website permanently")
      delete_links.each do |a|
        click_link a[:text], match: :first
      end
      click_button "Save changes"
    end

    def add_street_address
      fill_in "street", with: "modularity"
      fill_in "city", with: "utopia"
      fill_in "state", with: "XX"
      fill_in "zip", with: "12345"
      click_button "Save changes"
    end

    def remove_street_address
      fill_in "street", with: ""
      fill_in "city", with: ""
      fill_in "state", with: ""
      fill_in "zip", with: ""
      click_button "Save changes"
    end

    def add_mail_address
      fill_in "m_street", with: "modularity"
      fill_in "m_city", with: "utopia"
      fill_in "m_state", with: "XX"
      fill_in "m_zip", with: "12345"
      click_button "Save changes"
    end

    def remove_mail_address
      fill_in "m_street", with: ""
      fill_in "m_city", with: ""
      fill_in "m_state", with: ""
      fill_in "m_zip", with: ""
      click_button "Save changes"
    end

    def reset_accessibility
      within_fieldset("accessibility") do
        all('input[type=checkbox]').each do |checkbox|
          uncheck checkbox[:id]
        end
      end
      check "accessibility_restroom"
      click_button "Save changes"
    end

    def set_all_accessibility
      within_fieldset("accessibility") do
        all('input[type=checkbox]').each do |checkbox|
          check checkbox[:id]
        end
      end
      click_button "Save changes"
    end
  end
end