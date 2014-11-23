class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def getdata
    # Api::Vnnet.crawling
    require 'open-uri'
    require 'nokogiri'
    website = "http://vietnamnet.vn"
    page = Nokogiri::HTML(open(website+"/vn/giao-duc/"))
   begin
      article_list = page.css(".ArticleCateList")
      articles = article_list[0].css(".ArticleCateItem")
      articles[0..-2].each do |article|
        name = article.css("a")[0].attribute("title").value
        link = article.css("a")[0].attribute("href").value
        desc = article.css("h3")[0].text
        image = article.css("img")[0].attribute("src").value
        page_inside = Nokogiri::HTML(open(website+link))
        content = page_inside.css("#ArticleContent").text
        category  = Category.first||Category.new
        category.name = "Giao Duc"
        category.save
        article = Post.where(:title => name).first || category.posts.new(title:"#{name}",image:"#{image}",content:"#{content}",desc:"#{desc}")
            article.save
        p "success clawer "+ name 
      end
    rescue Exception => e
      @message = e
    end
  end
  def index 
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
