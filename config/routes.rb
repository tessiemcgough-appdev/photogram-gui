Rails.application.routes.draw do

get("/", {:controller => 'users', :action => 'list_users'})
get("/users", {:controller => 'users', :action => 'list_users'})
get("/photos", {:controller=>"users", :action=>"list_photos"})

get("users/:username", {:controller => 'users', :action=>'user_info'})
get("/photos/:photo_id", {:controller => "users", :action => "photo_info"})

get("insert_user_record", {:controller=>"users", :action=>"create_user_record"})
get("insert_photo_record", {:controller=>"users", :action=>"create_photo_record"})
get("/insert_comment", {:controller=>"users", :action=>"create_comment_record"})

get("/update_username/:user_id_number", {:controller => "users", :action => "update_row"})
get("/update_photo/:photo_id", {:controller=>"users", :action=>"update_photo"})
get("/delete_photo/:photo_id", {:controller=>"users", :action=>"delete_photo"})


end
