if @resource.errors.present?
  json.errors api_errors_helper(@resource)
else
  json.partial! 'api/v1/sessions/user', resource: @resource, token: @auth_token
  json.verification_token @verification_token
end
