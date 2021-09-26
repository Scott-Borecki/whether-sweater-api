shared_examples 'status code 200' do
  it 'returns status code 200: ok' do
    expect(response).to have_http_status(:ok)
  end
end

shared_examples 'status code 201' do
  it 'returns status code 201: created' do
    expect(response).to have_http_status(:created)
  end
end

shared_examples 'status code 400' do
  it 'returns status code 400: bad request' do
    expect(response).to have_http_status(:bad_request)
    expect(json[:errors].first[:status]).to eq('400')
    expect(json[:errors].first[:title]).to eq('Bad Request')
  end
end

shared_examples 'status code 422' do
  it 'returns status code 422: unprocessable entity' do
    expect(response).to have_http_status(:unprocessable_entity)
    expect(json[:errors].first[:status]).to eq('422')
    expect(json[:errors].first[:title]).to eq('Unprocessable Entity')
  end
end
