CREATE TABLE "user_outbound_follows" (
  "follower_username" text,
  "followed_username" text,
  PRIMARY KEY ("follower_username", "followed_username")
);