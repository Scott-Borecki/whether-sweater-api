require 'rails_helper'

# See spec/support/shared_examples/requests/ for shared examples
# See spec/support/helpers/requests/request_spec_helper.rb for #json helper method
describe 'Api::V1::Sessions API', type: :request do
  describe 'POST /api/v1/sessions' do
    let!(:user) { create(:user, email: email, password: password) }
    let(:email) { 'whatever@example.com' }
    let(:password) { 'password' }

    context 'when I provide valid parameters' do
      let(:valid_parameters) { { email: email, password: password } }

      before { post '/api/v1/sessions', params: valid_parameters }

      it 'sends the parameters in the body (not as query params)' do
        expect(request.fullpath).to eq('/api/v1/sessions')
      end

      it "returns the user's email and api key" do
        expect(json[:data][:type]).to eq('user')
        expect(json[:data][:id]).to be_a(String)
        expect(json[:data][:attributes][:email]).to eq(email)
        expect(json[:data][:attributes][:api_key]).to eq(user.api_key)
      end

      include_examples 'compliant json data format'
      include_examples 'status code 200'
    end

    context 'when I do not provide valid parameters' do
      context 'when the password is incorrect' do
        let(:invalid_parameters) { { email: email, password: password.upcase } }

        before { post '/api/v1/sessions', params: invalid_parameters }

        it 'returns a heplful error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq('You have entered an invalid email or password')
        end

        include_examples 'compliant json error format'
        include_examples 'status code 403'
      end

      context 'when the email is missing' do
        let(:invalid_parameters) { { password: password } }

        before { post '/api/v1/sessions', params: invalid_parameters }

        it 'returns a heplful error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq('You have entered an invalid email or password')
        end

        include_examples 'compliant json error format'
        include_examples 'status code 403'
      end

      context 'when the password is missing' do
        let(:invalid_parameters) { { email: email } }

        before { post '/api/v1/sessions', params: invalid_parameters }

        it 'returns a heplful error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq('You have entered an invalid email or password')
        end

        include_examples 'compliant json error format'
        include_examples 'status code 403'
      end

      context 'when the password and email are missing' do
        let(:invalid_parameters) { {} }

        before { post '/api/v1/sessions', params: invalid_parameters }

        it 'returns a heplful error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq('You have entered an invalid email or password')
        end

        include_examples 'compliant json error format'
        include_examples 'status code 403'
      end
    end
  end
end
