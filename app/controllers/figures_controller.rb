require 'pry'
class FiguresController < ApplicationController
  
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do
    # binding.pry
    @figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      # binding.pry
      @figure.titles << Title.create(params[:title])
      # binding.pry
    end
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
  end

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/:id' do
    # binding.pry
    @figure = Figure.find(params[:id].to_i)
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id].to_i)
    @landmarks = Landmark.all
    @titles = Title.all
    # binding.pry
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    # binding.pry
    @figure = Figure.find(params["id"])
    @figure.name = params[:figure][:name]
    if params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids] = []
    end
    if params[:figure][:title_ids].nil?
      params[:figure][:title_ids] = []
    end
    # binding.pry
    @figure.update(params[:figure])

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.new(params[:landmark])
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.new(params[:title])
    end
    # binding.pry
    redirect "/figures/#{@figure.id}"
  end
end
