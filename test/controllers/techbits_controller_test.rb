require 'test_helper'

class TechbitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @techbit = techbits(:one)
  end

  test 'should get index' do
    get techbits_url
    assert_response :success
  end

  test 'should get new' do
    get new_techbit_url
    assert_response :success
  end

  test 'should create techbit' do
    assert_difference('Techbit.count') do
      post techbits_url, params: { techbit: { bit: @techbit.bit } }
    end

    assert_redirected_to techbit_url(Techbit.last)
  end

  test 'should show techbit' do
    get techbit_url(@techbit)
    assert_response :success
  end

  test 'should get edit' do
    get edit_techbit_url(@techbit)
    assert_response :success
  end

  test 'should update techbit' do
    patch techbit_url(@techbit), params: { techbit: { bit: @techbit.bit } }
    assert_redirected_to techbit_url(@techbit)
  end

  test 'should destroy techbit' do
    assert_difference('Techbit.count', -1) do
      delete techbit_url(@techbit)
    end

    assert_redirected_to techbits_url
  end
end
