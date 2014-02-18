require 'ctlr_test_helper'

class HomeControllerTest < ActionController::TestCase
    
  context 'home ctlr' do
    setup do
      Tenant.set_current_tenant( tenants( :tenant_1 ).id )
    end

  should "get index" do
    get :index
    assert_response :success
  end

  should "get show with login" do
    sign_in( users( :quentin ) )
    get :show
    assert_response :success
    sign_out( users( :quentin ) )
  end  # should do

  should 'not get show without login' do
    assert_raise(ArgumentError, 'uncaught throw :warden'){
      get :show
    }
    assert_response :success
  end  # should do

  should 'reset tenant' do
    assert Tenant.current_tenant_id
    @controller = ApplicationController.new
    @controller.instance_eval{ __milia_reset_tenant! }   # invoke the private method
    assert_nil Tenant.current_tenant_id

  end  # should do

  end  # context

end  # end class test
