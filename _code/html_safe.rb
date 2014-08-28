require 'action_view'
safe_string = "I am a string".html_safe
not_safe_string = "I am a string"
safe_string == not_safe_string
not_safe_string == safe_string

require 'action_view'
safe_string = "Safe String".html_safe
not_safe_string = "Not Safe String"
(safe_string + not_safe_string).html_safe?
(not_safe_string + safe_string).html_safe?
