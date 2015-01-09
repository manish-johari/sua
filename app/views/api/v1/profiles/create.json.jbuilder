if @profile.errors.present?
 json.errors api_errors_helper(@profile)
else
  json.message 'Ok'
end
