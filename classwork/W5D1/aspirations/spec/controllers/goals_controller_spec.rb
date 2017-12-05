require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  before(:each) do
    sign_in_at_controller
  end
  
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      
      it "creates a new goal for current user" do
        post :create, params: { goal: { goal: 'be better' } }
        expect(subject.current_user.goals).to include(Goal.last)
        expect(subject.current_user).to_not be_nil
        expect(response).to have_http_status(302)
      end
      
      it "redirects to users profile" do
        post :create, params: { goal: { goal: 'be better' } }
        expect(response).to redirect_to(user_url(subject.current_user))
      end
    end
    
    context "with invalid params" do
      it "renders new page and has errors" do
        post :create, params: { goal: {goal: ''} }
        expect(flash[:errors]).to be_present
        expect(response).to render_template('new')
      end
    end
  end
  
  before(:each) do
    Goal.create!(goal: 'be better', user_id: subject.current_user.id)
  end
  
  describe "GET #destroy" do
    it "destroys goal" do
      delete :destroy, params: { id: Goal.last.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_url(subject.current_user))
    end
  end
  
  describe "GET #edit" do
    it "renders edit template" do
      get :edit, params: { id: Goal.last.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end
  
  describe "GET #update" do
    context "with valid params" do
      it "redirects to user profile after updating comment" do
        post :update, params: { goal: { goal: 'be betterer' }, id: Goal.last.id }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(user_url(subject.current_user))
      end
    end
    
    context "with invalid params" do
      it "renders edit page and has errors" do
        post :update, params: { id: Goal.last.id, goal: {goal: ''} }
        expect(flash[:errors]).to be_present
        expect(response).to render_template('edit')
      end
    end
  end
end
