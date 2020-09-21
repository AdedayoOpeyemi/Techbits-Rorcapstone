require "application_system_test_case"

class TechbitsTest < ApplicationSystemTestCase
  setup do
    @techbit = techbits(:one)
  end

  test "visiting the index" do
    visit techbits_url
    assert_selector "h1", text: "Techbits"
  end

  test "creating a Techbit" do
    visit techbits_url
    click_on "New Techbit"

    fill_in "Bit", with: @techbit.bit
    click_on "Create Techbit"

    assert_text "Techbit was successfully created"
    click_on "Back"
  end

  test "updating a Techbit" do
    visit techbits_url
    click_on "Edit", match: :first

    fill_in "Bit", with: @techbit.bit
    click_on "Update Techbit"

    assert_text "Techbit was successfully updated"
    click_on "Back"
  end

  test "destroying a Techbit" do
    visit techbits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Techbit was successfully destroyed"
  end
end
