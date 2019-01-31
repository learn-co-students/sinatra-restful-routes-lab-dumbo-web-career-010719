require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
	get '/recipes/new' do
		erb :new
	end

	get '/recipes' do
		# binding.pry
		@recipe = Recipe.all
		erb :index
	end

	post '/recipes' do
		Recipe.create(params)
		@found = Recipe.last 
		# binding.pry
		redirect to("/recipes/#{Recipe.last.id}")
	end


	get '/recipes/:id' do
		# @found = Recipe.all.find_by_id(params["id"])
		erb :show
	end

	delete '/recipes/:id' do
	    recipe = Recipe.find(params[:id])
	    recipe.destroy

	    redirect to("/recipes")
	end

	get '/recipes/:id/edit' do
	    @recipe = Recipe.find(params[:id])
	    # binding.pry
	    erb :'/edit'
  	end

	patch '/patch_and_update/:id' do

	    recipe =  Recipe.find(params[:id])
	    			    # binding.pry

	    recipe.update(params["recipe"])
	    redirect to("/recipes/#{params[:id]}")
	end
end
