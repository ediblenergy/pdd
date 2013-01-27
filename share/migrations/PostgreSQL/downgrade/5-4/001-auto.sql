-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/5/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/4/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE account_google_reader DROP CONSTRAINT account_google_reader_fk_email;

;
ALTER TABLE account_google_reader DROP COLUMN update_date;

;
ALTER TABLE account_google_reader DROP COLUMN last_fetch;

;
ALTER TABLE account_google_reader ADD CONSTRAINT account_google_reader_fk_email FOREIGN KEY (email)
  REFERENCES account_google_federated_login (email) DEFERRABLE;

;

COMMIT;

