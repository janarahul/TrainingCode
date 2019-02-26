require 'rest-client'
url = "http://localhost:3000/users"
#puts RestClient.get("http://localhost:3000/users")
RestClient.post( url,
  {
    :transfer => 'hi'
  })