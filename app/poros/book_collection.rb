class BookCollection
  attr_reader :id, :destination, :forecast, :total_books_found, :books

  def initialize(books, forecast)
    @id                = nil
    @destination       = books[:q].tr('+', ',')
    @forecast          = populate_forecast(forecast)
    @total_books_found = books[:numFound]
    @books             = books[:docs]
  end

  def populate_forecast(forecast)
    {
      summary: forecast[:current][:weather].first[:description],
      temperature: "#{forecast[:current][:temp].round(0)} F"
    }
  end
end
