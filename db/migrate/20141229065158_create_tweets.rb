class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_id
      t.string :tweet_created_at
      t.string :text
      t.string :user_uid
      t.string :user_name
      t.string :user_screen_name
      t.string :user_image_url
      t.references :keyword, index: true

      t.timestamps
    end
  end
end
