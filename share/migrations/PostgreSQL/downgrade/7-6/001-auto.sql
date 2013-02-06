-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/7/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/6/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE service_credential_fetch DROP CONSTRAINT service_credential_fetch_fk_service_credential_id;

;
ALTER TABLE service_credential_fetch ADD CONSTRAINT service_credential_fetch_fk_service_credential_id FOREIGN KEY (service_credential_id)
  REFERENCES service_credential (service_credential_id) ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
DROP TABLE account_soundcloud CASCADE;

;

COMMIT;

