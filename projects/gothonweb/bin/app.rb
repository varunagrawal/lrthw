require 'sinatra'
require './lib/gothonweb/map.rb'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"
enable :sessions
set :session_secret, 'BADSECRET'

get '/' do
    session[:room] = 'START'
    redirect to('/game')
end

get '/game' do
    room = Map::load_room(session)

    if room
        erb :show_room, :locals => {:room => room}
    else
        erb :you_died
    end
end

post '/game' do
    room = Map::load_room(session)
    action = params[:action]

    if room
        next_room = room.go(action) || room.go("*")

        if next_room
            Map::save_room(session, next_room)
        end

        redirect to('/game')
    else
        erb :you_died
    end
end

get '/hello/' do
    erb :hello_form
end

post '/hello/' do
    greeting = params[:greeting] || "Hi There"
    name = params[:name] || "Nobody"

    if params[:file]
        File.open('uploads/' + params[:file][:filename], 'w') do |f|
            f.write(params[:file][:tempfile].read)
        end
    end

    erb :index, :locals => {'greeting' => greeting, 'name' => name}
end
