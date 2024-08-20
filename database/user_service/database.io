// relational db (postgres)

Table users {
  id string [primary key]
  username varchar(100) [not null]
  created_at timestamp
}

Table follows {
  following_user_id string [not null]
  followed_user_id string [not null]
  created_at timestamp
}

Ref: users.id < follows.following_user_id

Ref: users.id < follows.followed_user_id