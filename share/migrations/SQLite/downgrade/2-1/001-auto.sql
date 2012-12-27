-- Convert schema '/home/skaufman/dev/pdd/share/migrations/_source/deploy/2/001-auto.yml' to '/home/skaufman/dev/pdd/share/migrations/_source/deploy/1/001-auto.yml':;

;
BEGIN;

;
CREATE TEMPORARY TABLE bookmark_temp_alter (
  bookmark_id INTEGER PRIMARY KEY NOT NULL
);

;
INSERT INTO bookmark_temp_alter( bookmark_id) SELECT bookmark_id FROM bookmark;

;
DROP TABLE bookmark;

;
CREATE TABLE bookmark (
  bookmark_id INTEGER PRIMARY KEY NOT NULL
);

;
INSERT INTO bookmark SELECT bookmark_id FROM bookmark_temp_alter;

;
DROP TABLE bookmark_temp_alter;

;

COMMIT;

