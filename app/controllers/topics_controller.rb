class TopicsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]  
  before_filter :admin_required, :only => :destroy

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end
  def new
    @topic = Topic.new
  end

  def create
    @user = User.find(current_user.id)
    @topic = Topic.new(:name => params[:topic][:name], :last_poster_id => current_user.id, :last_post_at => Time.now, :forum_id => params[:topic][:forum_id], :user_id => current_user.id)  
    @topic.user = @user
    if @topic.save
      @post = @topic.posts.create(:content => params[:post][:content])
      @post.user = @user
      logger.debug "The object is #{params[:topic][:forum_id]}"
      logger.debug "The name is #{@topic.name}"
      logger.debug "The last poster id is #{@topic.last_poster_id}"
      logger.debug "The last post at is #{@topic.last_post_at}"
      logger.debug "The forum is #{@topic.forum_id}"
      logger.debug "The ID is #{@topic.id}"
      logger.debug "The user is #{@topic.user_id}"

      logger.debug "The first post is #{@post.content}"
      logger.debug "The first post topic id is #{@post.topic_id}"
      if @post.save  
        flash[:notice] = "Successfully created topic."  
        redirect_to "/forums/#{@topic.forum_id}"  
      else  
        redirect :action => 'new'  
      end
    else  
      redirect :action => 'new'  
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      redirect_to "/forums/#{@topic.forum_id}"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to "/forums/#{@topic.forum_id}"
  end
end
