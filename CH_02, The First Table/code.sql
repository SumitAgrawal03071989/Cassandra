Creating the user table.

CREATE TABLE "users" (
	"username" text PRIMARY KEY,
	"email" text,
	"enctrypted_password" blob
);

INSERT INTO "users" 
("username","email","enctrypted_password")
values('sumit','sumit@gmail.com',0x8914977ed729792e403da53024c6069a9158b8c4);


INSERT INTO "users" 
("username","enctrypted_password")
values('vivekananda',0x8914977ed729792e403da53024c6069a9158b8c4);

select * from users where email = 'sumit@gmail.com' ALLOW FILTERING;

select * from users where token("username") = token('sumit') ;




