CREATE SCHEMA "SelfcareIOSubscriptionMigrations";


CREATE TABLE IF NOT EXISTS "SelfcareIOSubscriptionMigrations".migrations
(
    "subscriptionId" character(26)  NOT NULL,
    "organizationFiscalCode" character(11)  NOT NULL,
    "sourceId" character(26)  NOT NULL,
    "sourceName" character(1) ,
    "sourceSurname" character(1) ,
    "sourceEmail" character(1) ,
    status character(1)  NOT NULL DEFAULT 'INITIAL'::bpchar,
    note text ,
    "serviceVersion" integer NOT NULL,
    "serviceName" character varying ,
    "updateAt" time without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT migrations_pkey PRIMARY KEY ("subscriptionId")
)
