CREATE SCHEMA "DeveloperPortalServiceData";


-- this table will contain data for services, 
--  enriched and denormalized in order to help queries for admin and statitstics purposes
CREATE TABLE IF NOT EXISTS "DeveloperPortalServiceData".services
(
    "id" character(50)  NOT NULL, 
    "organizationFiscalCode" character(11)  NOT NULL,
    "version" integer NOT NULL,
    "name" character varying ,
    "isVisible" BOOLEAN NOT NULL,

    -- data related to the APIM account that owns the related subscription
    "subscriptionAccountId" character(26)  NOT NULL,
    "subscriptionAccountName" text,
    "subscriptionAccountSurname" text,
    "subscriptionAccountEmail" text,
    
    "updateAt" time without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT migrations_pkey PRIMARY KEY ("id")
);

COMMENT ON COLUMN "DeveloperPortalServiceData".services.id IS 'the unique identifier for the Service';
COMMENT ON COLUMN "DeveloperPortalServiceData".services.organizationFiscalCode IS 'identifies the Organization the Service belongs to';
COMMENT ON COLUMN "DeveloperPortalServiceData".services.version IS 'revision number of the Service this record is built upon';
COMMENT ON COLUMN "DeveloperPortalServiceData".services.isVisible IS 'visibility attribute for the Service';

