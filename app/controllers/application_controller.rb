class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

 	get '/recipes' do #index page
 		@recipes = Recipe.all
 		erb :index
 	end

 	get '/recipes/new' do #new recipe form
 		erb :new
 	end

 	post '/recipes' do #create
 		@recipe = Recipe.create(params)
 		redirect to "recipes/#{@recipe.id}"
 	end

 	get '/recipes/:id' do #show page
 		@recipe = Recipe.find_by_id(params[:id])
		erb :show
	end

	get '/recipes/:id/edit' do #edit form
		@recipe = Recipe.find_by_id(params[:id])
		erb :edit
	end

	patch '/recipes/:id' do #edit
		@recipe = Recipe.find_by_id(params[:id])
		@recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
		redirect to ("/recipes/#{@recipe.id}")
	end

	delete '/recipes/:id' do #delete
		@recipe = Recipe.find_by_id(params[:id])
		@recipe.delete
		redirect to "/recipes"
	end
end
