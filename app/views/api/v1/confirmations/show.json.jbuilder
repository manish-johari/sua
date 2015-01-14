unless @status
  json.errors do
    json.confirmation_token "Confirmation token is invalid."
    json.generic_errors "Confirmation token is invalid."
  end
else
  json.partial! 'api/v1/sessions/user', resource: current_user
end
