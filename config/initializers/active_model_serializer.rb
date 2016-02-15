# require 'application_controller'
#
# # Convert attributes from snake_case to lowerCamelCase
# # ActiveModel::Serializer.config.key_format = :lower_camel
# 
# # ActiveModelSerializers.config.key_format = :lower_camel
# ActiveModel::Serializer.config.key_format = :lower_camel
#
# class ApplicationController
#   before_action :deep_snake_case_params!
#
#   protected
#     def deep_snake_case_params!(val = params)
#       case val
#       when Array
#         val.map {|v| deep_snake_case_params! v }
#       when Hash
#         val.keys.each do |k, v = val[k]|
#           val.delete k
#           val[k.underscore] = deep_snake_case_params!(v)
#         end
#         val
#       else
#         val
#       end
#     end
# end
