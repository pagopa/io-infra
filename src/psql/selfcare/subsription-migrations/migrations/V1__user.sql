
--
-- Roles
--

CREATE ROLE "FNSUBSMIGRATIONS_USER";
ALTER ROLE "FNSUBSMIGRATIONS_USER" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
GRANT "FNSUBSMIGRATIONS_USER" TO "${flywayUser}";
ALTER USER "FNSUBSMIGRATIONS_USER" WITH PASSWORD '${fnsubsmigrationsUserPassword}';


-- Database privileges
--

GRANT CONNECT ON DATABASE db TO "FNSUBSMIGRATIONS_USER";

-- schema creation
--

CREATE SCHEMA SelfcareIOSubscriptionMigrations;
ALTER SCHEMA SelfcareIOSubscriptionMigrations OWNER TO "FNSUBSMIGRATIONS_USER";


-- schema grants
--

ALTER DEFAULT PRIVILEGES IN SCHEMA party GRANT ALL PRIVILEGES ON TABLES TO "FNSUBSMIGRATIONS_USER";
ALTER DEFAULT PRIVILEGES IN SCHEMA party GRANT USAGE ON SEQUENCES TO "FNSUBSMIGRATIONS_USER";
