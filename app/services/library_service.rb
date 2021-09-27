class LibraryService
  def self.conn
    Faraday.new('http://openlibrary.org')
  end

  def self.get_books_based_on_location(fields: 'isbn,title,publisher', **args)
    response = conn.get('/search.json') do |req|
      req.params['q']      = args[:location]
      req.params['limit']  = args[:quantity]
      req.params['fields'] = args[:fields] || fields
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
