class ApplicationController < ActionController::API
  include Knock::Authenticable

  # def parse_params_attrs
  #   [params[:include], params[:]]
  # end
end
