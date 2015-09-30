Rails.application.routes.draw do
  namespace :api, :defaults => {:format=> :json} do
    namespace :v1 do
      get   "/scales",    to: "scales#index"
    end
  end

end
