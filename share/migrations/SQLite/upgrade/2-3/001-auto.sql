-- Convert schema '/home/skaufman/dev/pdd/share/migrations/_source/deploy/2/001-auto.yml' to '/home/skaufman/dev/pdd/share/migrations/_source/deploy/3/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE auth_credential (
  auth_credential_id INTEGER PRIMARY KEY NOT NULL,
  user_id integer NOT NULL,
  create_date timestampz NOT NULL DEFAULT '0',
  FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

;
CREATE INDEX auth_credential_idx_user_id ON auth_credential (user_id);

;
CREATE TABLE auth_google (
  auth_credential_id INTEGER PRIMARY KEY NOT NULL,
  user_id integer NOT NULL,
  create_date timestampz NOT NULL DEFAULT '0',
  FOREIGN KEY (auth_credential_id) REFERENCES auth_credential(auth_credential_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

;
CREATE INDEX auth_google_idx_user_id ON auth_google (user_id);

;
CREATE TABLE user (
  user_id INTEGER PRIMARY KEY NOT NULL,
  create_date timestampz NOT NULL DEFAULT '0'
);

;

COMMIT;

