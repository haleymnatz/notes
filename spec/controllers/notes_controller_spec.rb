require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  describe 'notes#index action' do
    it 'should successfully respond' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'notes#create action' do
    before do
      post :create, params: { note: { title: 'Second', content: 'BOO!' } }
    end

    it 'should return 200 startus-code' do
      expect(response).to be_success
    end

    it 'should successfully create and save a new note in the database' do
      note = Note.last
      expect(note.content).to eq('BOO!')
      expect(note.title).to eq('Second')
    end

    it 'should return the create note in response body' do
      json = JSON.parse(response.body)
      expect(json['content']).to eq('BOO!')
      expect(json['title']).to eq('Second')
    end
  end
end
