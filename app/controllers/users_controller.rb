class UsersController < ApplicationController

  def list_users
    @users = User.find_by_sql("SELECT ID, USERNAME FROM Users ORDER BY USERNAME").pluck(:username, :id)
    render({:template => "photogram_templates/users.html.erb"})
  end 

  def list_photos 
    @photos = User.find_by_sql("SELECT * FROM Photos ORDER BY created_at DESC")
    render({:template => "photogram_templates/photos.html.erb"})
  end 
  def user_info
    name = params.fetch("username")
    @users = User.where(:Username => name).at(0)
    @photos = Photo.where(:owner_id => @users.id)
    render({:template => "photogram_templates/user_info.html.erb"})
  end

  def create_user_record
    u = User.new
    u.username = params.fetch("new_user")
    u.save 
    redirect_to("/users/"+ u.username)
  end

  def create_photo_record
    photo = Photo.new
    photo.image = params.fetch("image_src")
    photo.caption = params.fetch("caption")
    photo.owner_id = params.fetch("photo_author")
    photo.save 
    redirect_to("/photos/" + photo.id.to_s)
  end 

  def create_comment_record
    comment = Comment.new
    comment.photo_id = params.fetch("photo_id")
    comment.body = params.fetch("comment")
    comment.author_id = params.fetch("author_id")
    comment.save
    redirect_to("/photos/" + comment.photo_id.to_s)
  
  end 

  def update_row
    user_id = params.fetch("user_id_number")
    new_username = params.fetch("updated_username")
    
    user_record = User.where({:id => user_id}).first
    user_record.username = new_username
    user_record.save 

    redirect_to("/users/"+new_username)
  end

  def photo_info 
    photo_id = params.fetch("photo_id")
    @photo_info = Photo.where(:id => photo_id).at(0)
    
    today_date = Date.today
    created_date = @photo_info.created_at
    @months_btwn = (today_date.year - created_date.year) * 12 + (today_date.month - created_date.month)

    @comments = Comment.where(:photo_id => photo_id)
    
    render({:template => "photogram_templates/photo_info.html.erb"})
  end

  def update_photo
    photo_id = params.fetch("photo_id")
    new_image = params.fetch("new_image_src")
    new_caption = params.fetch("new_caption")

    photo_record = Photo.where({:id => photo_id}).first
    photo_record.image = new_image
    photo_record.caption = new_caption
    photo_record.save 

    redirect_to("/photos/"+photo_id.to_s)
  end
  
  def delete_photo 
    photo_id = params.fetch("photo_id")
    photo_row = Photo.where({:id => photo_id}).first 
    comments_row = Comment.where({:photo_id => photo_id}).first
    photo_row.destroy
    comments_row.destroy 
    redirect_to("/photos")
  end 
end