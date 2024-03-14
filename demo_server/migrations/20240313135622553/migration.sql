BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "record_bool" (
    "id" serial PRIMARY KEY,
    "recordId" integer NOT NULL,
    "fieldId" integer NOT NULL,
    "contentBool" boolean NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "record_bool"
    ADD CONSTRAINT "record_bool_fk_0"
    FOREIGN KEY("recordId")
    REFERENCES "record"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "record_bool"
    ADD CONSTRAINT "record_bool_fk_1"
    FOREIGN KEY("fieldId")
    REFERENCES "field"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR demo
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('demo', '20240313135622553', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240313135622553', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
