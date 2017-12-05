require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:jerry) { FactoryBot.create(:user_with_valid_password) }

  describe "POST #create" do
    context "with valid parameters" do
      it "logs in the user!" do
        post :create, params: { user: {username: 'jerry', password: 'valid_password'}}
        expect(subject.current_user).to_not be_nil
      end

      it "redirects them somewhere" do
        post :create, params: { user: {username: 'jerry', password: 'valid_password'}}
        expect(response).to redirect_to(users_url)
        expect(response).to have_http_status(302)
      end
    end

    context "with invalid params" do
      it "raises some errors" do
        post :create, params: { user: {username: 'jerry', password: 'invalid_password'}}
        expect(flash[:errors]).to be_present
        expect(response).to render_template('new')
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
        expect(response).to render_template('new')
      end
    end

    describe "GET #destroy" do
      it "logs out the user" do
        allow(subject).to receive(:current_user).and_return(jerry)
        expect(subject).to receive(:logout)
        delete :destroy
      end
    end
  end

end
