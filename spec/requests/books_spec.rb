require 'rails_helper'

describe 'Books API', type: :request do
  let(:first_author) { FactoryBot.create(:author, first_name: 'George', last_name: 'Orwell', age: 60) }
  let(:second_author) { FactoryBot.create(:author, first_name: 'JK', last_name: 'Rowling', age: 78) }

  describe 'Get /Books' do
    before do
      FactoryBot.create(:book, title: '1984', author: first_author)
      FactoryBot.create(:book, title: 'HP Sorcers Stone', author: second_author)
    end
    it 'should returns all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq 2
      expect(response_body)
        .to eq(
          [{
            'id' => 1,
             'title' => '1984',
             'author_name' => 'George Orwell',
             'author_age' => 60
          },
           {
             'id' => 2,
             'title' => 'HP Sorcers Stone',
             'author_name' => 'JK Rowling',
             'author_age' => 78
           }]
            )
    end

    it 'should return a subset of the books based on pagination' do
      get '/api/v1/books', params: { limit: 1 }

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq 1
      expect(response_body)
        .to eq(
          [{
            'id' => 1,
             'title' => '1984',
             'author_name' => 'George Orwell',
             'author_age' => 60
          }]
            )
    end

    it 'should returns  number based on limit and offset' do
      get '/api/v1/books', params: { limit: 1, offset: 1 }

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq 1
      expect(response_body)
        .to eq(
          [{
            'id' => 2,
             'title' => 'HP Sorcers Stone',
             'author_name' => 'JK Rowling',
             'author_age' => 78
          }]
            )
    end
  end

  describe 'Post /Books' do
    it 'should create a new book' do
      expect do
        post '/api/v1/books', params: {
          book: { title: 'The Martian' },
          author: { first_name: 'Andy', last_name: 'Weir', age: '55' }
        }
      end.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
      expect(response_body)
        .to eq(
          {
            'id' => 1,
            'title' => 'The Martian',
            'author_name' => 'Andy Weir',
            'author_age' => 55
          }
            )
    end
  end

  describe 'DELETE /Books/:id' do
    let!(:book) { FactoryBot.create(:book, title: '1984', author: first_author) }
    it 'should delete a specific book' do
      expect {
        delete "/api/v1/books/#{book.id}"

      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
