require "base64"

class EntriesController < ApplicationController
  resource_controller  
  belongs_to :user
  
  create.after do
    File.open(@entry.image_path, 'w+') do |f|
      base64 = @entry.image_data.sub(/^.+,/, '')
      f.puts Base64.decode64(base64)
    end
  end
  create.wants.html { redirect_to user_entries_path(@user) }
  destroy.wants.html { redirect_to user_entries_path(object.user_id) }

end
