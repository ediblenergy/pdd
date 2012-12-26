-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Wed Dec 26 23:30:44 2012
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
  bookmark_id INTEGER PRIMARY KEY NOT NULL
);
COMMIT