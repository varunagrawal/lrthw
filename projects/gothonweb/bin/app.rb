require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    return 'Hello World!'
end

get '/hello/' do
    erb :hello_form
end

post '/hello/' do
    greeting = params[:greeting] || "Hi There"
    name = params[:name] || "Nobody"

    File.open('uploads/' + params[:file][:filename], 'w') do |f|
        f.write(params[:file][:tempfile].read)
    end

    erb :index, :locals => {'greeting' => greeting, 'name' => name}
end
