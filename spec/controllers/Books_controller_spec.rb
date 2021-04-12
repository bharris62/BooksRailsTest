require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  it 'should have a max limt of 100' do
    expect(Book).to receive(:limit).with(100).and_call_original

    get :index, params: {limit: 999}

  end
end