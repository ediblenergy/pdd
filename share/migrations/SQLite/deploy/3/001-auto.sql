-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sun Jan  6 02:16:53 2013
-- 

;
BEGIN TRANSACTION;
--
-- Table: blog
--
CREATE TABLE blog (
  blog_id INTEGER PRIMARY KEY NOT NULL
);
--
-- Table: bookmark
--
CREATE TABLE bookmark (
  bookmark_id INTEGER PRIMARY KEY NOT NULL,
  link text NOT NULL DEFAULT '',
  title text NOT NULL DEFAULT '',
  create_date timestampz NOT NULL DEFAULT '0'
);
CREATE UNIQUE INDEX bookmark_link ON bookmark (link);
--
-- Table: user
--
CREATE TABLE user (
  user_id INTEGER PRIMARY KEY NOT NULL,
  create_date timestampz NOT NULL DEFAULT '0'
);
--
-- Table: auth_credential
--
CREATE TABLE auth_credential (
  auth_credential_id INTEGER PRIMARY KEY NOT NULL,
  user_id integer NOT NULL,
  create_date timestampz NOT NULL DEFAULT '0',
  FOREIGN KEY (auth_credential_id, user_id) REFERENCES auth_google(auth_credential_id, user_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX auth_credential_idx_auth_credential_id_user_id ON auth_credential (auth_credential_id, user_id);
CREATE INDEX auth_credential_idx_user_id ON auth_credential (user_id);
--
-- Table: auth_google
--
CREATE TABLE auth_google (
  auth_credential_id integer NOT NULL,
  user_id integer NOT NULL,
  create_date timestampz NOT NULL DEFAULT '0',
  email text NOT NULL,
  PRIMARY KEY (auth_credential_id, email),
  FOREIGN KEY (auth_credential_id) REFERENCES auth_credential(auth_credential_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);
CREATE INDEX auth_google_idx_auth_credential_id ON auth_google (auth_credential_id);
CREATE INDEX auth_google_idx_user_id ON auth_google (user_id);
CREATE UNIQUE INDEX auth_google_email ON auth_google (email);
COMMIT