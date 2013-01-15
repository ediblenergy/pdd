-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/2/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/1/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "auth_credential" (
  "auth_credential_id" serial NOT NULL,
  "pdd_user_id" integer NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("auth_credential_id"),
  CONSTRAINT "auth_credential_pdd_user_id_auth_credential_id" UNIQUE ("pdd_user_id", "auth_credential_id")
);
CREATE INDEX "auth_credential_idx_pdd_user_id" on "auth_credential" ("pdd_user_id");

;
CREATE TABLE "auth_google" (
  "auth_credential_id" integer NOT NULL,
  "pdd_user_id" integer NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  "email" text NOT NULL,
  PRIMARY KEY ("auth_credential_id", "email"),
  CONSTRAINT "auth_google_email" UNIQUE ("email")
);
CREATE INDEX "auth_google_idx_auth_credential_id_pdd_user_id" on "auth_google" ("auth_credential_id", "pdd_user_id");
CREATE INDEX "auth_google_idx_pdd_user_id" on "auth_google" ("pdd_user_id");

;
CREATE TABLE "blog" (
  "blog_id" serial NOT NULL,
  PRIMARY KEY ("blog_id")
);

;
CREATE TABLE "bookmark" (
  "bookmark_id" serial NOT NULL,
  "link" text DEFAULT '' NOT NULL,
  "title" text DEFAULT '' NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("bookmark_id"),
  CONSTRAINT "bookmark_link" UNIQUE ("link")
);

;
CREATE TABLE "pdd_user" (
  "pdd_user_id" serial NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("pdd_user_id")
);

;
ALTER TABLE "auth_credential" ADD CONSTRAINT "auth_credential_fk_pdd_user_id" FOREIGN KEY ("pdd_user_id")
  REFERENCES "pdd_user" ("pdd_user_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "auth_google" ADD CONSTRAINT "auth_google_fk_auth_credential_id_pdd_user_id" FOREIGN KEY ("auth_credential_id", "pdd_user_id")
  REFERENCES "auth_credential" ("auth_credential_id", "pdd_user_id") ON DELETE CASCADE DEFERRABLE;

;
ALTER TABLE "auth_google" ADD CONSTRAINT "auth_google_fk_pdd_user_id" FOREIGN KEY ("pdd_user_id")
  REFERENCES "pdd_user" ("pdd_user_id") DEFERRABLE;

;
DROP TABLE service CASCADE;

;
DROP TABLE user CASCADE;

;
DROP TABLE service_credential CASCADE;

;
DROP TABLE account_google_federated_login CASCADE;

;
DROP TABLE account_google_reader CASCADE;

;
DROP TABLE user_link CASCADE;

;

COMMIT;

