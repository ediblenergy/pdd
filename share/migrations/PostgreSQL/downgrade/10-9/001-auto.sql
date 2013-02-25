-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/10/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/9/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE account_google_reader DROP CONSTRAINT account_google_reader_fk_user_id;

;
ALTER TABLE oauth2_credential DROP CONSTRAINT oauth2_credential_service_credential_id;

;
ALTER TABLE oauth2_credential DROP CONSTRAINT oauth2_credential_fk_service_credential_id_service_id_user_id;

;
ALTER TABLE service_credential DROP CONSTRAINT sc_service_credential_id_user_id_idx2;

;
DROP INDEX oauth2_credential_idx2;

;
ALTER TABLE oauth2_credential DROP COLUMN service_credential_id;

;
ALTER TABLE account_google_reader ADD CONSTRAINT account_google_reader_fk_user_id FOREIGN KEY (user_id)
  REFERENCES user (user_id) ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;

COMMIT;

