-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Sun Jan  6 02:51:44 2013
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
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("bookmark_id"),
  CONSTRAINT "bookmark_link" UNIQUE ("link")
);

;
--
-- Table: pdd_user.
--
CREATE TABLE "pdd_user" (
  "pdd_user_id" serial NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("pdd_user_id")
);

;
--
-- Table: auth_credential.
--
CREATE TABLE "auth_credential" (
  "auth_credential_id" serial NOT NULL,
  "pdd_user_id" integer NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("auth_credential_id"),
  CONSTRAINT "auth_credential_pdd_user_id_auth_credential_id" UNIQUE ("pdd_user_id", "auth_credential_id")
);
CREATE INDEX "auth_credential_idx_pdd_user_id" on "auth_credential" ("pdd_user_id");

;
--
-- Table: auth_google.
--
CREATE TABLE "auth_google" (
  "auth_credential_id" integer NOT NULL,
  "pdd_user_id" integer NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  "email" text NOT NULL,
  PRIMARY KEY ("auth_credential_id", "email"),
  CONSTRAINT "auth_google_email" UNIQUE ("email")
);
CREATE INDEX "auth_google_idx_auth_credential_id_pdd_user_id" on "auth_google" ("auth_credential_id", "pdd_user_id");
CREATE INDEX "auth_google_idx_pdd_user_id" on "auth_google" ("pdd_user_id");

;
--
-- Foreign Key Definitions
--

;
ALTER TABLE "auth_credential" ADD CONSTRAINT "auth_credential_fk_pdd_user_id" FOREIGN KEY ("pdd_user_id")
  REFERENCES "pdd_user" ("pdd_user_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "auth_google" ADD CONSTRAINT "auth_google_fk_auth_credential_id_pdd_user_id" FOREIGN KEY ("auth_credential_id", "pdd_user_id")
  REFERENCES "auth_credential" ("auth_credential_id", "pdd_user_id") ON DELETE CASCADE DEFERRABLE;

;
ALTER TABLE "auth_google" ADD CONSTRAINT "auth_google_fk_pdd_user_id" FOREIGN KEY ("pdd_user_id")
  REFERENCES "pdd_user" ("pdd_user_id") DEFERRABLE;

