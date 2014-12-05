class ApiController < ApplicationController
	def getdata
		@data = Article.all
		if params[:category].present?
			@data = Article.where(:category_id => Category.where(name: params[:category]) )
		end
		if params[:tobao].present?
			@data = Article.where(:tobao_id => Tobao.where(name: params[:tobao]) )
		end
		render json: @data
	end
end
