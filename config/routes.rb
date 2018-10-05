Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      get  'geocode',      to: 'geocoding#geocode'
    end
  end
end
