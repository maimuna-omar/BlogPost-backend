class ApplicationController < ActionController::API
    include ActionController::Cookies
    class ApplicationController < ActionController::API
        include ActionController::Cookies
    
        def authenticate_request!
            token = request.headers['Authorization']
            @current_user = User.find_by(token: token)
    
            unless @current_user
                render json: { status: 'error', message: 'Not Authenticated' }, status: :unauthorized
            end
        end
    end
    
end
