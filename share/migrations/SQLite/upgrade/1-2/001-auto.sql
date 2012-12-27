-- Convert schema '/home/skaufman/dev/pdd/share/migrations/_source/deploy/1/001-auto.yml' to '/home/skaufman/dev/pdd/share/migrations/_source/deploy/2/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE bookmark ADD COLUMN link text NOT NULL DEFAULT '';

;
ALTER TABLE bookmark ADD COLUMN title text NOT NULL DEFAULT '';

;
ALTER TABLE bookmark ADD COLUMN create_date timestampz NOT NULL DEFAULT '0';

;
CREATE UNIQUE INDEX bookmark_link ON bookmark (link);

;

COMMIT;

