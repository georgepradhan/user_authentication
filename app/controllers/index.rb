get '/' do
  if session[:user_id]
    redirect '/secret_page'
  else
    erb :index
  end
end

post '/create' do
  if params[:password] == params[:password_again]
    session[:user_id] = User.create(email: params[:email], password: params[:password]).id 
    @message = "Logged in successfully."
    erb :secret_page
  else
    @message = "Passwords did not match. Try again." 
    erb :index
  end
  
end

post '/login' do
  if User.authenticate(params[:email], params[:password])
    session[:user_id] = User.find_by_email(params[:email]).id
    @message = "Logged in successfully."
    erb :secret_page
  else
    @message = "Email or password was invalid. Try again." 
    erb :index
  end
end

get '/secret_page' do
  unless session[:user_id]
    redirect '/' 
  else
    erb :secret_page
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end
