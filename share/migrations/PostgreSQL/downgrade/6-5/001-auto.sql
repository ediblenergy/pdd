-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/6/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/5/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE user_link DROP CONSTRAINT user_link_fk_user_id;

;
ALTER TABLE account_google_reader ADD COLUMN last_fetch timestamp with time zone NOT NULL;

;
ALTER TABLE user_link ADD CONSTRAINT user_link_fk_user_id FOREIGN KEY (user_id)
  REFERENCES user (user_id) DEFERRABLE;

;
DROP TABLE service_credential_fetch CASCADE;

;

COMMIT;

