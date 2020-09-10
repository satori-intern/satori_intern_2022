class ApiController < ActionController::Base
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    # success
    def response200(body)
        return { status: 200, message: 'ok' }.merge(body)
    end
    # bad request
    def response400(error)
        return { status: 400, message: 'error', error: error}
    end
    # not found
    def response404(error)
        return { status: 404, message: 'error', error: error}
    end
end
