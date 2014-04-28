require 'spec_helper'

describe EventsController do
  let!(:event) { create(:event) }
  let(:service) { EventsController.new }
  let(:params) { {} }
  before do
    params.merge!({
                    event: {
                        name: event.name,
                        description: event.description,
                        event_category_id: event.event_category_id
                    }
                  })
  end

  context "#create" do
    context 'when event created' do
      let!(:created_event) { service.create(params) }
      it 'should have name' do
        expect(created_event.name).to eql(params[:event][:name])
      end
      #it 'should have description' do
      #  expect(created_event.description).to eql(params[:event][:description])
      #end
      #it 'should have event_category_id' do
      #  expect(created_event.event_category_id).to eql(params[:event][:event_category_id])
      #end
    end
  end

  describe "GET 'index'" do
    it "should returns event collection" do
      get 'index'
      response.should be_success
    end
  end

  #describe "GET 'new'" do
  #  it "returns http success" do
  #    get 'new'
  #    response.should be_success
  #  end
  #end
  #
  #describe "GET 'edit'" do
  #  it "returns http success" do
  #    get 'edit'
  #    response.should be_success
  #  end
  #end
  #
  #describe "GET 'show'" do
  #  it "returns http success" do
  #    get 'show'
  #    response.should be_success
  #  end
  #end

end
