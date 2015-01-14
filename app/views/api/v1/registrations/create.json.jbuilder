if @resource.errors.present?
  json.errors api_errors_helper(@resource)
else
  json.partial! 'api/v1/sessions/user', resource: @resource
  json.verification_token @verification_token
  json.token @auth_token
end
