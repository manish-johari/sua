if @user.errors.present?
 json.errors api_errors_helper(@user)
else
  json.partial! 'api/v1/sessions/user', resource: @user
  json.token @auth_token
end
