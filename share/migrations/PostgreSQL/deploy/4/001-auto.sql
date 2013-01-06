-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Sun Jan  6 00:00:43 2013
-- 
;
--
-- Table: blog.
--
CREATE TABLE "blog" (
  "blog_id" serial NOT NULL,
  PRIMARY KEY ("blog_id")
);

;
--
-- Table: bookmark.
--
CREATE TABLE "bookmark" (
  "bookmark_id" serial NOT NULL,
  "link" text DEFAULT '' NOT NULL,
  "title" text DEFAULT '' NOT NULL,
  "create_date" timestampz DEFAULT '0' NOT NULL,
  PRIMARY KEY ("bookmark_id"),
  CONSTRAINT "bookmark_link" UNIQUE ("link")
);

;
--
-- Table: user.
--
CREATE TABLE "user" (
  "user_id" serial NOT NULL,
  "create_date" timestampz DEFAULT '0' NOT NULL,
  PRIMARY KEY ("user_id")
);

;
--
-- Table: auth_credential.
--
CREATE TABLE "auth_credential" (
  "auth_credential_id" serial NOT NULL,
  "user_id" integer NOT NULL,
  "create_date" timestampz DEFAULT '0' NOT NULL,
  PRIMARY KEY ("auth_credential_id")
);
CREATE INDEX "auth_credential_idx_user_id" on "auth_credential" ("user_id");

;
--
-- Table: auth_google.
--
CREATE TABLE "auth_google" (
  "auth_credential_id" integer NOT NULL,
  "user_id" integer NOT NULL,
  "create_date" timestampz DEFAULT '0' NOT NULL,
  "email" text NOT NULL,
  PRIMARY KEY ("auth_credential_id", "email"),
  CONSTRAINT "auth_google_email" UNIQUE ("email")
);
CREATE INDEX "auth_google_idx_auth_credential_id" on "auth_google" ("auth_credential_id");
CREATE INDEX "auth_google_idx_user_id" on "auth_google" ("user_id");

;
--
-- Foreign Key Definitions
--

;
ALTER TABLE "auth_credential" ADD CONSTRAINT "auth_credential_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "user" ("user_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "auth_google" ADD CONSTRAINT "auth_google_fk_auth_credential_id" FOREIGN KEY ("auth_credential_id")
  REFERENCES "auth_credential" ("auth_credential_id") DEFERRABLE;

;
ALTER TABLE "auth_google" ADD CONSTRAINT "auth_google_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "user" ("user_id") DEFERRABLE;

