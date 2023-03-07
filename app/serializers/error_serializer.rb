class ErrorSerializer
  def self.user_error(error)
    { 
      "error": {
        "code": 422,
        "message": error
      }
    }
  end
end