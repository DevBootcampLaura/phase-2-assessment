require 'pry'

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/sign-in' do
  erb :sign_in
end

post '/sign-in' do

  user = User.authenticate(email: params[:email], password: params[:password])

  if user != nil
    session[:user_id] = user.id
    redirect ('/create')
  else
    redirect ('/sign-in')
  end
end

post '/sign-up' do
  user = User.create!( :first_name => params[:first_name],
                :last_name  => params[:last_name],
                :email      => params[:email],
                :birthdate  => params[:birthdate],
                :password => params[:password])
  session[:user_id] = user.id
  redirect ('/create')
end

post '/sign-out' do
  session.clear
  erb :sign_in
end

get '/create' do
  if request.xhr?
    erb :create, layout: false
  else
    erb :create
  end
end

post '/create' do
  @event = Event.create(name: params[:name],
                      location: params[:location],
                      starts_at: params[:starts_at],
                      ends_at: params[:ends_at],
                      user_id: session[:user_id])

  redirect ("/event/#{@event.id}")
end

get '/event/:event_id' do
  @event = Event.find(params[:event_id])
  erb :event
end

get '/show_events/:user_id' do
  @user = User.find(params[:user_id])
  erb :show_events
end

post '/update/:event_id' do
  @event = Event.find(params[:event_id])
  @event.name = params[:name]
  @event.location = params[:location]
  @event.starts_at = params[:starts_at]
  @event.ends_at = params[:ends_at]
  @event.save

  redirect ("/event/#{@event.id}")
end

post '/delete/:event_id' do
  @event = Event.find(params[:event_id])
  @event.destroy

  redirect ("/show_events/#{session[:user_id]}")
end


















