-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/4/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/3/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE account_google_reader DROP CONSTRAINT account_google_reader_fk_email;

;
ALTER TABLE account_google_reader DROP CONSTRAINT account_google_reader_fk_user_id;

;
DROP INDEX account_google_reader_idx_email;

;
ALTER TABLE account_google_reader DROP COLUMN email;

;
ALTER TABLE account_google_reader ADD CONSTRAINT account_google_reader_fk_user_id FOREIGN KEY (user_id)
  REFERENCES user (user_id) DEFERRABLE;

;

COMMIT;

