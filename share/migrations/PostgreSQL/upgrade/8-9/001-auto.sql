-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/8/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/9/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE oauth2_credential DROP CONSTRAINT oauth2_credential_fk_user_id;

;
ALTER TABLE oauth2_credential ALTER COLUMN access_token TYPE text;

;
ALTER TABLE oauth2_credential ADD CONSTRAINT oauth2_credential_fk_user_id FOREIGN KEY (user_id)
  REFERENCES "user" ("user_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;

COMMIT;

