class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do
    figure = Figure.new(params[:figure])
    
    figure.titles.build(params[:title]) if !Title.find_by(name: params[:title][:name])
    figure.landmarks.build(params[:landmark]) if !Landmark.find_by(name: params[:landmark][:name])
    figure.save

    redirect "/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
   
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
   
    figure = Figure.find(params[:id]).update(params[:figure])
  
    figure.titles.build(params[:title]) if !Title.find_by(name: params[:title][:name])
    figure.landmarks.build(params[:landmark]) if !Landmark.find_by(name: params[:landmark][:name])

    figure.save
    
    redirect :"/figures/#{figure.id}"
  end
end
