require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe "Noth authorized" do
    context "#index" do
      it 'respond successfully' do
        get :index
        expect(response).to be_success
      end

      it 'respond a 200 response' do
        get :index
        expect(response).to have_http_status(200)
      end
    end

    context "#show" do
      it 'respond a 302 response (not authorized)' do
        customer = create(:customer)
        get :show, params: { id: customer.id }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "Authorized" do
    before do
      @member = create(:member)
      @customer = create(:customer)
    end

    it 'Routes' do
      is_expected.to route(:get, '/customers').to(action: :index)
    end

    it 'Content-Type JSON' do
      customer_params = attributes_for(:customer)
      sign_in @member

      post :create, format: :json, params: { customer: customer_params }
      expect(response.content_type).to eq('application/json')
    end

    it 'with a valid attributes' do
      customer_params = attributes_for(:customer)
      sign_in @member

      expect{
        post :create, params: { customer: customer_params }
      }.to change(Customer, :count).by(1)
    end

    it 'with a invalid attributes' do
      customer_params = attributes_for(:customer, address: nil)
      sign_in @member

      expect{
        post :create, params: { customer: customer_params }
      }.not_to change(Customer, :count)
    end

    it 'Flash Notices' do
      customer_params = attributes_for(:customer)
      sign_in @member

      post :create, params: { customer: customer_params }
      expect(flash[:notice]).to match(/successfully created/)
    end

    it '#show authenticate' do
      sign_in @member

      get :show, params: { id: @customer.id }
      expect(response).to have_http_status(200)
    end

    it 'render a :show template' do
      sign_in @member

      get :show, params: { id: @customer.id }
      expect(response).to render_template(:show)
    end
  end
end
