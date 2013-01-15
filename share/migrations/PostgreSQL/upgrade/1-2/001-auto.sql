-- Convert schema '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/1/001-auto.yml' to '/home/skaufman/dev/pdd/script/../share/migrations/_source/deploy/2/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE "account_google_federated_login" (
  "service_credential_id" integer NOT NULL,
  "email" text NOT NULL,
  "user_id" integer NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("service_credential_id"),
  CONSTRAINT "agfl_email_idx" UNIQUE ("email")
);
CREATE INDEX "account_google_federated_login_idx_user_id" on "account_google_federated_login" ("user_id");

;
CREATE TABLE "account_google_reader" (
  "service_credential_id" integer NOT NULL,
  "user_id" integer NOT NULL,
  "expires_at" integer NOT NULL,
  "access_token" text NOT NULL,
  "refresh_token" text NOT NULL,
  "token_type" text NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("service_credential_id")
);
CREATE INDEX "account_google_reader_idx_user_id" on "account_google_reader" ("user_id");

;
CREATE TABLE "service" (
  "service_id" serial NOT NULL,
  "name" text NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("service_id"),
  CONSTRAINT "service_name" UNIQUE ("name")
);

;
CREATE TABLE "service_credential" (
  "service_credential_id" serial NOT NULL,
  "service_id" integer NOT NULL,
  "user_id" integer NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("service_credential_id"),
  CONSTRAINT "sc_service_credential_id_user_id_idx" UNIQUE ("service_credential_id", "user_id")
);
CREATE INDEX "service_credential_idx_service_id" on "service_credential" ("service_id");
CREATE INDEX "service_credential_idx_user_id" on "service_credential" ("user_id");

;
CREATE TABLE "user" (
  "user_id" serial NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("user_id")
);

;
CREATE TABLE "user_link" (
  "user_link_id" serial NOT NULL,
  "link" text NOT NULL,
  "title" text NOT NULL,
  "service_credential_id" integer NOT NULL,
  "user_id" integer NOT NULL,
  "create_date" timestamp with time zone NOT NULL,
  PRIMARY KEY ("user_link_id")
);
CREATE INDEX "user_link_idx_service_credential_id" on "user_link" ("service_credential_id");
CREATE INDEX "user_link_idx_user_id" on "user_link" ("user_id");

;
ALTER TABLE "account_google_federated_login" ADD CONSTRAINT "account_google_federated_login_fk_service_credential_id_user_id" FOREIGN KEY ("service_credential_id", "user_id")
  REFERENCES "service_credential" ("service_credential_id", "user_id") ON DELETE CASCADE DEFERRABLE;

;
ALTER TABLE "account_google_federated_login" ADD CONSTRAINT "account_google_federated_login_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "user" ("user_id") DEFERRABLE;

;
ALTER TABLE "account_google_reader" ADD CONSTRAINT "account_google_reader_fk_service_credential_id_user_id" FOREIGN KEY ("service_credential_id", "user_id")
  REFERENCES "service_credential" ("service_credential_id", "user_id") ON DELETE CASCADE DEFERRABLE;

;
ALTER TABLE "account_google_reader" ADD CONSTRAINT "account_google_reader_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "user" ("user_id") DEFERRABLE;

;
ALTER TABLE "service_credential" ADD CONSTRAINT "service_credential_fk_service_id" FOREIGN KEY ("service_id")
  REFERENCES "service" ("service_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "service_credential" ADD CONSTRAINT "service_credential_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "user" ("user_id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "user_link" ADD CONSTRAINT "user_link_fk_service_credential_id" FOREIGN KEY ("service_credential_id")
  REFERENCES "service_credential" ("service_credential_id") DEFERRABLE;

;
ALTER TABLE "user_link" ADD CONSTRAINT "user_link_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "user" ("user_id") DEFERRABLE;

;
DROP TABLE blog CASCADE;

;
DROP TABLE bookmark CASCADE;

;
DROP TABLE pdd_user CASCADE;

;
DROP TABLE auth_credential CASCADE;

;
DROP TABLE auth_google CASCADE;

;

COMMIT;

