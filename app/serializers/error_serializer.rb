class ErrorSerializer
  def self.user_error(error)
    {
      "error": {
        "code": 422,
        "message": error
      }
    }
  end

  def self.invalid_key
    {
      "error": {
        "code": 401,
        "message": 'Not authorized, invalid API Key'
      }
    }
  end

  def self.missing_param(param)
    {
      "error": {
        "code": 400,
        "message": "Invalid request, no #{param} param given"
      }
    }
  end
end
