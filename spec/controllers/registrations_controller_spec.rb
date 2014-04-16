require 'spec_helper'
require 'faker'

describe RegistrationsController do
  describe "GET #index" do
    it "populates an array of registrations"
    it "renders the :index view"
  end

  describe "GET #new" do
    it "assigns a new registration to @registration"
    it "renders the :new template"
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new registration in the database"
      it "redirects to the home page"
    end
    context "with invalid attributes" do
      it "does not save the new registration in the database"
      it "re-renders the :new template"
    end
  end
end
