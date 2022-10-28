CREATE SCHEMA "SelfcareIOSubscriptionMigrations";


CREATE TABLE IF NOT EXISTS "SelfcareIOSubscriptionMigrations".migrations
(
    "subscriptionId" character(50)  NOT NULL,
    "organizationFiscalCode" character(11)  NOT NULL,
    "serviceVersion" integer NOT NULL,
    "serviceName" text,

    "sourceId" character(26)  NOT NULL,
    "sourceName" text ,
    "sourceSurname" text ,
    "sourceEmail" text ,
    
    -- In order to avoid null fileds, we set FALSE as default
    -- This is harmless as
    --  * we will ensure this field to be set at insert time
    --  * the field is not considered yet by the application (at the time of writing)
    ADD COLUMN "isVisible" boolean NOT NULL default false,
    ADD COLUMN "hasBeenVisibleOnce"  boolean NOT NULL default false;

    status text  NOT NULL DEFAULT 'INITIAL'::bpchar,
    note text ,
    "updateAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT migrations_pkey PRIMARY KEY ("subscriptionId")
)
