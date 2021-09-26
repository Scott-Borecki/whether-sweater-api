require 'rails_helper'

describe 'Api::V1::Users API', type: :request do
  describe 'POST /api/v1/users' do
    context 'when I provide valid parameters' do
      let(:valid_parameters) do
        {
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "password"
        }
      end

      before { post '/api/v1/users', params: valid_parameters }

      it 'sends the parameters in the body (not as query params)' do
        expect(request.fullpath).to eq('/api/v1/users')
      end

      it 'returns the user in JSON:API compliable format' do
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:data]).to be_a(Hash)
        expect(json[:data].size).to eq(3)
        expect(json[:data][:type]).to eq('user')
        expect(json[:data][:id]).to be_a(String)
        expect(json[:data][:attributes]).to be_a(Hash)
        expect(json[:data][:attributes][:email]).to be_a(String)
        expect(json[:data][:attributes][:api_key]).to be_a(String)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when I do not provide valid parameters' do
      context 'when the passwords do not match' do
        let(:invalid_parameters) do
          {
            "email": "whatever@example.com",
            "password": "Password",
            "password_confirmation": "password"
          }
        end

        before { post '/api/v1/users', params: invalid_parameters }

        it 'returns an error message' do
          json = JSON.parse(response.body, symbolize_names: true)

          expect(json).to be_a(Hash)
          expect(json).to have_key(:errors)
          expect(json[:errors]).to be_an(Array)
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first).to be_a(Hash)
          expect(json[:errors].first.size).to eq(3)
          expect(json[:errors].first[:status]).to eq('422')
          expect(json[:errors].first[:title]).to eq('Unprocessable Entity')
          expect(json[:errors].first[:detail]).to eq("Your record could not be saved: Password confirmation doesn't match Password")
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when the email is not unique' do
        let!(:registered_user) { create(:user, email: "whatever@example.com") }
        let(:invalid_parameters) do
          {
            "email": "whatever@example.com",
            "password": "password",
            "password_confirmation": "password"
          }
        end

        before { post '/api/v1/users', params: invalid_parameters }

        it 'returns an error message' do
          json = JSON.parse(response.body, symbolize_names: true)

          expect(json).to be_a(Hash)
          expect(json).to have_key(:errors)
          expect(json[:errors]).to be_an(Array)
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first).to be_a(Hash)
          expect(json[:errors].first.size).to eq(3)
          expect(json[:errors].first[:status]).to eq('422')
          expect(json[:errors].first[:title]).to eq('Unprocessable Entity')
          expect(json[:errors].first[:detail]).to eq("Your record could not be saved: Email has already been taken")
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when the password confirmation is missing' do
        let(:invalid_parameters) do
          {
            "email": "whatever@example.com",
            "password": "password"
          }
        end

        before { post '/api/v1/users', params: invalid_parameters }

        it 'returns an error message' do
          json = JSON.parse(response.body, symbolize_names: true)

          expect(json).to be_a(Hash)
          expect(json).to have_key(:errors)
          expect(json[:errors]).to be_an(Array)
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first).to be_a(Hash)
          expect(json[:errors].first.size).to eq(3)
          expect(json[:errors].first[:status]).to eq('422')
          expect(json[:errors].first[:title]).to eq('Unprocessable Entity')
          expect(json[:errors].first[:detail]).to eq("Your record could not be saved: Password confirmation can't be blank")
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when the email is missing' do
        let(:invalid_parameters) do
          {
            "password": "password",
            "password_confirmation": "password"
          }
        end

        before { post '/api/v1/users', params: invalid_parameters }

        it 'returns an error message' do
          json = JSON.parse(response.body, symbolize_names: true)

          expect(json).to be_a(Hash)
          expect(json).to have_key(:errors)
          expect(json[:errors]).to be_an(Array)
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first).to be_a(Hash)
          expect(json[:errors].first.size).to eq(3)
          expect(json[:errors].first[:status]).to eq('422')
          expect(json[:errors].first[:title]).to eq('Unprocessable Entity')
          expect(json[:errors].first[:detail]).to eq("Your record could not be saved: Email can't be blank")
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when the password is missing' do
        let(:invalid_parameters) do
          {
            "email": "whatever@example.com",
            "password_confirmation": "password"
          }
        end

        before { post '/api/v1/users', params: invalid_parameters }

        it 'returns an error message' do
          json = JSON.parse(response.body, symbolize_names: true)

          expect(json).to be_a(Hash)
          expect(json).to have_key(:errors)
          expect(json[:errors]).to be_an(Array)
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first).to be_a(Hash)
          expect(json[:errors].first.size).to eq(3)
          expect(json[:errors].first[:status]).to eq('422')
          expect(json[:errors].first[:title]).to eq('Unprocessable Entity')
          expect(json[:errors].first[:detail]).to eq("Your record could not be saved: Password can't be blank")
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
