Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://127.0.0.1:5500", 
            "http://localhost:5500", 
            "http://127.0.0.1:8000", 
            "http://localhost:8000",
            "http://localhost:3000",
            "https://eduranbegliomini.github.io"

    resource "/api/v1/services",
      headers: :any,
      methods: [:get, :options]
      
    resource "/api/v1/services/*",
      headers: :any,
      methods: [:get, :options]
  end
end