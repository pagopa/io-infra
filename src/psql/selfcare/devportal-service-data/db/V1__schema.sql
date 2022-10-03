CREATE SCHEMA "DeveloperPortalServiceData";


-- this table will contain data for services, 
--  enriched and denormalized in order to help queries for admin and statitstics purposes
CREATE TABLE IF NOT EXISTS "DeveloperPortalServiceData".services
(
    "id" character(50)  NOT NULL, -- 'the unique identifier for the Service'
    "organizationFiscalCode" character(11)  NOT NULL, -- 'identifies the Organization the Service belongs to'
    "version" integer NOT NULL, -- 'revision number of the Service this record is built upon'
    "name" character varying ,
    "isVisible" BOOLEAN NOT NULL, -- 'visibility attribute for the Service'

    -- data related to the APIM account that owns the related subscription
    "subscriptionAccountId" character(26)  NOT NULL,
    "subscriptionAccountName" text,
    "subscriptionAccountSurname" text,
    "subscriptionAccountEmail" text,
    
    "updateAt" time without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT migrations_pkey PRIMARY KEY ("id")
);
