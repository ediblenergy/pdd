-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/3/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/4/001-auto.yml':;

;
BEGIN;

;
ALTER TABLE account_google_reader DROP CONSTRAINT account_google_reader_fk_user_id;

;
ALTER TABLE account_google_reader ADD COLUMN email text NOT NULL;

;
CREATE INDEX account_google_reader_idx_email on account_google_reader (email);

;
ALTER TABLE account_google_reader ADD CONSTRAINT account_google_reader_fk_email FOREIGN KEY (email)
  REFERENCES account_google_federated_login (email) DEFERRABLE;

;
ALTER TABLE account_google_reader ADD CONSTRAINT account_google_reader_fk_user_id FOREIGN KEY (user_id)
  REFERENCES "user" (user_id) ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;

COMMIT;

