require 'spec_helper'

describe EventsController do
  let!(:event_one) { create(:event) }
  let!(:event_two) { create(:event) }
  #let(:service) { EventsController.new }
  let(:params) { {
                  event:
                    {
                      name: event_one.name,
                      description: event_one.description,
                      event_category_id: event_one.event_category_id
                    }
                  }
                }


  describe "GET 'index'" do
    context '#index' do
      it 'render the event index page' do
        get :index
        expect(response).to render_template(:index)
      end
      it "loads all of the events into @events", check: true do
        get :index
        expect(assigns(:events)).to match_array([event_one, event_two])
      end
    end
  end

  
  describe "GET 'new'" do
    before { get :new }

    context "#new" do
      it { should render_template('new') }

      it 'should initialize new event object' do
        assigns(:event).should be_a_new(Event)
      end
    end

  end

  describe "POST 'create'" do
    context '#create' do
      it 'should create a new Event' do
        post :create, params
        assigns(:event).should be_persisted
      end

    end
  end

end
