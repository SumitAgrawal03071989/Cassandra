---- COMPOUND KEYS 


CREATE TABLE "user_status_updates" (
	"username" text,
	"id" timeuuid,
	"body" text,
	PRIMARY KEY ("username","id")
);

-- in above table now username and id are mandetory fields.
-- timeuuid is serving as surrogate key.
-- timeuuid stored version 1 of UUID.
-- with cassandra we can extract timestamp from timeuuid data type.



-- to get a list of all tables in keyspace
SELECT * FROM system_schema.tables WHERE keyspace_name = 'my_status';


INSERT INTO "user_status_updates"
("username", "id", "body")
VALUES (
  'sumit',
  97719c50-e797-11e3-90ce-5f98e903bf02,
  'Learning cassandra'
);

INSERT INTO "user_status_updates"
("username", "id", "body")
VALUES (
  'vivekananda',
  97719c50-e797-11e3-90ce-5f98e903bf02,
  'Teaching yoga'
);

-- note as compound primary key already exists it will update existing records
INSERT INTO "user_status_updates"
("username", "id", "body")
VALUES (
  'vivekananda',
  97719c50-e797-11e3-90ce-5f98e903bf02,
  'Teaching yoga1'
);


select * from "user_status_updates" ;

-- note , in user table we were not getting result with filter on username.
-- but here we could perform same , why?
select * from "user_status_updates" where username = 'sumit';

-- timeuuid to timestamp using DATEOF
select username , DATEOF("id") from "user_status_updates";


-- Automatically generating timeuuid
-- note ,here when we fire insert query, in return we do not get what we have insered. 
INSERT INTO "user_status_updates"
("username", "id", "body")
VALUES (
  'vivekananda',
  NOW(),
  'Teaching yoga2'
);


-- Beyond two columns compound key

CREATE TABLE "status_update_replies" (
  "status_update_username" text,
  "status_update_id" timeuuid,
  "id" timeuuid,
  "author_username" text,
  "body" text,
  PRIMARY KEY (
    ("status_update_username", "status_update_id"),
    "id"
  )
);

INSERT INTO "status_update_replies" ("status_update_username", 
"status_update_id", "id", "author_username", "body")
VALUES ('alice', 76e7a4d0-e796-11e3-90ce-5f98e903bf02, NOW(), 'bob',
'Reply1');

INSERT INTO "status_update_replies" ("status_update_username", 
"status_update_id", "id", "author_username", "body")
VALUES ('alice', 97719c50-e797-11e3-90ce-5f98e903bf02, NOW(), 'bob',
'Reply2');


SELECT * FROM "status_update_replies"
WHERE "status_update_username" = 'alice'

SELECT * FROM "status_update_replies"
   WHERE "status_update_username" = 'alice' AND 
"status_update_id" = 97719c50-e797-11e3-90ce-5f98e903bf02;


-- STATIC COLUMNS 

CREATE TABLE "users_with_status_updates" (
  "username" text,
  "id" timeuuid,
  "email" text STATIC,
  "encrypted_password" blob STATIC,
  "body" text,
  PRIMARY KEY ("username", "id")
);

-- static columns get updated 
INSERT INTO "users_with_status_updates"
("username", "id", "email", "encrypted_password", "body")
VALUES (
  'alice',
  76e7a4d0-e796-11e3-90ce-5f98e903bf02,
  'alice1@gmail.com',
  0x8914977ed729792e403da53024c6069a9158b8c4,
  'Learning Cassandra!'
);

select * from "users_with_status_updates";


INSERT INTO "users_with_status_updates"
("username", "id",  "body")
VALUES (
  'alice',
  NOW(),
  'Learning Cassandra123'
);











