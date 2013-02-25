-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/9/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/10/001-auto.yml':;

;
BEGIN;

ALTER TABLE service_credential ADD CONSTRAINT sc_service_credential_id_user_id_idx2 UNIQUE (user_id, service_id, service_credential_id);
;
ALTER TABLE account_google_reader DROP CONSTRAINT account_google_reader_fk_user_id;

;
ALTER TABLE oauth2_credential ADD COLUMN service_credential_id integer NOT NULL;

;
CREATE INDEX oauth2_credential_idx2 on oauth2_credential (user_id, service_id, service_credential_id);

;
ALTER TABLE account_google_reader ADD CONSTRAINT account_google_reader_fk_user_id FOREIGN KEY (user_id)
  REFERENCES "user" ("user_id") DEFERRABLE;

;
ALTER TABLE oauth2_credential ADD CONSTRAINT oauth2_credential_service_credential_id UNIQUE (service_credential_id);

;
ALTER TABLE oauth2_credential ADD CONSTRAINT oauth2_credential_fk_service_credential_id_service_id_user_id FOREIGN KEY (service_credential_id, service_id, user_id)
  REFERENCES service_credential (service_credential_id, service_id, user_id) DEFERRABLE;

;

;

COMMIT;

