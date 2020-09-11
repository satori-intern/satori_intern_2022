class ApiController < ActionController::Base
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    # success
    def response_success(body={})
        render json: { status: 200, message: 'ok' }.merge(body), status: 200
    end
    # bad request
    def response_bad_request(error='no details')
        render json: { status: 400, message: 'error', error: error }, status: 400
    end
    # not found
    def response_not_found(error='no details')
        render json: { status: 404, message: 'error', error: error }, status: 404
    end
end
