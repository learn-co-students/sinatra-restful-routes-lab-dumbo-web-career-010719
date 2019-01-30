require "pry"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do 
    erb :new
  end

  post '/recipes' do
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    #binding.pry
    redirect to("/recipes/#{recipe.id}")
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do #edit action
    recipe = Recipe.find(params[:id])
    # binding.pry
    recipe.update(name: params[:name], ingredients: params[:ingredients])
    redirect to "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do #delete action
    recipe = Recipe.find(params[:id]).destroy
    redirect to('/')
  end
  
end
