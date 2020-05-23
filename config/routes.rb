Rails.application.routes.draw do

get("/users", {:controller => 'users', :action => 'list_users'})
get("users/:username", {:controller => 'users', :action=>'user_info'})
get("insert_user_record", {:controller=>"users", :action=>"create_row"})
get("/update_username/:user_id_number", {:controller => "users", :action => "update_row"})
get("/photos/:photo_id", {:controller => "users", :action => "photo_info"})
get("/update_photo/:photo_id", {:controller=>"users", :action=>"update_photo"})
end
