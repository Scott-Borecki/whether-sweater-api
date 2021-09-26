shared_examples 'compliant json data format' do
  it 'complies with JSON:API spec' do
    expect(json).to be_a(Hash)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data].size).to eq(3)
    expect(json[:data]).to have_key(:type)
    expect(json[:data]).to have_key(:id)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
  end
end

shared_examples 'compliant json error format' do
  it 'complies with JSON:API spec' do
    expect(json).to be_a(Hash)
    expect(json).to have_key(:errors)
    expect(json[:errors]).to be_a(Array)
    expect(json[:errors].first).to be_a(Hash)
    expect(json[:errors].first.size).to eq(3)
    expect(json[:errors].first).to have_key(:status)
    expect(json[:errors].first).to have_key(:title)
    expect(json[:errors].first).to have_key(:detail)
  end
end
