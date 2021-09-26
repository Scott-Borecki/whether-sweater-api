require 'rails_helper'

# See spec/support/shared_examples/requests/ for shared examples
# See spec/support/helpers/requests/request_spec_helper.rb for #json helper method
describe 'Api::V1::Users API', type: :request do
  describe 'POST /api/v1/users' do
    let(:email) { 'whatever@example.com' }
    let(:password) { 'password' }

    context 'when I provide valid parameters' do
      let(:valid_parameters) do
        {
          email: email,
          password: password,
          password_confirmation: password
        }
      end

      before { post '/api/v1/users', params: valid_parameters }

      it 'sends the parameters in the body (not as query params)' do
        expect(request.fullpath).to eq('/api/v1/users')
      end

      it "returns the user's email and api key" do
        expect(json[:data][:type]).to eq('user')
        expect(json[:data][:id]).to be_a(String)
        expect(json[:data][:attributes][:email]).to eq(email)
        expect(json[:data][:attributes][:api_key]).to eq(User.last.api_key)
      end

      include_examples 'compliant json data format'
      include_examples 'status code 201'
    end

    context 'when I do not provide valid parameters' do
      context 'when the passwords do not match' do
        let(:invalid_parameters) do
          {
            email: email,
            password: password.upcase,
            password_confirmation: password
          }
        end

        before { post '/api/v1/users', params: invalid_parameters }

        it 'returns a heplful error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq("Your record could not be saved: Password confirmation doesn't match Password")
        end

        include_examples 'compliant json error format'
        include_examples 'status code 422'
      end

      context 'when the email is not unique' do
        let!(:registered_user) { create(:user, email: email) }
        let(:invalid_parameters) do
          {
            email: email,
            password: password,
            password_confirmation: password
          }
        end

        before { post '/api/v1/users', params: invalid_parameters }

        it 'returns a heplful error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq('Your record could not be saved: Email has already been taken')
        end

        include_examples 'compliant json error format'
        include_examples 'status code 422'
      end

      context 'when the password confirmation is missing' do
        let(:invalid_parameters) do
          {
            email: email,
            password: password
          }
        end

        before { post '/api/v1/users', params: invalid_parameters }

        it 'returns a heplful error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq("Your record could not be saved: Password confirmation can't be blank")
        end

        include_examples 'compliant json error format'
        include_examples 'status code 422'
      end

      context 'when the email is missing' do
        let(:invalid_parameters) do
          {
            password: password,
            password_confirmation: password
          }
        end

        before { post '/api/v1/users', params: invalid_parameters }

        it 'returns a heplful error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq("Your record could not be saved: Email can't be blank")
        end

        include_examples 'compliant json error format'
        include_examples 'status code 422'
      end

      context 'when the password is missing' do
        let(:invalid_parameters) do
          {
            email: email,
            password_confirmation: password
          }
        end

        before { post '/api/v1/users', params: invalid_parameters }

        it 'returns a heplful error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq("Your record could not be saved: Password can't be blank")
        end

        include_examples 'compliant json error format'
        include_examples 'status code 422'
      end
    end
  end
end
