class HealthcheckController < ApplicationController
    def healthcheck
        render plain: "", status: :ok
    end
end
