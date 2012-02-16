class PostsController < ApplicationController
  before_filter :login_required

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create  
    @post = Post.new(:content => params[:post][:content], :topic_id => params[:post][:topic_id], :user_id => current_user.id)  
    if @post.save  
      @topic = Topic.find(@post.topic_id)        
      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)  
      flash[:notice] = "Successfully created post."  
      redirect_to "/topics/#{@post.topic_id}"  
    else  
      render :action => 'new'  
    end    
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update  
    @post = Post.find(params[:id])  
    if @post.update_attributes(params[:post])  
      @topic = Topic.find(@post.topic_id)  
      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)  
      flash[:notice] = "Successfully updated post."  
      redirect_to @post  
    else  
      render :action => 'edit'  
    end  
  end 

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, :notice => "Successfully destroyed post."
  end
end
