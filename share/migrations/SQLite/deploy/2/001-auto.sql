-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Thu Dec 27 00:20:17 2012
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
COMMIT