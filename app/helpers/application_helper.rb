module ApplicationHelper

  def api_errors_helper(object)
    error = {}
    object.errors.messages.each do |key, val|
        error[key] = object.errors.full_messages_for(key).join(', ')
    end
     error.merge!({ generic_errors: object.errors.full_messages.join(', ') })
  end

end
