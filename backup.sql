--
-- PostgreSQL database cluster dump
--

-- Started on 2025-06-19 15:19:02 +03

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE anon;
ALTER ROLE anon WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticated;
ALTER ROLE authenticated WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticator;
ALTER ROLE authenticator WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:QbADdujgrBz3j11Aa6YHeA==$XwAPLqCV404uc4FWeWaSDnRpNlVlzIlYDB4u6T5L5t8=:tSIqaW9XPc9tYLr8KYwk/zbCVwzjx/TI+65K0JksNW8=';
CREATE ROLE dashboard_user;
ALTER ROLE dashboard_user WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB NOLOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE pgbouncer;
ALTER ROLE pgbouncer WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:FiYiZmSEjKp4V/UZjQFRJw==$6E4Nr3wiqlsJ12GcBv9yCvy9FJSXvZRK0SjroQ5jwn0=:WZvsjMShlbfWLJf3jVnZLD+iDiuOUE8uigBDPml3HS4=';
CREATE ROLE postgres;
ALTER ROLE postgres WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:VbmfxhMvAgoRpW0TtNpckQ==$gAMx2Okdb0uZxAgn5kC/4MKSQzAKF8V3p9fe1KIygY4=:rLtmKovUpKROBo4d4XxpRKAEJpXOZ+9CvUAnckQSiGI=';
CREATE ROLE service_role;
ALTER ROLE service_role WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION BYPASSRLS;
CREATE ROLE supabase_admin;
ALTER ROLE supabase_admin WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:Tx1sgQYNOSzBcvd8rqYZKw==$vdgsGjY4Q5EaQ3lvlBU6HHnpsubVHxpjNXZK6xkozs4=:GC/ILQrXsxE3mi8gdZ7RmLidhI/ukGx9TKUhSZntTsc=';
CREATE ROLE supabase_auth_admin;
ALTER ROLE supabase_auth_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:+PoADL0EOFTHCXU/myBmRQ==$ZPTw83bgO0LsnT/fmwyL+75DKyPiSTMMBnl7lKwjYD0=:FpiN36LG7SzD+/Bjp0jY2BSCJuaouTAzzcmuUBWS468=';
CREATE ROLE supabase_read_only_user;
ALTER ROLE supabase_read_only_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:7v/yw+ADsxZ7SINTnw9dNg==$cTEHKJIwgbq9649+GIWaFmJG4bvYLgANyYLPb65qPB8=:IPu8Tl9eq6HClIkSGk671EsuQyofLFz8onIcMctFcr0=';
CREATE ROLE supabase_realtime_admin;
ALTER ROLE supabase_realtime_admin WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE supabase_replication_admin;
ALTER ROLE supabase_replication_admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:RBGrSvgGEqj0/9X5WA69Zg==$1Pzy9JnYNTw0pIrOOk6+ddWOR7Tqjdrkkp0TgC4jYa0=:Ouc8sSpPsTAenIO9H75IO9QZRMaqKp041BM4L9l+JyU=';
CREATE ROLE supabase_storage_admin;
ALTER ROLE supabase_storage_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:D75JVL6m18dLIKH/jKEQfg==$WWZSEK9yTFiCGKWplG/RMxB7xQRYvAmkrOt3ig5kzq8=:cCrefshSyNonkCTLiz4y6DkPV9Ef1uAYkXjSn+0UgNs=';

--
-- User Configurations
--

--
-- User Config "anon"
--

ALTER ROLE anon SET statement_timeout TO '3s';

--
-- User Config "authenticated"
--

ALTER ROLE authenticated SET statement_timeout TO '8s';

--
-- User Config "authenticator"
--

ALTER ROLE authenticator SET session_preload_libraries TO 'safeupdate';
ALTER ROLE authenticator SET statement_timeout TO '8s';
ALTER ROLE authenticator SET lock_timeout TO '8s';

--
-- User Config "postgres"
--

ALTER ROLE postgres SET search_path TO E'\\$user', 'public', 'extensions';

--
-- User Config "supabase_admin"
--

ALTER ROLE supabase_admin SET search_path TO '$user', 'public', 'auth', 'extensions';
ALTER ROLE supabase_admin SET log_statement TO 'none';

--
-- User Config "supabase_auth_admin"
--

ALTER ROLE supabase_auth_admin SET search_path TO 'auth';
ALTER ROLE supabase_auth_admin SET idle_in_transaction_session_timeout TO '60000';
ALTER ROLE supabase_auth_admin SET log_statement TO 'none';

--
-- User Config "supabase_storage_admin"
--

ALTER ROLE supabase_storage_admin SET search_path TO 'storage';
ALTER ROLE supabase_storage_admin SET log_statement TO 'none';


--
-- Role memberships
--

GRANT anon TO authenticator;
GRANT anon TO postgres;
GRANT authenticated TO authenticator;
GRANT authenticated TO postgres;
GRANT authenticator TO supabase_storage_admin;
GRANT pg_monitor TO postgres;
GRANT pg_read_all_data TO postgres;
GRANT pg_read_all_data TO supabase_read_only_user;
GRANT pg_signal_backend TO postgres;
GRANT service_role TO authenticator;
GRANT service_role TO postgres;
GRANT supabase_auth_admin TO postgres;
GRANT supabase_realtime_admin TO postgres;
GRANT supabase_storage_admin TO postgres;






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.0

-- Started on 2025-06-19 15:19:04 +03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2025-06-19 15:19:07 +03

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.0

-- Started on 2025-06-19 15:19:07 +03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 17 (class 2615 OID 16488)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- TOC entry 24 (class 2615 OID 18372)
-- Name: cupons; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA cupons;


ALTER SCHEMA cupons OWNER TO postgres;

--
-- TOC entry 4064 (class 0 OID 0)
-- Dependencies: 24
-- Name: SCHEMA cupons; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA cupons IS 'Kupon bilgi ve yönetimi';


--
-- TOC entry 15 (class 2615 OID 16388)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- TOC entry 20 (class 2615 OID 16618)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- TOC entry 19 (class 2615 OID 16607)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- TOC entry 13 (class 2615 OID 16386)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 23 (class 2615 OID 16599)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- TOC entry 16 (class 2615 OID 16536)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- TOC entry 18 (class 2615 OID 16645)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- TOC entry 7 (class 3079 OID 16673)
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- TOC entry 4070 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- TOC entry 5 (class 3079 OID 16389)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 4071 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 3 (class 3079 OID 16434)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 4072 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 2 (class 3079 OID 16471)
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- TOC entry 4073 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- TOC entry 6 (class 3079 OID 16646)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 4074 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 4 (class 3079 OID 16423)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 4075 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1095 (class 1247 OID 16762)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 1122 (class 1247 OID 16903)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 1092 (class 1247 OID 16756)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1089 (class 1247 OID 16750)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1128 (class 1247 OID 16945)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1203 (class 1247 OID 85339)
-- Name: farmer_activity_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.farmer_activity_status AS ENUM (
    'Active',
    'NonActive'
);


ALTER TYPE public.farmer_activity_status OWNER TO postgres;

--
-- TOC entry 1200 (class 1247 OID 85313)
-- Name: farmer_store_activity_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.farmer_store_activity_enum AS ENUM (
    'active',
    'nonactive'
);


ALTER TYPE public.farmer_store_activity_enum OWNER TO postgres;

--
-- TOC entry 1152 (class 1247 OID 17116)
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- TOC entry 1143 (class 1247 OID 17077)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- TOC entry 1146 (class 1247 OID 17091)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- TOC entry 1158 (class 1247 OID 17158)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- TOC entry 1155 (class 1247 OID 17129)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- TOC entry 342 (class 1255 OID 16534)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 4076 (class 0 OID 0)
-- Dependencies: 342
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 413 (class 1255 OID 16732)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 341 (class 1255 OID 16533)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 4079 (class 0 OID 0)
-- Dependencies: 341
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 340 (class 1255 OID 16532)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 4081 (class 0 OID 0)
-- Dependencies: 340
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 397 (class 1255 OID 16591)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- TOC entry 4098 (class 0 OID 0)
-- Dependencies: 397
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 405 (class 1255 OID 16612)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- TOC entry 4100 (class 0 OID 0)
-- Dependencies: 405
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 403 (class 1255 OID 16593)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- TOC entry 4102 (class 0 OID 0)
-- Dependencies: 403
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 402 (class 1255 OID 16603)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- TOC entry 360 (class 1255 OID 16604)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- TOC entry 404 (class 1255 OID 16614)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- TOC entry 4131 (class 0 OID 0)
-- Dependencies: 404
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 324 (class 1255 OID 16387)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- TOC entry 339 (class 1255 OID 33361)
-- Name: check_and_reduce_stock(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_and_reduce_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- 1. Tablo adı: products (product_table değil)
  -- 2. Alan adı: id (product_id değil) 
  -- 3. UUID cast ekle: NEW.product_id::uuid
  IF (SELECT stock_quantity FROM products WHERE id = NEW.product_id::uuid) < NEW.unit_quantity THEN
    RAISE EXCEPTION 'Yetersiz stok! Mevcut stok: %, İstenen: %', 
      (SELECT stock_quantity FROM products WHERE id = NEW.product_id::uuid), 
      NEW.unit_quantity;
  END IF;

  -- Stoktan düş
  UPDATE products
  SET stock_quantity = stock_quantity - NEW.unit_quantity
  WHERE id = NEW.product_id::uuid;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_and_reduce_stock() OWNER TO postgres;

--
-- TOC entry 429 (class 1255 OID 17151)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 435 (class 1255 OID 17229)
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- TOC entry 428 (class 1255 OID 17163)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- TOC entry 425 (class 1255 OID 17113)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- TOC entry 426 (class 1255 OID 17108)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- TOC entry 430 (class 1255 OID 17159)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- TOC entry 431 (class 1255 OID 17170)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 424 (class 1255 OID 17107)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- TOC entry 434 (class 1255 OID 17228)
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- TOC entry 432 (class 1255 OID 17105)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- TOC entry 427 (class 1255 OID 17140)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- TOC entry 433 (class 1255 OID 17222)
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- TOC entry 419 (class 1255 OID 17010)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 416 (class 1255 OID 16984)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 415 (class 1255 OID 16983)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 414 (class 1255 OID 16982)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 417 (class 1255 OID 16996)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 421 (class 1255 OID 17049)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 420 (class 1255 OID 17012)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 423 (class 1255 OID 17065)
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- TOC entry 422 (class 1255 OID 16999)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 418 (class 1255 OID 17000)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 273 (class 1259 OID 16519)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 4166 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 290 (class 1259 OID 16907)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 4168 (class 0 OID 0)
-- Dependencies: 290
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- TOC entry 281 (class 1259 OID 16704)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 4170 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 4171 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 272 (class 1259 OID 16512)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 4173 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 285 (class 1259 OID 16794)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 285
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 284 (class 1259 OID 16782)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 284
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 283 (class 1259 OID 16769)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 283
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 291 (class 1259 OID 16957)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 271 (class 1259 OID 16501)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 4182 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 270 (class 1259 OID 16500)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 4184 (class 0 OID 0)
-- Dependencies: 270
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 288 (class 1259 OID 16836)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 289 (class 1259 OID 16854)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 274 (class 1259 OID 16527)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 282 (class 1259 OID 16734)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 282
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 287 (class 1259 OID 16821)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 4195 (class 0 OID 0)
-- Dependencies: 287
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 286 (class 1259 OID 16812)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 4198 (class 0 OID 0)
-- Dependencies: 286
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 269 (class 1259 OID 16489)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 4200 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 4201 (class 0 OID 0)
-- Dependencies: 269
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 301 (class 1259 OID 18373)
-- Name: coupon_usages; Type: TABLE; Schema: cupons; Owner: postgres
--

CREATE TABLE cupons.coupon_usages (
    coupon_usages_id integer NOT NULL,
    user_id integer NOT NULL,
    order_id integer NOT NULL,
    used_date date NOT NULL,
    coupons_id integer NOT NULL
);


ALTER TABLE cupons.coupon_usages OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 18376)
-- Name: coupons; Type: TABLE; Schema: cupons; Owner: postgres
--

CREATE TABLE cupons.coupons (
    coupon_id integer NOT NULL,
    coupon_code character varying NOT NULL,
    description text,
    discount_type character varying NOT NULL,
    discount_value character varying NOT NULL,
    min_order_value double precision NOT NULL,
    max_uses integer NOT NULL,
    uses_count integer,
    valid_from date,
    valid_until date,
    is_active boolean NOT NULL
);


ALTER TABLE cupons.coupons OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 18384)
-- Name: cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cards (
    user_id integer NOT NULL,
    card_id integer NOT NULL,
    user_card_name character varying NOT NULL,
    user_card_number character varying NOT NULL,
    user_card_ending_date character varying NOT NULL,
    user_card_code character varying NOT NULL
);


ALTER TABLE public.cards OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 25156)
-- Name: cards_card_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cards_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cards_card_id_seq OWNER TO postgres;

--
-- TOC entry 4206 (class 0 OID 0)
-- Dependencies: 313
-- Name: cards_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cards_card_id_seq OWNED BY public.cards.card_id;


--
-- TOC entry 304 (class 1259 OID 18389)
-- Name: delivery_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_address (
    user_id integer NOT NULL,
    user_address_id integer NOT NULL,
    city character varying NOT NULL,
    neighborhood character varying NOT NULL,
    street character varying NOT NULL,
    floor integer NOT NULL,
    apartment character varying NOT NULL,
    full_address character varying NOT NULL,
    district character varying NOT NULL,
    "userUserId" integer
);


ALTER TABLE public.delivery_address OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 25147)
-- Name: delivery_address_user_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.delivery_address_user_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.delivery_address_user_address_id_seq OWNER TO postgres;

--
-- TOC entry 4209 (class 0 OID 0)
-- Dependencies: 311
-- Name: delivery_address_user_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.delivery_address_user_address_id_seq OWNED BY public.delivery_address.user_address_id;


--
-- TOC entry 305 (class 1259 OID 18394)
-- Name: farmer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.farmer (
    farmer_id integer NOT NULL,
    farmer_password character varying NOT NULL,
    farmer_name character varying NOT NULL,
    farmer_last_name character varying NOT NULL,
    farmer_age integer NOT NULL,
    farmer_address character varying NOT NULL,
    farmer_city character varying NOT NULL,
    farmer_town character varying NOT NULL,
    farmer_neighbourhood character varying NOT NULL,
    farmer_phone_number character varying NOT NULL,
    farmer_mail character varying NOT NULL,
    farm_name character varying NOT NULL,
    farmer_tc_no character varying,
    farmer_biografi character varying,
    auth_id uuid NOT NULL,
    img_url character varying,
    farmer_activity_status public.farmer_activity_status,
    farmer_store_activity public.farmer_store_activity_enum DEFAULT 'active'::public.farmer_store_activity_enum NOT NULL
);
ALTER TABLE ONLY public.farmer ALTER COLUMN farmer_password SET (n_distinct=10693013294);


ALTER TABLE public.farmer OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 57027)
-- Name: farmer_certificate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.farmer_certificate (
    id bigint NOT NULL,
    farmer_id bigint NOT NULL,
    images text NOT NULL
);


ALTER TABLE public.farmer_certificate OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 57030)
-- Name: farmer_certificate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.farmer_certificate ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.farmer_certificate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 316 (class 1259 OID 56792)
-- Name: farmer_farmer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.farmer ALTER COLUMN farmer_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.farmer_farmer_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 317 (class 1259 OID 57016)
-- Name: farmer_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.farmer_images (
    id bigint NOT NULL,
    farmer_id bigint NOT NULL,
    farmer_image text NOT NULL
);


ALTER TABLE public.farmer_images OWNER TO postgres;

--
-- TOC entry 4215 (class 0 OID 0)
-- Dependencies: 317
-- Name: TABLE farmer_images; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.farmer_images IS 'Farmers informations';


--
-- TOC entry 318 (class 1259 OID 57019)
-- Name: farmer_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.farmer_images ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.farmer_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 322 (class 1259 OID 67626)
-- Name: farmer_product_income; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.farmer_product_income (
    id bigint NOT NULL,
    order_prduct_id integer NOT NULL,
    product_id uuid DEFAULT gen_random_uuid(),
    farmer_id integer,
    farmer_name text,
    product_name text,
    product_quantity double precision,
    product_income double precision,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.farmer_product_income OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 67629)
-- Name: farmer_product_income_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.farmer_product_income ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.farmer_product_income_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 306 (class 1259 OID 18399)
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    order_id integer NOT NULL,
    user_id integer NOT NULL,
    order_status character varying NOT NULL,
    order_date character varying NOT NULL,
    estimated_delivery_date character varying NOT NULL,
    delivery_date character varying,
    use_any_coupon boolean DEFAULT false NOT NULL,
    delivery_address_id integer NOT NULL,
    address_full character varying,
    address_city character varying,
    address_district character varying,
    address_neighborhood character varying,
    address_street character varying,
    address_floor integer,
    address_apartment character varying,
    rate_for_order double precision
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 25149)
-- Name: order_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_order_id_seq OWNER TO postgres;

--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 312
-- Name: order_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_order_id_seq OWNED BY public."order".order_id;


--
-- TOC entry 307 (class 1259 OID 18404)
-- Name: order_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_product (
    order_id integer NOT NULL,
    order_product_id integer NOT NULL,
    farmer_id integer NOT NULL,
    farmer_name character varying NOT NULL,
    unit_quantity integer NOT NULL,
    unit_price integer NOT NULL,
    total_product_price integer NOT NULL,
    order_product_rate character varying,
    delivery_address_id integer NOT NULL,
    product_name character varying NOT NULL,
    product_id uuid NOT NULL,
    order_product_status text
);


ALTER TABLE public.order_product OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 27620)
-- Name: order_product_order_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_product_order_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_product_order_product_id_seq OWNER TO postgres;

--
-- TOC entry 4224 (class 0 OID 0)
-- Dependencies: 314
-- Name: order_product_order_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_product_order_product_id_seq OWNED BY public.order_product.order_product_id;


--
-- TOC entry 308 (class 1259 OID 18407)
-- Name: product_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_table (
    farmer_id integer NOT NULL,
    product_id integer NOT NULL,
    product_katalog_name character varying NOT NULL,
    farmer_price double precision NOT NULL,
    tarladan_commission double precision NOT NULL,
    tarladan_price double precision NOT NULL,
    product_rating double precision,
    product_name character varying NOT NULL,
    stock_quantity integer NOT NULL
);


ALTER TABLE public.product_table OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 28884)
-- Name: product_table_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_table_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_table_product_id_seq OWNER TO postgres;

--
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 315
-- Name: product_table_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_table_product_id_seq OWNED BY public.product_table.product_id;


--
-- TOC entry 321 (class 1259 OID 61856)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    product_name character varying NOT NULL,
    product_katalog_name character varying NOT NULL,
    image_url character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    farmer_id integer NOT NULL,
    farmer_price double precision NOT NULL,
    tarladan_commission double precision NOT NULL,
    tarladan_price double precision NOT NULL,
    stock_quantity integer NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 18412)
-- Name: user_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_table (
    user_id integer NOT NULL,
    user_mail character varying NOT NULL,
    user_phone_number character varying NOT NULL,
    user_password character varying NOT NULL,
    user_name character varying NOT NULL,
    user_surname character varying NOT NULL,
    user_birthday_date character varying NOT NULL
);


ALTER TABLE public.user_table OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 20700)
-- Name: user_table_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_table_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_table_user_id_seq OWNER TO postgres;

--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 310
-- Name: user_table_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_table_user_id_seq OWNED BY public.user_table.user_id;


--
-- TOC entry 300 (class 1259 OID 17232)
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- TOC entry 294 (class 1259 OID 17071)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 297 (class 1259 OID 17093)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- TOC entry 296 (class 1259 OID 17092)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 275 (class 1259 OID 16540)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 4237 (class 0 OID 0)
-- Dependencies: 275
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 277 (class 1259 OID 16582)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 276 (class 1259 OID 16555)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 4240 (class 0 OID 0)
-- Dependencies: 276
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 292 (class 1259 OID 17014)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 293 (class 1259 OID 17028)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 3605 (class 2604 OID 16504)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 3638 (class 2604 OID 25157)
-- Name: cards card_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards ALTER COLUMN card_id SET DEFAULT nextval('public.cards_card_id_seq'::regclass);


--
-- TOC entry 3639 (class 2604 OID 25148)
-- Name: delivery_address user_address_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_address ALTER COLUMN user_address_id SET DEFAULT nextval('public.delivery_address_user_address_id_seq'::regclass);


--
-- TOC entry 3641 (class 2604 OID 25150)
-- Name: order order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order" ALTER COLUMN order_id SET DEFAULT nextval('public.order_order_id_seq'::regclass);


--
-- TOC entry 3643 (class 2604 OID 27621)
-- Name: order_product order_product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product ALTER COLUMN order_product_id SET DEFAULT nextval('public.order_product_order_product_id_seq'::regclass);


--
-- TOC entry 3644 (class 2604 OID 28885)
-- Name: product_table product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_table ALTER COLUMN product_id SET DEFAULT nextval('public.product_table_product_id_seq'::regclass);


--
-- TOC entry 3645 (class 2604 OID 20701)
-- Name: user_table user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_table ALTER COLUMN user_id SET DEFAULT nextval('public.user_table_user_id_seq'::regclass);


--
-- TOC entry 4014 (class 0 OID 16519)
-- Dependencies: 273
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	7f8a9c33-7fd0-4a3c-b386-d12b4260d972	{"action":"user_confirmation_requested","actor_id":"3cf0aabd-5636-4ef9-9a6b-45e24108e7f8","actor_username":"hasan.gurbuz@std.yeditepe.edu.tr","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-22 22:04:26.701391+00	
00000000-0000-0000-0000-000000000000	4645a89a-e20f-4bf8-ab94-0da3a6335438	{"action":"user_confirmation_requested","actor_id":"3cf0aabd-5636-4ef9-9a6b-45e24108e7f8","actor_username":"hasan.gurbuz@std.yeditepe.edu.tr","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-22 22:05:51.87514+00	
00000000-0000-0000-0000-000000000000	e90215e3-8396-4103-80eb-66513dfbe5c2	{"action":"user_confirmation_requested","actor_id":"4cbe1ac6-9786-4850-a7c1-30a18653f261","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:14:50.659649+00	
00000000-0000-0000-0000-000000000000	82bebfd2-65d9-4012-a1e0-dc1ed7d89736	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hasangurbuzc@gmail.com","user_id":"4cbe1ac6-9786-4850-a7c1-30a18653f261","user_phone":""}}	2025-05-25 21:18:39.994796+00	
00000000-0000-0000-0000-000000000000	c65b4b36-19d0-42d6-aba5-c959e121022e	{"action":"user_confirmation_requested","actor_id":"a203439a-4f15-48c5-8c0a-55e9fe2156d5","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:19:00.753424+00	
00000000-0000-0000-0000-000000000000	ea2ab78b-1114-491e-a88d-6fd9d5b7a72c	{"action":"user_confirmation_requested","actor_id":"a203439a-4f15-48c5-8c0a-55e9fe2156d5","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:25:04.926572+00	
00000000-0000-0000-0000-000000000000	587b90eb-ff1a-4247-8306-10873a79f87b	{"action":"user_confirmation_requested","actor_id":"a203439a-4f15-48c5-8c0a-55e9fe2156d5","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:27:26.406782+00	
00000000-0000-0000-0000-000000000000	881e46b5-3457-44ca-a34a-c9d026789284	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hasangurbuzc@gmail.com","user_id":"a203439a-4f15-48c5-8c0a-55e9fe2156d5","user_phone":""}}	2025-05-25 21:29:08.126267+00	
00000000-0000-0000-0000-000000000000	3454e7a8-1efc-4144-8bb6-d019cf6ffc64	{"action":"user_confirmation_requested","actor_id":"50ec1a06-67f1-4dac-a8b1-4cae9bc3f0d5","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:29:34.408606+00	
00000000-0000-0000-0000-000000000000	0073a838-f0ab-4a3c-a05d-ef60b1cd04a7	{"action":"user_confirmation_requested","actor_id":"50ec1a06-67f1-4dac-a8b1-4cae9bc3f0d5","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:34:42.894428+00	
00000000-0000-0000-0000-000000000000	543ed802-be8d-4f94-af55-d0ca9c338a4c	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hasangurbuzc@gmail.com","user_id":"50ec1a06-67f1-4dac-a8b1-4cae9bc3f0d5","user_phone":""}}	2025-05-25 21:35:30.7793+00	
00000000-0000-0000-0000-000000000000	988f4fd5-1faa-4077-81c3-932db072e59f	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:35:44.157503+00	
00000000-0000-0000-0000-000000000000	e718cfe5-e49f-4911-9a8e-663bd66ca031	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:49:39.509534+00	
00000000-0000-0000-0000-000000000000	978f8a1f-9dc8-4ac0-aece-bed8cd7f65e8	{"action":"user_confirmation_requested","actor_id":"65cb989d-fe8e-4c54-9880-5ac41d12d4ff","actor_username":"hasangurbuz@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:49:47.177585+00	
00000000-0000-0000-0000-000000000000	1dc20a39-999b-476c-acd9-9c88fcdb9dac	{"action":"user_confirmation_requested","actor_id":"92bc395d-ad2d-4c78-bf7f-db810a594b8b","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:50:42.123764+00	
00000000-0000-0000-0000-000000000000	f61efad5-b3d9-40fa-a3f2-c1f91d0ed51a	{"action":"user_confirmation_requested","actor_id":"92bc395d-ad2d-4c78-bf7f-db810a594b8b","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:52:50.16156+00	
00000000-0000-0000-0000-000000000000	b895e857-7f1d-408f-8098-8700b00c3a64	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 21:55:24.997955+00	
00000000-0000-0000-0000-000000000000	0c2782e0-741e-41a5-9440-da697f298753	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 22:08:19.953751+00	
00000000-0000-0000-0000-000000000000	6b21a107-8872-4348-b065-de209eabb006	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 22:38:10.624836+00	
00000000-0000-0000-0000-000000000000	c68e555e-5078-4b45-b386-d7c8760ce14b	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 22:48:19.347695+00	
00000000-0000-0000-0000-000000000000	dd3fbe0d-2047-4e17-a257-971e3b0c0183	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 23:34:22.489086+00	
00000000-0000-0000-0000-000000000000	d6371d00-69b5-4175-853d-25f7c8aad6e2	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 23:46:15.418546+00	
00000000-0000-0000-0000-000000000000	1d9d1682-e633-4b49-aaf7-a9aeff380414	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 23:48:18.204084+00	
00000000-0000-0000-0000-000000000000	892ba2c1-0f7d-4a7f-976a-81b887ad3a00	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 23:52:59.010924+00	
00000000-0000-0000-0000-000000000000	fb05b086-1c14-49bb-addc-cea2f0e35049	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-25 23:59:25.357208+00	
00000000-0000-0000-0000-000000000000	45c0c202-1545-4dec-831f-d90c3cb7fabb	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-26 01:08:02.368167+00	
00000000-0000-0000-0000-000000000000	ba5b0898-051c-4d60-b5d2-d74b39e900fe	{"action":"user_confirmation_requested","actor_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-26 01:09:14.907478+00	
00000000-0000-0000-0000-000000000000	588d61df-0905-49aa-8ee3-8af8527ee3ef	{"action":"user_confirmation_requested","actor_id":"92bc395d-ad2d-4c78-bf7f-db810a594b8b","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-26 01:09:45.765697+00	
00000000-0000-0000-0000-000000000000	ddbc3c40-b350-4e33-9eaf-7b7f05ad8069	{"action":"user_confirmation_requested","actor_id":"627fadd6-219b-402f-a488-28ce18b20871","actor_username":"hasan132@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-26 01:32:45.409111+00	
00000000-0000-0000-0000-000000000000	98ab32db-4210-41a0-9c69-0464434cf212	{"action":"user_confirmation_requested","actor_id":"92bc395d-ad2d-4c78-bf7f-db810a594b8b","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-26 01:37:42.48961+00	
00000000-0000-0000-0000-000000000000	bbbabbeb-7126-4c05-a140-d06103cc7515	{"action":"user_signedup","actor_id":"92bc395d-ad2d-4c78-bf7f-db810a594b8b","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-05-26 01:38:22.080325+00	
00000000-0000-0000-0000-000000000000	d3c028ff-08a8-4b0b-9d59-c5c6fa58c012	{"action":"user_recovery_requested","actor_id":"92bc395d-ad2d-4c78-bf7f-db810a594b8b","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-05-26 01:42:07.814212+00	
00000000-0000-0000-0000-000000000000	6b01ad4a-0d57-4385-b4b3-f2a4868cd523	{"action":"login","actor_id":"92bc395d-ad2d-4c78-bf7f-db810a594b8b","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-05-26 01:42:20.459791+00	
00000000-0000-0000-0000-000000000000	9f8f0b56-542b-4e40-95bb-ac5617dc0ade	{"action":"user_repeated_signup","actor_id":"92bc395d-ad2d-4c78-bf7f-db810a594b8b","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-26 01:43:41.8597+00	
00000000-0000-0000-0000-000000000000	f9a466a9-bfe0-47fa-b4b7-b349f14f9777	{"action":"user_repeated_signup","actor_id":"92bc395d-ad2d-4c78-bf7f-db810a594b8b","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-26 01:44:15.792308+00	
00000000-0000-0000-0000-000000000000	5d6484db-9423-492a-9202-1273b53826b6	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hsngrbz7106@gmail.com","user_id":"92bc395d-ad2d-4c78-bf7f-db810a594b8b","user_phone":""}}	2025-05-26 01:44:50.361633+00	
00000000-0000-0000-0000-000000000000	1cbb75ae-953a-44c7-8d34-e67608f2a517	{"action":"user_confirmation_requested","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-26 01:44:54.238321+00	
00000000-0000-0000-0000-000000000000	53d6e4b1-f90a-4d1e-b54d-cb8c6a08b1b7	{"action":"user_signedup","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-05-26 01:45:34.908481+00	
00000000-0000-0000-0000-000000000000	c2c64e49-8188-48e1-9a4a-b026d6fa0f20	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-26 01:46:03.493831+00	
00000000-0000-0000-0000-000000000000	0c4fcf98-297c-4130-b6e5-1290a00336ea	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-26 02:45:34.648177+00	
00000000-0000-0000-0000-000000000000	01bbe8a4-d1d2-4c69-85b5-2b29a5e03109	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-26 02:48:18.767803+00	
00000000-0000-0000-0000-000000000000	1c1dba24-e0ce-4032-a556-c6b082f52484	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-26 02:50:20.519878+00	
00000000-0000-0000-0000-000000000000	bb55b8fe-1c2d-47e2-bb08-f77cdeb45755	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-26 04:08:21.246135+00	
00000000-0000-0000-0000-000000000000	1c879e7c-d30c-40d2-9d43-f839a439f7b8	{"action":"user_confirmation_requested","actor_id":"39e2cfca-b6b4-4c59-81fd-4f987a40fee7","actor_username":"mertar24@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-26 04:26:30.106608+00	
00000000-0000-0000-0000-000000000000	6b80f5f2-55f7-4178-a367-f34476b1c0c2	{"action":"user_signedup","actor_id":"39e2cfca-b6b4-4c59-81fd-4f987a40fee7","actor_username":"mertar24@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-05-26 04:27:08.314621+00	
00000000-0000-0000-0000-000000000000	ebaba6cd-59c4-41d2-90ee-df30ea866694	{"action":"login","actor_id":"39e2cfca-b6b4-4c59-81fd-4f987a40fee7","actor_username":"mertar24@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-26 04:28:14.647311+00	
00000000-0000-0000-0000-000000000000	5b12c077-951f-4bcc-b172-827c0c878abe	{"action":"user_confirmation_requested","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-26 12:48:12.049326+00	
00000000-0000-0000-0000-000000000000	f681f719-be0f-417c-b7eb-333672c079ea	{"action":"user_signedup","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-05-26 12:48:34.610955+00	
00000000-0000-0000-0000-000000000000	028c64fb-407b-4e32-a16f-37cca98f7fec	{"action":"login","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-26 12:51:33.418119+00	
00000000-0000-0000-0000-000000000000	0fb67cea-589c-4c40-a643-9fb5b6042cf0	{"action":"login","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-26 12:52:03.640913+00	
00000000-0000-0000-0000-000000000000	9de7307e-eb10-405c-99e5-63fc5a19dc18	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-26 19:48:02.623059+00	
00000000-0000-0000-0000-000000000000	52d3bdee-2822-4027-95c0-3f2292743d5f	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-26 19:54:44.432181+00	
00000000-0000-0000-0000-000000000000	3247f16a-61a4-4c70-8ff5-05f92afec39c	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-27 11:09:40.067497+00	
00000000-0000-0000-0000-000000000000	ac1d05db-eacf-41c6-83ae-5b4c4b8ed1eb	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-27 11:09:40.068035+00	
00000000-0000-0000-0000-000000000000	292c1d56-f72a-439a-a016-d83661562a84	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-27 11:09:40.845903+00	
00000000-0000-0000-0000-000000000000	0438b42c-5762-407e-aacc-84c32c346c17	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 12:15:29.000148+00	
00000000-0000-0000-0000-000000000000	e9a93c4a-4f55-451d-ac11-78c42cf976a9	{"action":"login","actor_id":"39e2cfca-b6b4-4c59-81fd-4f987a40fee7","actor_username":"mertar24@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 12:24:19.877837+00	
00000000-0000-0000-0000-000000000000	c5292893-8015-41bf-8ad5-c2087fe73a35	{"action":"login","actor_id":"39e2cfca-b6b4-4c59-81fd-4f987a40fee7","actor_username":"mertar24@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 12:24:20.571447+00	
00000000-0000-0000-0000-000000000000	e549af1d-39a6-4406-9251-ad9ddd036693	{"action":"user_repeated_signup","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 12:25:13.04858+00	
00000000-0000-0000-0000-000000000000	e53ea094-b3f7-43ce-a2e6-adc1689829bc	{"action":"user_confirmation_requested","actor_id":"550d261b-32d4-479c-ba17-9cca46228b8c","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 13:05:13.696876+00	
00000000-0000-0000-0000-000000000000	9004fe1d-16dd-46c9-9035-761bd08d3bb1	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 13:05:54.355604+00	
00000000-0000-0000-0000-000000000000	4434e206-9709-49b6-a1d3-0cfa23ae628b	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 13:05:54.924036+00	
00000000-0000-0000-0000-000000000000	752272a6-a40f-41af-ad75-d6022dcdedea	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-28 13:07:12.207643+00	
00000000-0000-0000-0000-000000000000	34201b92-9a7b-4236-9d4f-edb657e2614a	{"action":"user_confirmation_requested","actor_id":"550d261b-32d4-479c-ba17-9cca46228b8c","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 13:58:25.412185+00	
00000000-0000-0000-0000-000000000000	bf6df690-fe3b-43a2-8221-920aaeec9ba0	{"action":"user_confirmation_requested","actor_id":"550d261b-32d4-479c-ba17-9cca46228b8c","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 14:01:32.214341+00	
00000000-0000-0000-0000-000000000000	05c2a178-b65b-4cd3-aee2-0fa078517169	{"action":"user_confirmation_requested","actor_id":"550d261b-32d4-479c-ba17-9cca46228b8c","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 14:29:48.579787+00	
00000000-0000-0000-0000-000000000000	e7321c90-d691-42e5-95e3-79ad5c31e1a1	{"action":"user_confirmation_requested","actor_id":"550d261b-32d4-479c-ba17-9cca46228b8c","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 14:33:54.687087+00	
00000000-0000-0000-0000-000000000000	ab43329f-f7dd-4203-a878-05fb5d53ff6c	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"mertckr617@gmail.com","user_id":"550d261b-32d4-479c-ba17-9cca46228b8c","user_phone":""}}	2025-05-28 14:34:55.82387+00	
00000000-0000-0000-0000-000000000000	4f72af1d-439e-4bf1-8db4-8d06a78b7b37	{"action":"user_confirmation_requested","actor_id":"a6809c07-87ce-4901-841e-18716d052af0","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 14:35:00.144587+00	
00000000-0000-0000-0000-000000000000	5b42c9a3-c43f-4b59-a048-d210ee266635	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"mertckr617@gmail.com","user_id":"a6809c07-87ce-4901-841e-18716d052af0","user_phone":""}}	2025-05-28 14:56:33.399115+00	
00000000-0000-0000-0000-000000000000	0f728e1c-0634-4b04-8034-37e3822e0741	{"action":"user_confirmation_requested","actor_id":"0c419582-3cbf-483d-8494-62de937a20bc","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 14:58:06.075179+00	
00000000-0000-0000-0000-000000000000	bcb507ef-97d4-4cd5-9780-c08ea846663c	{"action":"user_confirmation_requested","actor_id":"0c419582-3cbf-483d-8494-62de937a20bc","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 14:59:56.287981+00	
00000000-0000-0000-0000-000000000000	843c0dc3-d123-4914-8b45-91fef4116405	{"action":"user_confirmation_requested","actor_id":"0c419582-3cbf-483d-8494-62de937a20bc","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 15:02:09.478406+00	
00000000-0000-0000-0000-000000000000	73acbd33-a09a-424e-9fc9-5dbb62bc441f	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"mertckr617@gmail.com","user_id":"0c419582-3cbf-483d-8494-62de937a20bc","user_phone":""}}	2025-05-28 15:02:24.489538+00	
00000000-0000-0000-0000-000000000000	50202f8b-b621-4654-af60-335830d86bb0	{"action":"user_confirmation_requested","actor_id":"93223637-a585-4f8c-a8d3-822ad21ecd38","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 15:02:28.159075+00	
00000000-0000-0000-0000-000000000000	a7d7e367-ee82-43bd-8850-fdb7d8953ffc	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"mertckr617@gmail.com","user_id":"93223637-a585-4f8c-a8d3-822ad21ecd38","user_phone":""}}	2025-05-28 15:06:14.397579+00	
00000000-0000-0000-0000-000000000000	aa66f88e-d7b9-4a11-a057-bf006b5734fa	{"action":"user_confirmation_requested","actor_id":"f8321451-1035-4f75-90ec-58232bc44fd8","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 15:07:24.614926+00	
00000000-0000-0000-0000-000000000000	04f4ba4e-312d-4d30-90bf-dd1ea20203cc	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"mertckr617@gmail.com","user_id":"f8321451-1035-4f75-90ec-58232bc44fd8","user_phone":""}}	2025-05-28 15:09:57.612928+00	
00000000-0000-0000-0000-000000000000	7c59adb7-bff2-422f-8354-363b09481bc8	{"action":"user_confirmation_requested","actor_id":"fd481494-4032-40f0-adfd-372d9febf83b","actor_username":"mertckr617@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-28 15:10:04.559827+00	
00000000-0000-0000-0000-000000000000	64166d8f-3fe3-46dd-a111-a9fbff182139	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 10:58:25.965395+00	
00000000-0000-0000-0000-000000000000	580dfb6d-cded-41cb-854d-662f90668e3b	{"action":"login","actor_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 11:00:00.155394+00	
00000000-0000-0000-0000-000000000000	3bcd8ace-a3fc-4efc-82fd-cff07bd77abb	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"mertckr617@gmail.com","user_id":"fd481494-4032-40f0-adfd-372d9febf83b","user_phone":""}}	2025-05-29 11:00:28.3469+00	
00000000-0000-0000-0000-000000000000	e2793995-4cc2-4444-85f3-14113c84ce5e	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hsngrbz7106@gmail.com","user_id":"c48d1384-a4e7-46d3-8d07-8c96c78d8286","user_phone":""}}	2025-05-29 11:01:41.901003+00	
00000000-0000-0000-0000-000000000000	816f3510-ba04-4113-ac42-36695b7a0d0e	{"action":"user_confirmation_requested","actor_id":"d396fa6c-d76c-4ee5-84ed-49175bc4ab46","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-29 11:13:08.720812+00	
00000000-0000-0000-0000-000000000000	1a3764ca-bed3-4b88-ba19-6ae66da9e391	{"action":"user_confirmation_requested","actor_id":"d396fa6c-d76c-4ee5-84ed-49175bc4ab46","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-29 11:14:15.145574+00	
00000000-0000-0000-0000-000000000000	8812c3ff-f546-4c45-871a-85c95eed4bb6	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hsngrbz7106@gmail.com","user_id":"d396fa6c-d76c-4ee5-84ed-49175bc4ab46","user_phone":""}}	2025-05-29 11:15:36.218932+00	
00000000-0000-0000-0000-000000000000	371d742f-a9be-44d4-8071-261ab64100c2	{"action":"user_confirmation_requested","actor_id":"3a2cdb5d-97c1-43dd-aa6f-cd96180f7890","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-29 11:22:19.835652+00	
00000000-0000-0000-0000-000000000000	268c2f67-fbf9-4c0d-89a5-f18179639c24	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hsngrbz7106@gmail.com","user_id":"3a2cdb5d-97c1-43dd-aa6f-cd96180f7890","user_phone":""}}	2025-05-29 11:27:07.505584+00	
00000000-0000-0000-0000-000000000000	d33cf491-5350-4275-bbd0-f0f73df9a44e	{"action":"user_confirmation_requested","actor_id":"0f5ae2ed-1239-4434-858d-4f2deaec03a7","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-29 11:34:50.672174+00	
00000000-0000-0000-0000-000000000000	2dd0489f-4225-48ca-8908-912d79d19d75	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hsngrbz7106@gmail.com","user_id":"0f5ae2ed-1239-4434-858d-4f2deaec03a7","user_phone":""}}	2025-05-29 11:39:02.477923+00	
00000000-0000-0000-0000-000000000000	3349b9cf-7c80-4f0c-9c94-2e46ff960f74	{"action":"login","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 12:00:52.116218+00	
00000000-0000-0000-0000-000000000000	7068c292-ed61-4dfc-bc4c-5b46010af38c	{"action":"token_refreshed","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 16:54:43.915986+00	
00000000-0000-0000-0000-000000000000	f8426ada-aa47-41e6-86c6-662f918c63a8	{"action":"token_revoked","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 16:54:43.919174+00	
00000000-0000-0000-0000-000000000000	89a3595f-c2da-4254-a68b-44cf0cb2e594	{"action":"login","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-29 17:03:51.72952+00	
00000000-0000-0000-0000-000000000000	a651c115-52f7-4bfb-b75b-520e36500ac3	{"action":"token_refreshed","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 19:09:07.592115+00	
00000000-0000-0000-0000-000000000000	8a08be95-e787-4f20-84d0-39a5d78e57e5	{"action":"token_revoked","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 19:09:07.595333+00	
00000000-0000-0000-0000-000000000000	246c66a2-a394-4e5a-8dd4-0506a9493126	{"action":"token_refreshed","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 19:09:08.144572+00	
00000000-0000-0000-0000-000000000000	9fbcc768-3e65-48b2-b907-8e79aeb7161b	{"action":"token_refreshed","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 20:07:38.867747+00	
00000000-0000-0000-0000-000000000000	c1cc7656-91ef-4cd8-813d-e020f1b8c9ca	{"action":"token_revoked","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-29 20:07:38.869748+00	
00000000-0000-0000-0000-000000000000	a5b077c3-8d46-4f50-8a66-c7b9b07d540a	{"action":"token_refreshed","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 12:34:00.33638+00	
00000000-0000-0000-0000-000000000000	f3a61f84-9bbc-4024-91b1-4c963da13f50	{"action":"token_revoked","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 12:34:00.348737+00	
00000000-0000-0000-0000-000000000000	101f1b00-ab11-4ff0-b3af-f9d6a10e5073	{"action":"user_confirmation_requested","actor_id":"04a6506c-805a-440b-a195-1711798d4bda","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-30 13:21:05.555742+00	
00000000-0000-0000-0000-000000000000	9c4d506b-538e-4279-8215-86510bdc3c76	{"action":"token_refreshed","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 13:32:36.595522+00	
00000000-0000-0000-0000-000000000000	5cb7ca27-a6e4-42d2-9d77-79b8d5734365	{"action":"token_revoked","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 13:32:36.597674+00	
00000000-0000-0000-0000-000000000000	a4aaf583-001b-4053-ba7b-68ecb6bd1aed	{"action":"token_refreshed","actor_id":"a25826c2-495d-4234-8e20-97d97f4db18e","actor_username":"alperyigit88@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-05-30 13:32:37.128023+00	
00000000-0000-0000-0000-000000000000	8f9eda76-f420-491f-a326-a44faac4c80f	{"action":"user_confirmation_requested","actor_id":"04a6506c-805a-440b-a195-1711798d4bda","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-30 13:33:00.126104+00	
00000000-0000-0000-0000-000000000000	3ddffe06-4897-4425-a635-f08ccecaabfb	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hsngrbz7106@gmail.com","user_id":"04a6506c-805a-440b-a195-1711798d4bda","user_phone":""}}	2025-05-30 13:33:47.862821+00	
00000000-0000-0000-0000-000000000000	64bdbbd2-63ce-4dcd-b07c-451714b64b9b	{"action":"user_confirmation_requested","actor_id":"1b2d1af3-f014-4dd5-876b-1a626539352e","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-30 13:34:33.770776+00	
00000000-0000-0000-0000-000000000000	9b041eba-ef10-4c19-8578-26213b8f44ca	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hsngrbz7106@gmail.com","user_id":"1b2d1af3-f014-4dd5-876b-1a626539352e","user_phone":""}}	2025-05-30 13:56:52.239455+00	
00000000-0000-0000-0000-000000000000	22f6df55-ac1d-4935-9b1e-3c9b829b141c	{"action":"user_confirmation_requested","actor_id":"20d4d8d6-b32b-4a5d-ac4c-b53bc4d61784","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-30 13:56:54.800036+00	
00000000-0000-0000-0000-000000000000	f316bab2-6e05-4691-ae93-3f88d7c479ed	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hsngrbz7106@gmail.com","user_id":"20d4d8d6-b32b-4a5d-ac4c-b53bc4d61784","user_phone":""}}	2025-05-30 14:01:21.517318+00	
00000000-0000-0000-0000-000000000000	dc0452ed-cda5-4b90-961a-b81cba76023d	{"action":"user_confirmation_requested","actor_id":"68b84fde-eab7-4760-8167-8719373f0389","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-30 14:01:28.723102+00	
00000000-0000-0000-0000-000000000000	790989d4-185c-4e31-bbd2-1559c31da2ee	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hsngrbz7106@gmail.com","user_id":"68b84fde-eab7-4760-8167-8719373f0389","user_phone":""}}	2025-05-30 14:03:53.35398+00	
00000000-0000-0000-0000-000000000000	84f5fd87-988e-458e-baa2-482971b40985	{"action":"user_confirmation_requested","actor_id":"a9b6af35-a4e2-4b7a-8df5-7b714663acd7","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-30 14:07:24.114548+00	
00000000-0000-0000-0000-000000000000	fbfd3b12-4ec5-4f4b-9eff-498423f5df2b	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hsngrbz7106@gmail.com","user_id":"a9b6af35-a4e2-4b7a-8df5-7b714663acd7","user_phone":""}}	2025-05-30 14:21:25.196963+00	
00000000-0000-0000-0000-000000000000	49ff1d56-3f82-487a-8de6-ca5b3a6d474e	{"action":"user_confirmation_requested","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-30 14:24:19.786024+00	
00000000-0000-0000-0000-000000000000	e0fdc7d9-2bf2-4ee7-ba83-f1696415a501	{"action":"user_signedup","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-05-30 14:26:14.535835+00	
00000000-0000-0000-0000-000000000000	a988f8fd-cfff-40b3-8716-3eff86ea11c9	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 14:26:23.087513+00	
00000000-0000-0000-0000-000000000000	77b2d52b-4d89-453e-8813-dac1a07ee70c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 14:28:47.775167+00	
00000000-0000-0000-0000-000000000000	c9afaa90-39ef-4ecf-8e83-58861ddb4d14	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 15:19:31.626394+00	
00000000-0000-0000-0000-000000000000	9a227a80-0c9d-4ef5-afb6-c82b5fce7323	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"mertar24@gmail.com","user_id":"39e2cfca-b6b4-4c59-81fd-4f987a40fee7","user_phone":""}}	2025-05-30 15:22:22.66993+00	
00000000-0000-0000-0000-000000000000	bd2108c3-11f0-4d2d-8310-1735dfb32ebb	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 15:24:07.532456+00	
00000000-0000-0000-0000-000000000000	0af964b0-f4eb-4c70-989d-fc7984b6646f	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hasan.gurbuz@std.yeditepe.edu.tr","user_id":"3cf0aabd-5636-4ef9-9a6b-45e24108e7f8","user_phone":""}}	2025-05-30 15:26:43.126415+00	
00000000-0000-0000-0000-000000000000	380327a6-2602-4bb1-8753-090fc6b6a1ca	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hasan132@gmail.com","user_id":"627fadd6-219b-402f-a488-28ce18b20871","user_phone":""}}	2025-05-30 15:26:43.139874+00	
00000000-0000-0000-0000-000000000000	a425dde7-82eb-426a-955d-641f8e0b4458	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hasangurbuz@gmail.com","user_id":"65cb989d-fe8e-4c54-9880-5ac41d12d4ff","user_phone":""}}	2025-05-30 15:26:43.142222+00	
00000000-0000-0000-0000-000000000000	b29531e1-67de-42fa-b8cc-26496952939c	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"hasangurbuzc@gmail.com","user_id":"f7deb273-37b9-42cf-94df-c235b9f2fb54","user_phone":""}}	2025-05-30 15:26:43.229777+00	
00000000-0000-0000-0000-000000000000	760c095c-27ff-4280-8c8e-bd8d3adb0aad	{"action":"user_confirmation_requested","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-30 15:27:31.704388+00	
00000000-0000-0000-0000-000000000000	0b0c6139-5100-434d-a66c-ce451b8afa96	{"action":"user_signedup","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-05-30 15:27:46.29928+00	
00000000-0000-0000-0000-000000000000	86bed154-89c7-4c2c-b2e9-355427f6a4b0	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 15:27:56.823482+00	
00000000-0000-0000-0000-000000000000	9e83db70-9808-4ee0-b5ac-d62694896e5d	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 15:34:52.72758+00	
00000000-0000-0000-0000-000000000000	35ca7235-ed17-4f95-9501-975f7c472a95	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 15:35:22.409172+00	
00000000-0000-0000-0000-000000000000	1cfb5f27-91cb-432e-9fc0-3e63acd012e7	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 15:35:27.623364+00	
00000000-0000-0000-0000-000000000000	c8779cca-57d3-420e-9fe8-2edaaba2057e	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 15:35:52.661304+00	
00000000-0000-0000-0000-000000000000	ee9ebd78-b6e6-4415-915d-af6137d57a6d	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 15:38:18.683336+00	
00000000-0000-0000-0000-000000000000	a7fcc244-0b47-45b6-a355-cde3fa846d7c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 15:38:25.599121+00	
00000000-0000-0000-0000-000000000000	548de50a-6d90-412e-9dea-9905d0481281	{"action":"user_confirmation_requested","actor_id":"21b90ff0-ccfb-48f4-9682-9cad592c8542","actor_username":"incidenizkilicaslan@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-05-30 16:22:35.608582+00	
00000000-0000-0000-0000-000000000000	cf48093e-c212-4fcb-ac0a-92a9dac1b4be	{"action":"user_signedup","actor_id":"21b90ff0-ccfb-48f4-9682-9cad592c8542","actor_username":"incidenizkilicaslan@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-05-30 16:23:10.338774+00	
00000000-0000-0000-0000-000000000000	1c0e277c-d7f3-4dc6-8d48-1dfd894bb442	{"action":"login","actor_id":"21b90ff0-ccfb-48f4-9682-9cad592c8542","actor_username":"incidenizkilicaslan@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 16:23:19.15253+00	
00000000-0000-0000-0000-000000000000	6aeebb2e-fe92-4ed3-b467-2e5ffd3eb800	{"action":"login","actor_id":"21b90ff0-ccfb-48f4-9682-9cad592c8542","actor_username":"incidenizkilicaslan@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 16:25:30.347216+00	
00000000-0000-0000-0000-000000000000	328987b9-fdd9-4da9-bed6-b4e7f1af1e9e	{"action":"logout","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-05-30 16:25:55.098786+00	
00000000-0000-0000-0000-000000000000	860454fc-a970-4bb4-a749-b3ad27a29061	{"action":"login","actor_id":"21b90ff0-ccfb-48f4-9682-9cad592c8542","actor_username":"incidenizkilicaslan@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-05-30 16:57:43.925074+00	
00000000-0000-0000-0000-000000000000	03a1b6a0-e565-4415-a4cb-6ab3041ed4a6	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 11:44:02.061614+00	
00000000-0000-0000-0000-000000000000	de1c167a-6d0c-4b82-babe-0d886a886e5e	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 11:50:19.954907+00	
00000000-0000-0000-0000-000000000000	61f70fee-c977-41ab-acf6-a8afb55c24bd	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:35:07.623789+00	
00000000-0000-0000-0000-000000000000	2d846cb2-1974-488a-b595-df0f57d5e825	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:35:15.656537+00	
00000000-0000-0000-0000-000000000000	a7fad36b-a805-4017-8d26-33290bf8790e	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:35:27.790707+00	
00000000-0000-0000-0000-000000000000	3c1f88ea-32a4-4032-bcbc-0e488f05daa8	{"action":"user_confirmation_requested","actor_id":"c52985ac-c3c0-4555-ae52-3c1486f814f0","actor_username":"testuser@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-01 14:37:45.35582+00	
00000000-0000-0000-0000-000000000000	21ff78c5-eca8-47c1-87f3-c5f3b0cbbd81	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:39:05.202177+00	
00000000-0000-0000-0000-000000000000	59b0d820-c910-46f6-a218-780c406bf109	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:41:41.961819+00	
00000000-0000-0000-0000-000000000000	3a9830f4-8149-4d10-8895-ea3ea45de49c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:42:01.631368+00	
00000000-0000-0000-0000-000000000000	cc539c53-9897-47e6-ad9f-7525730ff724	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:42:12.25872+00	
00000000-0000-0000-0000-000000000000	8305aa05-7637-4fdb-8b2b-ad4caad742ff	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:42:59.078409+00	
00000000-0000-0000-0000-000000000000	c7c8630f-2c49-44b3-bf1e-fe6e2e470a75	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:44:04.968884+00	
00000000-0000-0000-0000-000000000000	9dbb3df9-624d-462c-87d2-b140897adb6b	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:47:52.661869+00	
00000000-0000-0000-0000-000000000000	2cbd288a-6371-4059-8ad6-a1e7180ad880	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:50:03.900328+00	
00000000-0000-0000-0000-000000000000	89e56ee5-e900-4b1f-b82b-c8c3b232baa4	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 14:59:41.02878+00	
00000000-0000-0000-0000-000000000000	aaa2165a-5e78-4ecc-bc84-5b18a97862da	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 15:04:40.156751+00	
00000000-0000-0000-0000-000000000000	280f0b03-b937-4dd3-908a-07334b62ece1	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 15:16:23.296937+00	
00000000-0000-0000-0000-000000000000	0ae20c89-c832-40a3-9ca3-5e113aa7ef07	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 15:34:41.655139+00	
00000000-0000-0000-0000-000000000000	656b1597-fab0-49ae-b057-6b07045d9c25	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 16:15:07.315518+00	
00000000-0000-0000-0000-000000000000	95ea156f-5b4f-400e-85c2-be83c79f9285	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 16:19:55.616666+00	
00000000-0000-0000-0000-000000000000	cc963d25-b94c-4551-aeb3-d5949834e66c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 16:20:43.528366+00	
00000000-0000-0000-0000-000000000000	441333a6-cf82-4f02-9ee4-def71985fe8c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 16:23:13.501652+00	
00000000-0000-0000-0000-000000000000	464ac670-8a3e-406b-a0bb-3dee4c59dd35	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 16:25:46.297079+00	
00000000-0000-0000-0000-000000000000	d1c823ad-3f61-4faa-aa5e-f0f8332c71d9	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:10:25.662717+00	
00000000-0000-0000-0000-000000000000	e7248168-f64c-439d-94ac-8f2d0190f193	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:10:43.341677+00	
00000000-0000-0000-0000-000000000000	b01c2446-1a50-475c-b778-f45509aa01a2	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 17:12:01.786829+00	
00000000-0000-0000-0000-000000000000	82396659-1394-4c7a-af29-4e8c1fd1b2df	{"action":"token_refreshed","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-01 18:12:57.070101+00	
00000000-0000-0000-0000-000000000000	e7c2a4ad-a7be-4835-9c89-7c103f9672f1	{"action":"token_revoked","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-01 18:12:57.072534+00	
00000000-0000-0000-0000-000000000000	2e9ae3e7-fc49-4631-9b7f-092564997f60	{"action":"token_refreshed","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-01 19:11:27.228094+00	
00000000-0000-0000-0000-000000000000	f43924a8-619a-401c-8051-378a638bc1c3	{"action":"token_revoked","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-01 19:11:27.231161+00	
00000000-0000-0000-0000-000000000000	d0cfb62e-393f-4618-9390-6fde71193bb1	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 20:29:20.860423+00	
00000000-0000-0000-0000-000000000000	5cf68dcd-1b56-4beb-8e3c-0182b8d518f3	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 20:36:51.288387+00	
00000000-0000-0000-0000-000000000000	662594fb-d7b5-47c9-907f-b2f762d7b508	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 20:40:08.415297+00	
00000000-0000-0000-0000-000000000000	1c4bf4bf-eb81-4e50-a921-1f1136a1b0e5	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 20:45:04.125245+00	
00000000-0000-0000-0000-000000000000	eea71e4c-c133-4457-8d38-77715194aa97	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 20:49:12.732397+00	
00000000-0000-0000-0000-000000000000	a5defff7-5ecd-4033-9023-dcfef901e14c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 21:00:12.340253+00	
00000000-0000-0000-0000-000000000000	2db04151-a7eb-4d37-9226-722a7c0aee98	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 21:06:00.800235+00	
00000000-0000-0000-0000-000000000000	7b50df6f-3ce2-43c4-9699-a45cc916aaa4	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 21:10:57.773151+00	
00000000-0000-0000-0000-000000000000	2c3dd68b-d123-440f-b790-99ee775e8d53	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 21:14:42.992267+00	
00000000-0000-0000-0000-000000000000	c670c93a-fd7e-4227-83ab-5f941affdc1c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-01 21:15:00.463105+00	
00000000-0000-0000-0000-000000000000	86054878-d40a-4bcb-89ab-136f42716288	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 10:22:46.653011+00	
00000000-0000-0000-0000-000000000000	b8858a8c-1b3e-4eab-b179-2ac6197e7f54	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 11:10:01.979876+00	
00000000-0000-0000-0000-000000000000	2e3a641c-29ec-4fe0-9465-fcafe47af5b7	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 11:26:03.7977+00	
00000000-0000-0000-0000-000000000000	6d9dd600-d487-4e99-a750-2a34547df021	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 11:44:05.868766+00	
00000000-0000-0000-0000-000000000000	bae0c9b5-4861-43f0-895d-5723741c59fc	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 13:20:05.965355+00	
00000000-0000-0000-0000-000000000000	cb44d85b-71be-426e-a884-062683f5bdf7	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 13:20:16.917354+00	
00000000-0000-0000-0000-000000000000	90d5e798-9142-477c-b5c5-0099b9e594f6	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 15:21:42.448059+00	
00000000-0000-0000-0000-000000000000	1c08bc59-ab96-43f2-b967-6028d861e5da	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 15:22:56.398096+00	
00000000-0000-0000-0000-000000000000	02ea54e6-aa28-4fe0-a76b-1903546efda4	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 15:30:25.095343+00	
00000000-0000-0000-0000-000000000000	f1e9055a-c4b0-4d72-9030-54a70e7e0cc2	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 15:37:36.334+00	
00000000-0000-0000-0000-000000000000	e3e4b245-6ddb-4180-a0fb-f2e46bd97ee3	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 15:37:45.481085+00	
00000000-0000-0000-0000-000000000000	60dbd9ff-cdf3-41bd-8c1a-e02c00b5b714	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 15:42:08.76926+00	
00000000-0000-0000-0000-000000000000	1d409b70-fe38-4491-b05a-ffe0dcfe915c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-02 15:47:24.48443+00	
00000000-0000-0000-0000-000000000000	0523536c-c8bf-4824-b9f6-402957ca2f60	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 09:08:42.929925+00	
00000000-0000-0000-0000-000000000000	6689f653-a71f-41d1-a9f6-54b21d975711	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 09:57:16.961793+00	
00000000-0000-0000-0000-000000000000	8a3b3e5c-7c32-464a-af0e-f74cb96ab20a	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 16:01:48.652066+00	
00000000-0000-0000-0000-000000000000	6024034e-15a2-4a2f-81c9-a2e3e792246c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 17:04:09.736675+00	
00000000-0000-0000-0000-000000000000	1a9d3b3f-a1d8-450a-be51-ca02bf060e6f	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 17:15:27.035012+00	
00000000-0000-0000-0000-000000000000	7e752808-5e06-438a-9d2d-43ad7124372c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-03 17:44:49.47183+00	
00000000-0000-0000-0000-000000000000	4d336257-f865-4da2-a8e8-d95eccfe1af3	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 09:23:00.040957+00	
00000000-0000-0000-0000-000000000000	406a932f-73d3-47b5-b767-173ca2a0c26e	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-05 09:57:36.20225+00	
00000000-0000-0000-0000-000000000000	ae90d98e-edb8-4288-b621-8ee73ad0fb71	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-09 12:01:13.527294+00	
00000000-0000-0000-0000-000000000000	f7e54add-6219-419a-a6dd-0a709d232fea	{"action":"token_refreshed","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-09 12:59:26.382553+00	
00000000-0000-0000-0000-000000000000	99ec1164-2f04-4446-97c6-bfcedc0075e7	{"action":"token_revoked","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-09 12:59:26.386514+00	
00000000-0000-0000-0000-000000000000	a70ebbd5-0895-4879-9c28-0b83bb41542d	{"action":"token_refreshed","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-09 13:57:26.556117+00	
00000000-0000-0000-0000-000000000000	6d84dd5d-f5ea-47c8-9c3f-f3c2ca431112	{"action":"token_revoked","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-09 13:57:26.559965+00	
00000000-0000-0000-0000-000000000000	823fb235-e020-4ee8-87b3-a20a2e98449b	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 13:29:25.446862+00	
00000000-0000-0000-0000-000000000000	7bfdf8b2-0d14-4d08-b034-9286beab0486	{"action":"user_confirmation_requested","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-10 13:38:10.404537+00	
00000000-0000-0000-0000-000000000000	19871a0b-341d-4d9b-84a8-e35e30d63848	{"action":"user_signedup","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"team"}	2025-06-10 13:40:10.105712+00	
00000000-0000-0000-0000-000000000000	acbae62f-8d29-4654-ad68-c5bd169bd360	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 13:40:18.782618+00	
00000000-0000-0000-0000-000000000000	9066bc0a-1124-4818-b7f2-f745fc2ed51f	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 13:41:19.068986+00	
00000000-0000-0000-0000-000000000000	3d41c4f9-954b-4978-97e4-16cade3f507e	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 13:58:14.058602+00	
00000000-0000-0000-0000-000000000000	b9eeb7d3-4e17-44be-b8c9-22d95333ca21	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 14:05:08.448651+00	
00000000-0000-0000-0000-000000000000	69c0c2d1-e51c-4f0c-b682-f3bdcfddb0f4	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 14:11:36.290606+00	
00000000-0000-0000-0000-000000000000	fc2657a9-5c25-43b1-8549-eb415350dbe7	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 14:16:27.833086+00	
00000000-0000-0000-0000-000000000000	7c809a28-aab6-4d06-8c7a-1eb82889899c	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 14:25:00.705805+00	
00000000-0000-0000-0000-000000000000	9c2ab614-66e2-4771-ac4b-c0823cb6d9f2	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 14:29:02.261112+00	
00000000-0000-0000-0000-000000000000	d8dcc05e-d18d-4eb2-985a-2b8c996789ed	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 14:29:14.675147+00	
00000000-0000-0000-0000-000000000000	9c7655f3-f53f-4602-b0ab-8f837ee7d5e3	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 14:44:21.02394+00	
00000000-0000-0000-0000-000000000000	3e8c181e-990b-4d7d-9bef-295eda13bb85	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 14:45:50.70592+00	
00000000-0000-0000-0000-000000000000	f1c926d7-6d0c-4766-9587-306f1e4e08dd	{"action":"token_refreshed","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-10 15:51:15.978437+00	
00000000-0000-0000-0000-000000000000	b88e6579-5307-4472-967b-2f0d64a5e89b	{"action":"token_revoked","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-10 15:51:15.988523+00	
00000000-0000-0000-0000-000000000000	0d505227-86a5-4334-b5c3-3a45c313de99	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-10 16:12:53.968822+00	
00000000-0000-0000-0000-000000000000	54a4b96f-7192-4d26-9df0-0c596d602bb6	{"action":"token_refreshed","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-10 17:11:44.632136+00	
00000000-0000-0000-0000-000000000000	f0612be0-28db-483f-950e-c967157b8437	{"action":"token_revoked","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-10 17:11:44.635873+00	
00000000-0000-0000-0000-000000000000	68a8eaa9-ca3c-4908-be70-ca613ee4f0e0	{"action":"token_refreshed","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-10 19:09:07.51877+00	
00000000-0000-0000-0000-000000000000	32276c70-459f-43ec-9f1e-41f8f380582b	{"action":"token_revoked","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-06-10 19:09:07.522268+00	
00000000-0000-0000-0000-000000000000	37083eb4-6743-46b0-89f7-99a0fda4948c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:23:21.497671+00	
00000000-0000-0000-0000-000000000000	67575e24-ba82-4531-b185-226c81747486	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:23:28.983138+00	
00000000-0000-0000-0000-000000000000	0d298fcd-f1f7-4a60-a29e-107dfd14957a	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:23:30.496828+00	
00000000-0000-0000-0000-000000000000	16b57951-3e76-4066-ad2a-2ff8ab91f12d	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"incidenizkilicaslan@gmail.com","user_id":"21b90ff0-ccfb-48f4-9682-9cad592c8542","user_phone":""}}	2025-06-13 17:24:54.054615+00	
00000000-0000-0000-0000-000000000000	95fcb22a-50c8-446e-8969-c909e4339395	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:37:40.376078+00	
00000000-0000-0000-0000-000000000000	dc909b2d-6d33-49bf-8f1c-8ad61cbe6e79	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:39:10.389241+00	
00000000-0000-0000-0000-000000000000	b7379053-da4d-4ea0-8891-7281e04a7af2	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:47:01.856993+00	
00000000-0000-0000-0000-000000000000	674b18e1-3f45-4606-9b72-c0d2edeabd7b	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:47:06.552571+00	
00000000-0000-0000-0000-000000000000	c3c127fd-04c1-4376-82af-879e1db73cc8	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:47:30.112804+00	
00000000-0000-0000-0000-000000000000	08d0af41-f5c7-43cd-a15e-4cb53153caba	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:47:40.774673+00	
00000000-0000-0000-0000-000000000000	80dfe0ee-7b4a-48ea-8890-02d2e9c82ede	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:48:54.538613+00	
00000000-0000-0000-0000-000000000000	5fe61879-a180-4eec-99d8-9a4662a853ae	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:50:59.244534+00	
00000000-0000-0000-0000-000000000000	2364c549-4650-45c0-977b-170f5f520fe0	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:51:50.12243+00	
00000000-0000-0000-0000-000000000000	57a50141-e34d-4e85-973f-70f73b7d30bb	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:52:02.721583+00	
00000000-0000-0000-0000-000000000000	54af7171-bbaf-4064-ade1-150fce7f18d0	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:53:27.00847+00	
00000000-0000-0000-0000-000000000000	86b24f34-af2c-4569-b1c6-d5a178a14c95	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:55:36.199374+00	
00000000-0000-0000-0000-000000000000	b9c30263-50a7-4e9e-bb61-a9512d6dac76	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:57:04.485664+00	
00000000-0000-0000-0000-000000000000	025dc0bc-34c6-43db-b8ef-5f06816aaac9	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:57:15.252343+00	
00000000-0000-0000-0000-000000000000	6456b997-d39d-42c7-919f-90989c98c25f	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:57:19.015255+00	
00000000-0000-0000-0000-000000000000	fa8f85a7-8500-4871-a34a-ca28eb64f846	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 17:57:29.572653+00	
00000000-0000-0000-0000-000000000000	0ba78bae-4ed6-4028-86c2-24f35ecc70c2	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:06:06.392847+00	
00000000-0000-0000-0000-000000000000	d54d3462-e0c3-48f3-8e03-46380a1851e9	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:08:51.095247+00	
00000000-0000-0000-0000-000000000000	80c6d344-fcb8-4928-a584-731a887766d4	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:08:56.505831+00	
00000000-0000-0000-0000-000000000000	12f24aae-200d-43e8-822e-138e4cb27c2d	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:12:32.469278+00	
00000000-0000-0000-0000-000000000000	811a41c9-f85d-43de-ad48-730c049ab71f	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:12:37.575136+00	
00000000-0000-0000-0000-000000000000	a14a9b32-2cfc-46f1-a236-7862b672de7d	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:16:10.730917+00	
00000000-0000-0000-0000-000000000000	151fc636-1fa7-4026-a2ee-4aa8737958a6	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:16:29.549733+00	
00000000-0000-0000-0000-000000000000	374016a2-9b47-4db5-b4b9-01c43b28aabf	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:17:58.881425+00	
00000000-0000-0000-0000-000000000000	f54f7eb4-3673-49f4-854d-d785e3a3021c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:18:13.755406+00	
00000000-0000-0000-0000-000000000000	349c19c2-90d6-45de-bd76-1256a590c94e	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:20:33.287625+00	
00000000-0000-0000-0000-000000000000	c604e527-235d-4519-8ded-883552a2c0cf	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:20:43.600005+00	
00000000-0000-0000-0000-000000000000	388245ad-0cd7-4a55-b4ae-91ada706ab0a	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:22:55.147778+00	
00000000-0000-0000-0000-000000000000	a3b2ff65-d068-4bd4-be96-bf21f29cabe0	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:23:06.834791+00	
00000000-0000-0000-0000-000000000000	7ef93d0c-a7a9-473c-828d-d8f3696ccdfb	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:24:19.96417+00	
00000000-0000-0000-0000-000000000000	79ba9e2e-bff9-40fc-ba6b-c6bcaa3173d4	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:24:32.500927+00	
00000000-0000-0000-0000-000000000000	8e4bb92f-6a3f-4b8e-99ab-0c22b4cb834a	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:25:51.196555+00	
00000000-0000-0000-0000-000000000000	723ea3e8-c505-4226-aec7-9ac0e0747302	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:34:42.603262+00	
00000000-0000-0000-0000-000000000000	13e4c0b6-0e34-4810-a752-fb1b0459dfc9	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:36:07.032752+00	
00000000-0000-0000-0000-000000000000	c12ac2f0-b46c-4203-9740-72fc67134472	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:38:56.079626+00	
00000000-0000-0000-0000-000000000000	e170966e-26a9-434e-9973-6cc0877abda8	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:39:23.045675+00	
00000000-0000-0000-0000-000000000000	5f205214-3602-4537-be2f-1cdfd0e5aeb4	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:41:27.246012+00	
00000000-0000-0000-0000-000000000000	781daac2-bdee-489b-b30b-870931d89301	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:41:37.968777+00	
00000000-0000-0000-0000-000000000000	b4217d04-1a15-4336-9fea-2f29c13b4bf7	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:43:40.436325+00	
00000000-0000-0000-0000-000000000000	e0bc8c4f-abd7-4fbe-af35-d634404af120	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:43:49.312498+00	
00000000-0000-0000-0000-000000000000	1a854505-ff94-4103-adc1-03ecd008fcd7	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:43:54.23584+00	
00000000-0000-0000-0000-000000000000	91b7d40e-f689-4e88-83f2-e0eb36938795	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:44:07.499221+00	
00000000-0000-0000-0000-000000000000	75d9db5a-bcca-4a43-8900-390516db7872	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:45:31.569225+00	
00000000-0000-0000-0000-000000000000	c9e02000-4632-4a47-be76-72ccd4d99441	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:45:36.727094+00	
00000000-0000-0000-0000-000000000000	fbe6c010-945b-4f46-9942-8e0db8271967	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:46:54.209311+00	
00000000-0000-0000-0000-000000000000	3f7da11e-5fb7-4526-bf84-d37d0c3c7232	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:49:17.969866+00	
00000000-0000-0000-0000-000000000000	de3d2390-897f-44a5-8564-aab321571ab6	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:49:24.32884+00	
00000000-0000-0000-0000-000000000000	a54e06d8-b8b1-42e6-ac60-6b29fedefcf4	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 18:50:37.811571+00	
00000000-0000-0000-0000-000000000000	765a43b0-30f3-4644-9625-e774073f1f33	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 19:28:26.94482+00	
00000000-0000-0000-0000-000000000000	9a2d0093-d408-4595-96a1-d3262fdb9dd2	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 19:31:19.471478+00	
00000000-0000-0000-0000-000000000000	67966144-bf0f-4d01-ae0c-a909f357e25d	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 19:31:26.313097+00	
00000000-0000-0000-0000-000000000000	1e157c19-529f-4bde-bd73-0a46aacf8e8f	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 19:33:29.521846+00	
00000000-0000-0000-0000-000000000000	aa471a52-2e80-4edd-bfeb-fe9dd2ef9e8c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 19:34:15.198702+00	
00000000-0000-0000-0000-000000000000	4a7b27b6-3611-467b-94ae-ba29e4cbd12a	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 20:33:03.550003+00	
00000000-0000-0000-0000-000000000000	2737dbd8-2ed5-4d37-a4c6-0f061674d2a4	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 20:33:10.332128+00	
00000000-0000-0000-0000-000000000000	451bcd6a-0887-4e8f-987c-4828ad39cf88	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 20:36:37.796031+00	
00000000-0000-0000-0000-000000000000	e4ee0039-c210-4ed3-96f7-720c86c6eff7	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 20:40:59.246799+00	
00000000-0000-0000-0000-000000000000	afa80460-756f-4c09-a736-053205ceacd5	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 20:47:18.851454+00	
00000000-0000-0000-0000-000000000000	fb7c0d47-75d9-4538-917b-a0846e6aaf55	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 20:49:53.55768+00	
00000000-0000-0000-0000-000000000000	b678d390-a3e4-47b8-a3d5-380146ec726b	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 20:50:57.478435+00	
00000000-0000-0000-0000-000000000000	a8118bea-a917-4c15-9b0d-9f40b122a315	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 20:58:53.753095+00	
00000000-0000-0000-0000-000000000000	f3d703a3-9d86-45fc-9d94-7b0383704d01	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 21:14:03.5603+00	
00000000-0000-0000-0000-000000000000	4423c9ac-45e8-4cc7-8c0a-5ce29935422c	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 21:18:37.896878+00	
00000000-0000-0000-0000-000000000000	1639f21c-531c-445d-91c2-08872e597458	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 21:24:11.954255+00	
00000000-0000-0000-0000-000000000000	0d272921-1231-47a7-a439-e2d6c4e5cd43	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 21:37:11.963322+00	
00000000-0000-0000-0000-000000000000	6ba32606-2f88-4297-8f1d-fe8e32c64fbf	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 21:37:12.332259+00	
00000000-0000-0000-0000-000000000000	d2663916-d524-4420-b207-f9585add0d9e	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 21:54:27.585868+00	
00000000-0000-0000-0000-000000000000	aefd2fb7-a02a-4787-b62d-1e9ea666e2d3	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-13 21:56:16.721069+00	
00000000-0000-0000-0000-000000000000	ea14cbce-885a-4003-9a1e-3144b6b3b3b7	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-14 13:36:05.940942+00	
00000000-0000-0000-0000-000000000000	6c23a16d-764b-48f9-9ca4-ff3d92a76e7f	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-14 13:36:44.717986+00	
00000000-0000-0000-0000-000000000000	adc6dd7e-3a72-472c-9450-3c3084749234	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-14 13:36:59.627018+00	
00000000-0000-0000-0000-000000000000	ae5ab254-9280-41eb-abad-02fdf6f6e53f	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-14 13:37:46.867362+00	
00000000-0000-0000-0000-000000000000	a839f9ba-5d33-4b9b-8629-47ae0cdc6964	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-14 13:51:35.527449+00	
00000000-0000-0000-0000-000000000000	aae17f18-c419-4885-b445-6df61aeef402	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-14 13:53:36.329669+00	
00000000-0000-0000-0000-000000000000	16d94ef2-a8d9-4dbb-9029-448125d76b4b	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-16 13:31:48.764752+00	
00000000-0000-0000-0000-000000000000	fa68c767-a999-413c-a2ec-75b08c0b1639	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-16 13:33:50.81852+00	
00000000-0000-0000-0000-000000000000	6d232090-f9a2-461e-b182-e5059a863483	{"action":"user_confirmation_requested","actor_id":"bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c","actor_username":"eren-omur@hotmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-16 13:41:46.541132+00	
00000000-0000-0000-0000-000000000000	cb342115-cfe7-4fcb-8674-f178e2e74108	{"action":"user_confirmation_requested","actor_id":"bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c","actor_username":"eren-omur@hotmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-16 13:43:19.30815+00	
00000000-0000-0000-0000-000000000000	a32f5a38-4785-4897-a9bf-34ed37f31cc3	{"action":"user_signedup","actor_id":"bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c","actor_username":"eren-omur@hotmail.com","actor_via_sso":false,"log_type":"team"}	2025-06-16 13:44:41.888692+00	
00000000-0000-0000-0000-000000000000	79b343aa-de55-478b-ad6c-997406af11b8	{"action":"login","actor_id":"bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c","actor_username":"eren-omur@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-16 13:45:42.311727+00	
00000000-0000-0000-0000-000000000000	5238aabc-b953-489c-99d2-693ac58a21af	{"action":"login","actor_id":"bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c","actor_username":"eren-omur@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-16 13:45:52.96058+00	
00000000-0000-0000-0000-000000000000	b7753da4-4840-436f-9f74-4f421ee08273	{"action":"login","actor_id":"bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c","actor_username":"eren-omur@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-16 13:46:19.888442+00	
00000000-0000-0000-0000-000000000000	486a09b8-86ac-4753-9dda-c02b5a7a7cd2	{"action":"user_confirmation_requested","actor_id":"fd9ce997-3b05-471e-9d87-1f82688b9d97","actor_username":"iremkivraak2003@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-16 15:22:23.142191+00	
00000000-0000-0000-0000-000000000000	4e79ee33-e9fb-4d77-b966-ae98b2a4672b	{"action":"user_signedup","actor_id":"fd9ce997-3b05-471e-9d87-1f82688b9d97","actor_username":"iremkivraak2003@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-06-16 15:22:40.006846+00	
00000000-0000-0000-0000-000000000000	642b2775-0dac-4904-a031-5733c6bd5241	{"action":"login","actor_id":"fd9ce997-3b05-471e-9d87-1f82688b9d97","actor_username":"iremkivraak2003@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-16 15:23:23.271122+00	
00000000-0000-0000-0000-000000000000	b506f797-ea7a-45c6-98c5-d0c5df418178	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-16 15:25:13.424238+00	
00000000-0000-0000-0000-000000000000	f3e1a830-d9a5-4c79-bcbe-321b809ad536	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 13:35:22.257604+00	
00000000-0000-0000-0000-000000000000	6750fde9-1683-42c0-bee6-28233780c812	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 13:35:50.409503+00	
00000000-0000-0000-0000-000000000000	95f861c6-d260-4606-9cc9-f05aa4564932	{"action":"login","actor_id":"e2696184-e809-4108-b08b-ece20065cde3","actor_username":"efesecen@hotmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 15:02:05.368548+00	
00000000-0000-0000-0000-000000000000	7883adaa-f460-4a4d-8fd4-3f9786e1043f	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 15:02:12.685733+00	
00000000-0000-0000-0000-000000000000	2ab79e65-43e4-4634-9c39-f5a1cdb98756	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 15:02:22.238955+00	
00000000-0000-0000-0000-000000000000	aa516b42-b3aa-4ede-8a7c-2d2ca8c3bca4	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 15:18:17.106581+00	
00000000-0000-0000-0000-000000000000	f6a0e335-e44c-4a96-9e81-5b51494691aa	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 15:19:04.305963+00	
00000000-0000-0000-0000-000000000000	2e5650ad-e9a2-481c-9fbb-3a74cc1ff40b	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 15:24:02.894891+00	
00000000-0000-0000-0000-000000000000	0affbe73-c667-4123-a67b-b4106660ee59	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 15:25:49.945118+00	
00000000-0000-0000-0000-000000000000	db363c0d-8639-442a-be96-881ccb6ef206	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 15:26:04.432942+00	
00000000-0000-0000-0000-000000000000	4bb87ce2-05da-4c56-9a9b-be900ee81e9a	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 15:26:09.898953+00	
00000000-0000-0000-0000-000000000000	6c593d17-9c22-42f4-8bf1-96e715e46be6	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 15:30:26.537216+00	
00000000-0000-0000-0000-000000000000	648c522f-9ef5-4274-9443-cd507ea3c052	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 15:30:37.152085+00	
00000000-0000-0000-0000-000000000000	f26b027b-2817-4140-b498-20a39ffb4dca	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 17:36:10.720355+00	
00000000-0000-0000-0000-000000000000	1d08c32c-f8fb-4dda-803c-0d94f2f200c4	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-17 17:37:35.30155+00	
00000000-0000-0000-0000-000000000000	09b1f803-ff15-4f62-8456-365375b10a01	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-19 11:52:38.102626+00	
00000000-0000-0000-0000-000000000000	66771f43-0a5d-4bb0-bad3-bcaac090438f	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-19 11:52:46.503182+00	
00000000-0000-0000-0000-000000000000	6cd73920-490e-46cd-ba8c-9e73fd083fb5	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-19 11:54:56.298968+00	
00000000-0000-0000-0000-000000000000	0374f0fd-9c8a-4679-99b6-7b5def26fb88	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-19 12:00:16.991032+00	
00000000-0000-0000-0000-000000000000	480eaace-fdf2-4799-8bff-9075e0d00917	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-19 12:01:04.991909+00	
00000000-0000-0000-0000-000000000000	de677ca8-23fa-41f0-a3f1-12c693e48a3d	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-19 12:03:46.478622+00	
00000000-0000-0000-0000-000000000000	ed7965f1-3b62-48d6-a191-999d9a5f7a8f	{"action":"login","actor_id":"8211960d-7c4c-4fc3-9816-370d52dda6c8","actor_username":"hsngrbz7106@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-19 12:04:56.308243+00	
00000000-0000-0000-0000-000000000000	ca4ae39d-75fd-4d7e-8047-f3d8ed82fe4e	{"action":"login","actor_id":"589ba55a-f5c6-4880-b814-b23632e637a4","actor_username":"hasangurbuzc@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-19 12:06:51.762819+00	
\.


--
-- TOC entry 4028 (class 0 OID 16907)
-- Dependencies: 290
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- TOC entry 4019 (class 0 OID 16704)
-- Dependencies: 281
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
fd9ce997-3b05-471e-9d87-1f82688b9d97	fd9ce997-3b05-471e-9d87-1f82688b9d97	{"sub": "fd9ce997-3b05-471e-9d87-1f82688b9d97", "email": "iremkivraak2003@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-06-16 15:22:23.136465+00	2025-06-16 15:22:23.136514+00	2025-06-16 15:22:23.136514+00	f8cb7fd0-1e08-47ce-aaf0-711e13c807a9
a25826c2-495d-4234-8e20-97d97f4db18e	a25826c2-495d-4234-8e20-97d97f4db18e	{"sub": "a25826c2-495d-4234-8e20-97d97f4db18e", "email": "alperyigit88@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-05-26 12:48:12.036694+00	2025-05-26 12:48:12.03676+00	2025-05-26 12:48:12.03676+00	e68620e3-ce4b-4fcf-8c51-b59fb96c94de
8211960d-7c4c-4fc3-9816-370d52dda6c8	8211960d-7c4c-4fc3-9816-370d52dda6c8	{"sub": "8211960d-7c4c-4fc3-9816-370d52dda6c8", "email": "hsngrbz7106@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-05-30 14:24:19.781581+00	2025-05-30 14:24:19.781629+00	2025-05-30 14:24:19.781629+00	b0a05d07-a1b3-488c-9403-56800aaee03b
589ba55a-f5c6-4880-b814-b23632e637a4	589ba55a-f5c6-4880-b814-b23632e637a4	{"sub": "589ba55a-f5c6-4880-b814-b23632e637a4", "email": "hasangurbuzc@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-05-30 15:27:31.700082+00	2025-05-30 15:27:31.700132+00	2025-05-30 15:27:31.700132+00	fcd9d58a-2f8a-4dce-8e59-e7e2cd722c2e
c52985ac-c3c0-4555-ae52-3c1486f814f0	c52985ac-c3c0-4555-ae52-3c1486f814f0	{"sub": "c52985ac-c3c0-4555-ae52-3c1486f814f0", "email": "testuser@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-06-01 14:37:45.353592+00	2025-06-01 14:37:45.353641+00	2025-06-01 14:37:45.353641+00	86bce3f8-56c7-43a2-8525-24e294f9bc52
e2696184-e809-4108-b08b-ece20065cde3	e2696184-e809-4108-b08b-ece20065cde3	{"sub": "e2696184-e809-4108-b08b-ece20065cde3", "email": "efesecen@hotmail.com", "email_verified": true, "phone_verified": false}	email	2025-06-10 13:38:10.390151+00	2025-06-10 13:38:10.393448+00	2025-06-10 13:38:10.393448+00	ffd22838-ead1-4624-b62d-5fc0d12187a5
bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	{"sub": "bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c", "email": "eren-omur@hotmail.com", "email_verified": true, "phone_verified": false}	email	2025-06-16 13:41:46.532207+00	2025-06-16 13:41:46.532262+00	2025-06-16 13:41:46.532262+00	cc175734-35bc-4dcf-b246-475e77681090
\.


--
-- TOC entry 4013 (class 0 OID 16512)
-- Dependencies: 272
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4023 (class 0 OID 16794)
-- Dependencies: 285
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
94fd430e-5921-46bd-81ad-bbbcae5bcbfc	2025-05-26 12:48:34.639888+00	2025-05-26 12:48:34.639888+00	otp	c81dd736-8f3a-44ee-92fb-f17a4237dea4
04236f6f-4d18-4866-a2fa-6a5d0fbbe196	2025-05-26 12:51:33.424105+00	2025-05-26 12:51:33.424105+00	password	a4c65b01-a1c3-4a3b-96c0-08d704145040
44c1c938-d156-4979-9501-cf7161d8a111	2025-05-26 12:52:03.649472+00	2025-05-26 12:52:03.649472+00	password	4848cd66-4053-470e-9c24-ab8f39e1c0c3
219730dc-e11d-4696-8dd9-8b1d80ca550d	2025-05-29 12:00:52.125824+00	2025-05-29 12:00:52.125824+00	password	268119a3-8214-4179-baba-508d942915a4
7c8f9b7a-ca69-4a84-b657-50be6d1f5d80	2025-05-29 17:03:51.748079+00	2025-05-29 17:03:51.748079+00	password	76cecc8c-4bb9-43bb-a675-173e4d08fa37
78ca5516-3a8c-4620-921c-0ba1ab63960e	2025-05-30 14:26:14.551801+00	2025-05-30 14:26:14.551801+00	otp	451fc60a-672e-4a6f-bd48-82c82a2d533e
e6ddf728-d588-45ce-a6c8-47d42bb5eb7e	2025-05-30 14:26:23.090145+00	2025-05-30 14:26:23.090145+00	password	7c41b263-5be1-444a-8096-44a786fc833a
66bce24e-5f75-4826-a9c1-a4d14a04650a	2025-05-30 14:28:47.786889+00	2025-05-30 14:28:47.786889+00	password	0242f6d3-dbff-4ece-9d91-5e9ff23373bc
36c48278-22e1-47e9-871f-d3d953f11e6b	2025-05-30 15:19:31.643522+00	2025-05-30 15:19:31.643522+00	password	d94a8aae-be7e-4fa5-9023-7e8a420a6442
7dad5c3e-d28b-4142-9a61-213de4248271	2025-05-30 15:24:07.54433+00	2025-05-30 15:24:07.54433+00	password	18d7d614-4323-4384-a355-df567989af8a
b0e25f6b-bc3f-4764-aa0d-a6833e389980	2025-05-30 15:35:22.412071+00	2025-05-30 15:35:22.412071+00	password	4ac44987-c38a-4466-9d42-03dc0e9ba289
227fc40c-ff8f-4bfd-8c89-2611c97df30a	2025-05-30 15:38:25.606933+00	2025-05-30 15:38:25.606933+00	password	3c8b73df-0424-41a1-a6b1-3fafb5a19659
27a2a4b7-37a6-4f52-a07b-e56a3330edb1	2025-06-01 11:44:02.13217+00	2025-06-01 11:44:02.13217+00	password	92d161e2-8828-411a-85d2-51d80d741c1a
84197ea1-f4ca-4bbd-a44b-d3c371304e1c	2025-06-01 11:50:19.979059+00	2025-06-01 11:50:19.979059+00	password	30055261-6c04-4224-90df-7ea6f6108724
4b801d4b-6572-477e-acd6-771ff1286d79	2025-06-01 14:35:07.671172+00	2025-06-01 14:35:07.671172+00	password	ab9b9126-dbe4-473d-ad0c-b031af34f183
e760a07d-bee3-4c26-a9fd-12ec6f5c1497	2025-06-01 14:35:15.66852+00	2025-06-01 14:35:15.66852+00	password	ef394ca8-1829-44a0-93a0-ca37959557e3
01388606-7303-4960-9c33-0e1e53f72d15	2025-06-01 14:35:27.795779+00	2025-06-01 14:35:27.795779+00	password	3846ecaa-89f5-4ab2-a264-a71ee1770e83
3d58f7ff-ad0b-4f78-8317-ec2680c88ac1	2025-06-01 14:39:05.212164+00	2025-06-01 14:39:05.212164+00	password	386a105e-b820-4227-b437-da9d1860bf36
6cc008e9-5ab7-44fb-9dd5-f6b6caffeea8	2025-06-01 14:41:41.974062+00	2025-06-01 14:41:41.974062+00	password	fe0c314c-97e9-4416-93ae-206190367f11
baa4688f-1994-45a9-9512-67611c7fc828	2025-06-01 14:42:01.634176+00	2025-06-01 14:42:01.634176+00	password	4ac007a1-9b0a-4238-9210-bfc78c4428dc
89c43366-6eea-4d6e-92d9-78ebc720854c	2025-06-01 14:42:12.265345+00	2025-06-01 14:42:12.265345+00	password	7197ac67-5808-4111-b368-30bab02b0fae
696864ff-7097-4a6e-af96-6df7710b8c96	2025-06-01 14:42:59.081108+00	2025-06-01 14:42:59.081108+00	password	8a1b0c66-ea2c-4e09-98ca-0e6040e88af5
a4687930-563c-4c1f-b14c-8d15ca0bd868	2025-06-01 14:44:04.972976+00	2025-06-01 14:44:04.972976+00	password	c3c9db55-8ce5-448b-ba04-6d9385a85f11
90266394-6a92-4e5a-b7bd-1fc29b9cbaff	2025-06-01 14:47:52.674069+00	2025-06-01 14:47:52.674069+00	password	20286b35-da20-4d6b-9103-f328abe76646
4518f59f-e9bd-4f8a-b52c-dc590871ce9e	2025-06-01 14:50:03.908736+00	2025-06-01 14:50:03.908736+00	password	62754b8c-82e0-42f3-9499-d2b7f7446aee
d8afcbe2-f4b6-48ad-aea1-7d8438dd651a	2025-06-01 14:59:41.03708+00	2025-06-01 14:59:41.03708+00	password	5d770fc6-463c-496f-bea5-5893192e301c
ba3dde97-82de-481e-860f-dd1c8a14f124	2025-06-01 15:04:40.164703+00	2025-06-01 15:04:40.164703+00	password	aeaa5659-11a4-4b5c-ad53-2f15a1f8622f
fc983bdd-a9d3-4756-bc08-cc7ab7836e63	2025-06-01 15:16:23.309021+00	2025-06-01 15:16:23.309021+00	password	d3b2d173-f7c3-4507-93d4-b0e587fcb022
d5cbee0f-db5e-4987-99b3-6388b6e6955a	2025-06-01 15:34:41.666705+00	2025-06-01 15:34:41.666705+00	password	8f726d22-7f41-4641-9698-7dc519263c12
1aad1538-5b3e-4623-a7b0-ea353eece504	2025-06-01 16:15:07.331298+00	2025-06-01 16:15:07.331298+00	password	b1181fb4-0cde-44a9-97f9-06dccf25dfff
8be73308-9ae3-4259-ad8d-28c474fc2ef1	2025-06-01 16:19:55.62616+00	2025-06-01 16:19:55.62616+00	password	208e9cc0-b727-4d85-94d2-de34b483701b
67ab4420-da4d-406c-b85d-ba4e614e3e6a	2025-06-01 16:20:43.531096+00	2025-06-01 16:20:43.531096+00	password	d0f89b12-c840-4579-aa8e-de0ad0f3a275
34488907-af8a-46c5-9399-491dcb72e981	2025-06-01 16:23:13.507444+00	2025-06-01 16:23:13.507444+00	password	945d2282-f51a-4213-8df1-6533ceca7f09
7aac3bd0-926c-4890-bfe7-811b27c0d353	2025-06-01 16:25:46.309833+00	2025-06-01 16:25:46.309833+00	password	0ca077b3-bb86-49d9-ae37-efb2c5791036
290e65e4-685a-4c3e-a6d4-45639e47e14f	2025-06-01 17:10:25.671977+00	2025-06-01 17:10:25.671977+00	password	25804e4c-e28f-4b7f-9bda-1ba39140df9c
e08294bb-04db-4a43-b4d4-77c1547a99f6	2025-06-01 17:10:43.345683+00	2025-06-01 17:10:43.345683+00	password	bec29929-96b4-493f-91ee-fe03bdc59d55
76f4c616-f5cb-4b45-abb7-bb522c2c3987	2025-06-01 17:12:01.793154+00	2025-06-01 17:12:01.793154+00	password	be3f64de-10bd-46a3-a274-aba933e70899
41a3d84c-ddfb-4b38-a4b5-97f6214417ca	2025-06-01 20:29:20.870243+00	2025-06-01 20:29:20.870243+00	password	123f8f46-70b8-4bda-a422-c0d734e99032
e1e612b4-d5cf-414a-b7b5-02ab125aed2e	2025-06-01 20:36:51.299408+00	2025-06-01 20:36:51.299408+00	password	f1b7a6d8-f566-4823-bb85-9c74f1ffc759
29948e9b-5c56-49c0-9883-e702bc2782b5	2025-06-01 20:40:08.425789+00	2025-06-01 20:40:08.425789+00	password	f5874cbd-b344-44ee-9c70-c3d0e166b4f8
f10c3ac3-827b-4984-a18e-b33746b9e168	2025-06-01 20:45:04.137202+00	2025-06-01 20:45:04.137202+00	password	a5e7927d-b52c-46d8-96f9-a40734ed012c
10d36310-4944-4444-b89d-d1d61025a7b5	2025-06-01 20:49:12.736408+00	2025-06-01 20:49:12.736408+00	password	e6cebe27-12a0-473b-8b82-21b7a8230755
50877aa4-93f1-413d-87d9-236edb3b178d	2025-06-01 21:00:12.349086+00	2025-06-01 21:00:12.349086+00	password	1e489942-b03e-445b-a9a2-8a3bf16b9248
f87814c2-446b-49c3-b405-7b7ca650be2b	2025-06-01 21:06:00.810362+00	2025-06-01 21:06:00.810362+00	password	0639087c-dc5e-4770-a5da-c738adeb0002
ff64626b-926f-4d4d-87fa-075020b0d7a7	2025-06-01 21:10:57.786648+00	2025-06-01 21:10:57.786648+00	password	c9334ab1-194b-47ed-a30c-89ad593a1f7b
1253e712-210d-4d8f-b738-18f7ce5300c0	2025-06-01 21:14:43.001898+00	2025-06-01 21:14:43.001898+00	password	e27bbc6a-bbc2-404e-b207-d500b8833155
b67d7d22-32b8-463b-bf0c-620ba61b5a0b	2025-06-01 21:15:00.468379+00	2025-06-01 21:15:00.468379+00	password	946c759a-e0fb-4b03-a014-017710dd832f
0dd3a5d2-b14a-46e3-8579-a1575265c5cc	2025-06-02 10:22:46.684691+00	2025-06-02 10:22:46.684691+00	password	21829b01-5a97-4c03-a283-aa79c035b4b8
b7783291-fa05-4fe1-bacf-56940bd7c192	2025-06-02 11:10:01.996246+00	2025-06-02 11:10:01.996246+00	password	f3de04eb-294e-4bc9-ac97-13100aaff6fb
85328d21-70d7-4db2-bb09-2884b12b4696	2025-06-02 11:26:03.807037+00	2025-06-02 11:26:03.807037+00	password	84bf14f2-3e99-4d07-a589-56671ae7d3f5
e3b9e3fe-488d-4f03-b49d-9f47c898fb43	2025-06-02 11:44:05.88159+00	2025-06-02 11:44:05.88159+00	password	7a216de3-5c88-43d9-867c-50e55c15285a
d9f64ac8-bd0c-41f4-9ded-b5ca2783de62	2025-06-02 13:20:05.973008+00	2025-06-02 13:20:05.973008+00	password	720a71fb-f9b9-44a9-b741-3d0a3c5011fb
c97fd6e9-460c-4bdf-aa51-3918dbe9bf1b	2025-06-02 13:20:16.920084+00	2025-06-02 13:20:16.920084+00	password	c51dbb55-51a2-4baf-9a2e-2240bf47cde6
e0e64b51-1e4b-49b5-8ccc-2c99ce65a877	2025-06-02 15:21:42.495844+00	2025-06-02 15:21:42.495844+00	password	6003db23-5191-4b30-831d-4596a5623f27
3fbb858b-a44c-4150-86cf-3bcbe90df062	2025-06-02 15:22:56.403818+00	2025-06-02 15:22:56.403818+00	password	52710504-f66b-4a3a-ab35-d98b7cf8875c
d92cec79-40ee-423a-85eb-3965c4f35f32	2025-06-02 15:30:25.105801+00	2025-06-02 15:30:25.105801+00	password	659dc85c-d72f-429e-a389-83661e91fbb9
95a3a6f2-1760-48f9-bbd7-b9a376403451	2025-06-02 15:37:36.348999+00	2025-06-02 15:37:36.348999+00	password	76d1689c-0c16-4da1-9fc6-097f497db6c5
7e9e393d-f945-4901-9631-b95770225d1d	2025-06-02 15:37:45.483972+00	2025-06-02 15:37:45.483972+00	password	66a82252-cb4b-4ddd-b2dd-6fbf36c2e13b
e2613f0b-7b8f-49e1-82fb-2b2d1c6cc12f	2025-06-02 15:42:08.779244+00	2025-06-02 15:42:08.779244+00	password	1d6400f7-4a1f-4a38-9899-f4228aa71e38
d6d08e44-e846-4dc7-a1ed-aa98a64f8c92	2025-06-02 15:47:24.491991+00	2025-06-02 15:47:24.491991+00	password	b7e9323e-cc9d-4082-8952-1ab18f093947
c887c5c6-94c2-4c69-a07a-58311ec8c52b	2025-06-03 09:08:42.975841+00	2025-06-03 09:08:42.975841+00	password	d28b05a0-1741-403f-86bf-83e9faf591cc
9e9a7501-2462-4bbb-96ac-d8a2a6a46b54	2025-06-03 09:57:16.988468+00	2025-06-03 09:57:16.988468+00	password	f30c362b-f700-4b49-91e3-acdaabc97558
01c65b13-7588-4285-af8b-69880e679870	2025-06-03 16:01:48.680472+00	2025-06-03 16:01:48.680472+00	password	ec9cdf66-1865-4190-b98b-7e7b6fbba20b
385ff898-5a32-4ed7-8277-b17f9d99b032	2025-06-03 17:04:09.758793+00	2025-06-03 17:04:09.758793+00	password	2a2d350d-1705-4215-80be-ba44fee0c0f5
81ee472a-a1e5-4008-96d1-acd2308fdb12	2025-06-03 17:15:27.047278+00	2025-06-03 17:15:27.047278+00	password	52acb75c-4ae7-4bae-b50c-71e6da43b1db
fe293b8a-cbc9-4510-90cd-8cf62586808a	2025-06-03 17:44:49.491869+00	2025-06-03 17:44:49.491869+00	password	73bb1996-82c2-4124-bc70-e94b46ef2d3c
2bdcb6c7-d8b8-4ab4-8f82-415361ccdf5a	2025-06-05 09:23:00.106521+00	2025-06-05 09:23:00.106521+00	password	6d9f166d-797e-4c6e-8cfe-67e265efaa21
effb726b-d217-474e-a49d-00a419ad9207	2025-06-05 09:57:36.216811+00	2025-06-05 09:57:36.216811+00	password	d0b6b9dc-62df-44ed-be47-2952747f5246
bdbf7dc4-5910-4a3b-8af8-f36a5e5243a0	2025-06-09 12:01:13.578506+00	2025-06-09 12:01:13.578506+00	password	25157fc1-6818-4613-946a-35ad960060fb
c01220eb-2743-49b3-b740-c5d28c912006	2025-06-10 13:29:25.505837+00	2025-06-10 13:29:25.505837+00	password	3b277be7-3846-459f-b1ed-920726f8ba3b
17734dfe-c921-4486-aca9-8510576a165e	2025-06-10 13:40:10.127536+00	2025-06-10 13:40:10.127536+00	otp	d3ebdd70-1c2d-4eab-907c-aa4bdd761c5d
f0250f26-3cd2-4b26-8684-10fde6995742	2025-06-10 13:40:18.790667+00	2025-06-10 13:40:18.790667+00	password	b6d6d752-61d3-4b09-9823-cf12e05bf403
935d349b-c7aa-4567-8741-796be4a0ca66	2025-06-10 13:41:19.076905+00	2025-06-10 13:41:19.076905+00	password	e0ff9555-0b3b-464e-93cb-ed25aa90683a
b49de846-9433-4c1a-82ca-0150975bc794	2025-06-10 13:58:14.074851+00	2025-06-10 13:58:14.074851+00	password	d21f866d-9526-4221-9c1d-212771ec3bf3
d1713cd0-1f38-4bb4-a5ce-c4efd702e8f1	2025-06-10 14:05:08.462367+00	2025-06-10 14:05:08.462367+00	password	09eab108-e60a-4bd8-b01a-5ec6781b343a
cb669d12-a79e-402f-b215-866307389ccc	2025-06-10 14:11:36.304166+00	2025-06-10 14:11:36.304166+00	password	25c9b131-1f86-4766-9b9f-435ea2f2d5eb
c45a27ae-27af-43e6-a09e-2404dbb6a650	2025-06-10 14:16:27.845706+00	2025-06-10 14:16:27.845706+00	password	7cc9e719-34ee-453d-b820-d91809597480
2ae251f8-dbcd-42bc-aa67-1204a284ce3e	2025-06-10 14:25:00.714676+00	2025-06-10 14:25:00.714676+00	password	a8f7c7a9-4a88-48f2-99b5-288a38cbb530
812aae94-1821-46a3-a8bb-78ea02c90f4a	2025-06-10 14:29:02.270027+00	2025-06-10 14:29:02.270027+00	password	4ecddf27-f00e-4aed-8e10-253c1861e72c
cb9d95c5-c2a7-42d9-abd3-e4da631a957b	2025-06-10 14:29:14.677753+00	2025-06-10 14:29:14.677753+00	password	0664ff49-13ac-4dcd-b433-b241db1dc173
a7e1a434-fc4a-4d00-8d6c-01b0a04282ce	2025-06-10 14:44:21.03581+00	2025-06-10 14:44:21.03581+00	password	b2dae41b-f2cf-4614-8763-e4fd9dfd3696
1c10072a-a28b-4f3d-b1ea-d7575d2cb5d3	2025-06-10 14:45:50.711533+00	2025-06-10 14:45:50.711533+00	password	d39e4d55-ac3d-4430-ae2a-c345e5c088d2
224d0aad-78df-48d9-ad1f-eb05fa43d1c8	2025-06-10 16:12:53.980954+00	2025-06-10 16:12:53.980954+00	password	7f3af15e-9dd9-40c9-ab77-4b789640364d
a9959d9d-4918-48d0-8189-e087c821c169	2025-06-13 17:23:21.564025+00	2025-06-13 17:23:21.564025+00	password	250c652a-7f13-40f1-9001-9cb507ce59b5
72662a99-1f9c-4c20-a223-c5a8577bdc4c	2025-06-13 17:23:28.988293+00	2025-06-13 17:23:28.988293+00	password	acd74c86-45f2-44c6-9c49-808dce3ef82f
f452ee0f-c15f-4693-9b9e-2fbc5fd35004	2025-06-13 17:23:30.501477+00	2025-06-13 17:23:30.501477+00	password	0510f081-c1b2-48b8-8ff5-9838d2f4590e
ccee215e-2d0b-44aa-9e24-82f02fb08438	2025-06-13 17:37:40.403803+00	2025-06-13 17:37:40.403803+00	password	0ca59371-57bc-4463-a961-f181ec4bafb3
5ece34d0-9c45-4acd-911f-b2619ff59e8d	2025-06-13 17:39:10.405342+00	2025-06-13 17:39:10.405342+00	password	bc9a7586-a9b6-410c-a225-0e43d1a680dd
cc3dd629-cb27-48d0-91dd-22b09bda0081	2025-06-13 17:47:01.868723+00	2025-06-13 17:47:01.868723+00	password	7fa6cd65-56fc-4c3f-a712-75779dedf327
bdb214a4-d628-4877-b657-2fb1e359b85e	2025-06-13 17:47:06.555198+00	2025-06-13 17:47:06.555198+00	password	f2a542c1-4d7b-46d4-b33a-f39053f04bf3
8551e867-aabf-4b46-8cab-1ff841f3871a	2025-06-13 17:47:30.115636+00	2025-06-13 17:47:30.115636+00	password	65701423-0e51-4767-87d2-fa71f8d9a128
43775378-ae9c-40eb-931e-28f35d00bb13	2025-06-13 17:47:40.77749+00	2025-06-13 17:47:40.77749+00	password	87ffa6d7-c6ff-41dc-ab1e-787ccdc722a8
57c205d1-5ffa-4019-a426-215ab12da703	2025-06-13 17:48:54.550191+00	2025-06-13 17:48:54.550191+00	password	8c0d352b-1ce5-4ff8-84bf-e79b39c7bb78
3a374dcb-e37e-4101-bb4e-256afe70e363	2025-06-13 17:50:59.248718+00	2025-06-13 17:50:59.248718+00	password	67eb26ea-ef19-490f-b549-ec6c3b309f3d
b0f84562-a15d-4ebb-befb-ce83a21e1434	2025-06-13 17:51:50.129327+00	2025-06-13 17:51:50.129327+00	password	3cefdf15-7759-44e2-bb30-a0b6a7ee6f8f
87d897f9-f174-4261-af5c-ad175a20565c	2025-06-13 17:52:02.725141+00	2025-06-13 17:52:02.725141+00	password	27b574c8-2bd2-48b2-94f4-0f20f0ff903c
e152e237-e555-47ff-a393-3464a31ce3bb	2025-06-13 17:53:27.012452+00	2025-06-13 17:53:27.012452+00	password	d7f46a27-dae0-4f3a-947d-4a39aa74e771
8f0c6575-4705-43d7-87be-e3398ec01ef7	2025-06-13 17:55:36.211256+00	2025-06-13 17:55:36.211256+00	password	4f6f48fe-6fe8-44aa-9ae4-86b59327adbd
ef2801d2-85ad-4506-9bf0-e231ca8c4023	2025-06-13 17:57:04.489825+00	2025-06-13 17:57:04.489825+00	password	039eded0-fdc1-4301-a1d2-d6b2c8ea7925
afe8f4da-faa4-492e-ba53-0ae415103724	2025-06-13 17:57:15.254948+00	2025-06-13 17:57:15.254948+00	password	350a4b56-491d-4d8a-9122-053ebde508d7
57a5ea36-69ab-486b-bf85-e504fd2f11a6	2025-06-13 17:57:19.018021+00	2025-06-13 17:57:19.018021+00	password	792c71da-cb97-4129-aacb-6f5a2e38729f
d43f6e2c-a583-4bdf-82d6-4747837b6e1a	2025-06-13 17:57:29.575328+00	2025-06-13 17:57:29.575328+00	password	439c20cb-dee7-4fb9-8327-36f1bd14bed8
32ada9ff-4c9d-4b1c-a29b-bec1619d6c33	2025-06-13 18:06:06.406206+00	2025-06-13 18:06:06.406206+00	password	065e668e-344e-4260-b3e0-1a18380bb790
f8e42108-b9a9-4bc6-8584-afa802058543	2025-06-13 18:08:51.099387+00	2025-06-13 18:08:51.099387+00	password	4f344ce5-ac00-4db7-a582-5099498b38f6
f1380e23-e836-46ef-9d0a-b226f735f2a9	2025-06-13 18:08:56.515579+00	2025-06-13 18:08:56.515579+00	password	1e349ce8-3c27-4661-a1c0-cb4ba92d9448
4dd94fab-7bd2-43b1-abf4-2476c9de00ca	2025-06-13 18:12:32.473484+00	2025-06-13 18:12:32.473484+00	password	18a84867-e958-4e4a-82be-e370e8c8f69e
3936b9cd-5d14-4f53-a469-9a17112ceb8b	2025-06-13 18:12:37.577951+00	2025-06-13 18:12:37.577951+00	password	590b925c-e985-4037-a212-f37e4374de1c
5aa15941-bca2-4f9f-a766-e6e135ceae65	2025-06-13 18:16:10.741031+00	2025-06-13 18:16:10.741031+00	password	e64cff98-390c-4227-8156-b73cae1ff075
395af682-fc4a-47b2-90ae-e6a78978c700	2025-06-13 18:16:29.552246+00	2025-06-13 18:16:29.552246+00	password	071c5034-e55c-4c46-a2f4-21857711e5ac
b52e369a-1b2d-4781-8e10-0cb2e0771039	2025-06-13 18:17:58.885567+00	2025-06-13 18:17:58.885567+00	password	cbcffe36-1460-4ae9-9e6e-712fdbcbaec1
7e782e1e-2b92-44bc-8542-1e723affb206	2025-06-13 18:18:13.758079+00	2025-06-13 18:18:13.758079+00	password	c2b1bd5a-cbd4-4ffe-bb0a-50e534069043
40655390-2af8-410c-a41c-50dc154487f2	2025-06-13 18:20:33.29543+00	2025-06-13 18:20:33.29543+00	password	29c58b18-23de-4a8b-9800-4111fa9c46dc
832e1267-8689-43fb-8707-31a85a4ec0ee	2025-06-13 18:20:43.602672+00	2025-06-13 18:20:43.602672+00	password	cef45c0b-92cb-44f4-97d2-d5ecc02ebca7
e3de2713-a908-4f1c-9e85-58da53281b41	2025-06-13 18:22:55.152489+00	2025-06-13 18:22:55.152489+00	password	79605305-01a0-4af4-8210-6636b2ad18d3
c16b4cea-147e-4ccc-aa8d-2f0474d16811	2025-06-13 18:23:06.837443+00	2025-06-13 18:23:06.837443+00	password	a965a7ca-f8bb-4995-b2b3-3ee26a8e3bc8
c59bad02-323e-4810-97bb-2afe732b698f	2025-06-13 18:24:19.974808+00	2025-06-13 18:24:19.974808+00	password	66ca13fe-88f8-439e-a82c-c6e4e86e4b1f
baba198b-f2be-43f8-98f4-d09bba604c20	2025-06-13 18:24:32.503466+00	2025-06-13 18:24:32.503466+00	password	7959c804-ea3e-4fea-8c18-625f8c2e347a
69df712f-b1ef-45b4-bc09-71825e8b9e75	2025-06-13 18:25:51.200434+00	2025-06-13 18:25:51.200434+00	password	3fe3f0dc-ae0e-4648-bfd2-9d4761806a41
fc3a81d0-9926-4cf6-b342-31f2f16e604e	2025-06-13 18:34:42.620072+00	2025-06-13 18:34:42.620072+00	password	3a4a082a-ac02-444c-ac8c-092aea41153d
9a62d7ac-70cb-44ac-8b28-f64230d1994b	2025-06-13 18:36:07.036748+00	2025-06-13 18:36:07.036748+00	password	02ab58a6-2346-4cc4-be97-3e624463e26a
b60b6b86-1243-4e5c-b1e5-e79f3c40e4a3	2025-06-13 18:38:56.095275+00	2025-06-13 18:38:56.095275+00	password	ce460446-c3f3-4eb2-af66-ce545dacd0f7
85340914-2c4e-4fca-821d-4ef310073811	2025-06-13 18:39:23.048367+00	2025-06-13 18:39:23.048367+00	password	e1d410eb-78ab-4a70-8225-7549eef57bf5
26435738-4945-498e-b402-323de3f4d1d1	2025-06-13 18:41:27.250069+00	2025-06-13 18:41:27.250069+00	password	03650426-1b80-40bf-a2bb-607d9b64c02a
574fa09f-8daf-47fe-bb65-7c8bceff0b67	2025-06-13 18:41:37.971466+00	2025-06-13 18:41:37.971466+00	password	296a5869-c971-4dc4-9161-1b82f6a55d95
a42432b2-200f-4115-b021-060281ca4b8f	2025-06-13 18:43:40.44245+00	2025-06-13 18:43:40.44245+00	password	f2e83981-a0e5-4a2f-bb7d-217ebafcc2a3
0f9919d1-2cb0-41db-8cd7-014810751b22	2025-06-13 18:43:49.315734+00	2025-06-13 18:43:49.315734+00	password	29130a06-83a1-4941-b31c-d7343b17eead
21e426cb-13bc-401a-86c1-514bc43deb8b	2025-06-13 18:43:54.241252+00	2025-06-13 18:43:54.241252+00	password	1d2abeb1-8f0c-4ee5-ae39-4eb1fa07cc87
4d0abd7a-521c-4d28-8ec2-eda65edc43f3	2025-06-13 18:44:07.51241+00	2025-06-13 18:44:07.51241+00	password	1e254aa0-2525-49df-97c9-385c6984fed0
94c2dda4-b0be-463d-b188-38566b891ea7	2025-06-13 18:45:31.5741+00	2025-06-13 18:45:31.5741+00	password	11080e46-3ad1-494c-b5c0-afce6bbbd879
66e2bbca-68bc-4f30-83f9-f6056829cf50	2025-06-13 18:45:36.729712+00	2025-06-13 18:45:36.729712+00	password	64d64ee0-29bd-4c8a-9e4b-4bca522a97e9
7d34f1d3-85ab-4131-b3e2-df88ec066bd9	2025-06-13 18:46:54.213271+00	2025-06-13 18:46:54.213271+00	password	a7d7aaf3-4efe-44c0-9fa9-8d4acb9f1763
55fafd0e-2833-43fc-b291-55a18752773b	2025-06-13 18:49:17.984107+00	2025-06-13 18:49:17.984107+00	password	065302da-7cc7-4d26-9c56-a0745858cb81
f9cc77dd-f687-4d47-b4e3-1905edb05748	2025-06-13 18:49:24.331321+00	2025-06-13 18:49:24.331321+00	password	2cb5229f-c900-41d1-b95d-73927a02680b
0ac9421c-06f2-4a0c-b953-440c79f17a3a	2025-06-13 18:50:37.816398+00	2025-06-13 18:50:37.816398+00	password	3a75d745-26c9-4eca-b844-7b9f1d63b49f
d974988f-6f87-448a-957c-5b9fb870e97d	2025-06-13 19:28:26.957435+00	2025-06-13 19:28:26.957435+00	password	b9312f0f-9a68-4621-babc-fd58342ad932
768be3f0-ac83-479d-9217-5af29f4bae16	2025-06-13 19:31:19.484871+00	2025-06-13 19:31:19.484871+00	password	5a434099-dd48-4cb1-b10c-c038343043d6
a3d4999d-5849-4b40-b671-109cabe28f3c	2025-06-13 19:31:26.315777+00	2025-06-13 19:31:26.315777+00	password	c6a47ae6-6854-4165-bc46-81656c91fe2c
d05ededb-b83c-4be7-93aa-c08b42f2d3ed	2025-06-13 19:33:29.525934+00	2025-06-13 19:33:29.525934+00	password	9335c556-7a20-4be8-91cc-454c54f8455b
b305c3e7-b76f-4278-9bba-c732a4e4425b	2025-06-13 19:34:15.207086+00	2025-06-13 19:34:15.207086+00	password	2b49d7cb-f57a-43e8-8c11-950e6aeb6e0a
3ffda28e-fb0c-4e5c-b340-2bb31485f90c	2025-06-13 20:33:03.559262+00	2025-06-13 20:33:03.559262+00	password	ed9cbb56-8435-434a-b269-224bf8961576
ce4f9220-6ddd-40e4-adaa-e6ff6456380c	2025-06-13 20:33:10.33551+00	2025-06-13 20:33:10.33551+00	password	6afb7ab1-2684-49b4-943d-080b559a427e
12d1ebdc-a6e9-4f76-b812-e105bc7dbfd7	2025-06-13 20:36:37.806903+00	2025-06-13 20:36:37.806903+00	password	df17ffa3-4bec-493c-ad37-e77ec11d65de
1b4eda20-9717-42a6-88da-76a7260942a9	2025-06-13 20:40:59.258488+00	2025-06-13 20:40:59.258488+00	password	616dda12-49bf-45d4-a4bb-8480473ecf98
96e80344-f4d7-410f-aebf-8f430f04ec36	2025-06-13 20:47:18.867896+00	2025-06-13 20:47:18.867896+00	password	d92f042c-8244-43e2-82dc-d202d3f670fe
d1079952-4303-4c11-af0d-4e418e7bb6b7	2025-06-13 20:49:53.570235+00	2025-06-13 20:49:53.570235+00	password	86ed38eb-c5eb-4987-ba84-04673e2b6e26
9ab90fb8-f005-4e3b-933c-aa8c38eb943a	2025-06-13 20:50:57.483246+00	2025-06-13 20:50:57.483246+00	password	42ee38ba-3d23-4483-9bbb-1ac920ba4e29
61956de8-ee8c-4857-985c-ed7c5c2e966e	2025-06-13 20:58:53.767222+00	2025-06-13 20:58:53.767222+00	password	7a270d1e-5351-4595-8e22-ee894a308a1b
ce3342cb-166b-40a9-90b1-b104fe3f1216	2025-06-13 21:14:03.573998+00	2025-06-13 21:14:03.573998+00	password	e2fbb375-fcdf-4d4b-9ef1-d84bf93e1bf2
6aa8fe10-742a-45c7-b222-716c5790e41e	2025-06-13 21:18:37.901549+00	2025-06-13 21:18:37.901549+00	password	4405f8ce-2e8b-4792-a644-f87584906369
4b0e7106-e059-4402-be60-f5c9c7e2dff1	2025-06-13 21:24:11.965976+00	2025-06-13 21:24:11.965976+00	password	2afa2d53-e349-4422-8c89-45cd1cb62a04
3c230eff-8f4b-4e22-9bdc-7deacd8ea466	2025-06-13 21:37:11.977165+00	2025-06-13 21:37:11.977165+00	password	d915c802-1a2e-458f-bbec-097e3cbeb501
aa634547-abc6-46ce-8ef2-d776bc654fd7	2025-06-13 21:37:12.33491+00	2025-06-13 21:37:12.33491+00	password	af62ec7f-c4e4-420b-9e4e-116d501ddfa8
512fda62-f162-4093-95a1-e4aaecb4c50f	2025-06-13 21:54:27.617595+00	2025-06-13 21:54:27.617595+00	password	88b53e31-b8b2-4fb3-8a17-0d121a3318ac
d82d7328-233e-4675-8386-3b916c7efa37	2025-06-13 21:56:16.725554+00	2025-06-13 21:56:16.725554+00	password	5caa2512-fdb9-4405-9579-273973df85ae
df92cea2-78cd-4c3e-bed1-7c9df8c9d7be	2025-06-14 13:36:06.027698+00	2025-06-14 13:36:06.027698+00	password	7e35c426-6346-419c-b8cf-dc0abd34ece4
cffd461e-102b-4947-a530-3d553926417f	2025-06-14 13:36:44.726797+00	2025-06-14 13:36:44.726797+00	password	3183ed45-a071-40ee-8393-a30167281fff
35fd2080-7138-4430-9300-dd7b3e0e1952	2025-06-14 13:36:59.633002+00	2025-06-14 13:36:59.633002+00	password	64a358ce-33f0-4d22-93b0-9787844a9e95
bb1a1585-803c-4e12-8e06-82097ce3b19f	2025-06-14 13:37:46.874378+00	2025-06-14 13:37:46.874378+00	password	f51c074f-0cca-440b-9722-202af9db5442
0e7e9fee-7bed-4fc1-8f8c-000c1ef997f9	2025-06-14 13:51:35.539496+00	2025-06-14 13:51:35.539496+00	password	5e37ca33-4204-4d8a-96e6-16eec70d0bf9
b82955c4-4a7c-4746-9918-3c37bcbb42d1	2025-06-14 13:53:36.335693+00	2025-06-14 13:53:36.335693+00	password	6ba51ee0-3adc-4629-b0cc-6875b1815b27
0da91356-03ab-4b4d-a5f7-c72c32e35012	2025-06-16 13:31:48.838201+00	2025-06-16 13:31:48.838201+00	password	30513b75-dd1d-495f-9386-9e5d75d0b5b2
e90c0908-78be-4eb6-8dda-10bac673f8b7	2025-06-16 13:33:50.833409+00	2025-06-16 13:33:50.833409+00	password	79dc43e7-a498-472d-abc1-7b630a4b9e87
ea1f7f48-8983-4071-bac2-61fc13015ad4	2025-06-16 13:44:41.907864+00	2025-06-16 13:44:41.907864+00	otp	d5e50904-9980-4aad-ad57-d59ff71356c2
d08d3d75-3785-499a-838a-81a2c0f7f0bc	2025-06-16 13:45:42.323609+00	2025-06-16 13:45:42.323609+00	password	538302f1-88cc-4c7f-a43d-578a7ba6786a
f8dca749-bc5f-40b7-ace8-daa72dd301cc	2025-06-16 13:45:52.963894+00	2025-06-16 13:45:52.963894+00	password	1cb970e1-19d6-4b53-88bb-b88a4a225420
27e14048-4194-41b1-b78c-65ada6d55ff1	2025-06-16 13:46:19.891152+00	2025-06-16 13:46:19.891152+00	password	7e4da7d9-8fbd-4230-950c-235014be0658
f19d4fb4-ecbe-4fa9-a681-6ead8c59f993	2025-06-16 15:22:40.047683+00	2025-06-16 15:22:40.047683+00	otp	055723e7-477b-4618-8b6d-b4d51723a634
7795aed5-1e5a-441c-9d81-fe6638178517	2025-06-16 15:23:23.276322+00	2025-06-16 15:23:23.276322+00	password	46848ac1-45c0-4d69-a6ab-46106cdfd733
a1213af3-d174-4bb2-af90-f0c4f112628a	2025-06-16 15:25:13.439681+00	2025-06-16 15:25:13.439681+00	password	2ab9d93f-0146-462a-93c2-204116bb097a
c6f65703-1237-4510-adfb-f3506a31a35e	2025-06-17 13:35:22.311786+00	2025-06-17 13:35:22.311786+00	password	9a7c8911-b1ff-409f-a0e2-8f1ab377c0ab
bb7c5d5d-c035-4310-ac9a-3a97586c34a5	2025-06-17 13:35:50.413565+00	2025-06-17 13:35:50.413565+00	password	1f4ce6e3-5ec0-4805-a9fe-e10a32a4802f
87039e32-7e21-40a5-b330-4cf1998f37fa	2025-06-17 15:02:05.383797+00	2025-06-17 15:02:05.383797+00	password	a6117a25-f974-4986-96cf-b0b8549ad8ec
d51e22c1-8633-41b2-8417-1604eb4d1b76	2025-06-17 15:02:12.691877+00	2025-06-17 15:02:12.691877+00	password	4ac28abb-7f1a-41b4-a093-6a8216449616
a2137bc3-3e4c-4183-9ad5-aafc5927c275	2025-06-17 15:02:22.24228+00	2025-06-17 15:02:22.24228+00	password	e8d4373a-b5b9-42f7-b1fe-213b3b65fd92
9568fdb6-9de5-4bea-aff7-39cfd275a827	2025-06-17 15:18:17.116403+00	2025-06-17 15:18:17.116403+00	password	fd5ac448-94e6-4609-9bd4-d32f75d6d259
cfc77c50-7648-4bfe-acc0-5699a03415ff	2025-06-17 15:19:04.308456+00	2025-06-17 15:19:04.308456+00	password	6ddf39fa-15ec-42db-aba5-f3523ceedbc8
059ee39f-ec24-40b8-9c72-722b449d8e08	2025-06-17 15:24:02.909727+00	2025-06-17 15:24:02.909727+00	password	b54a0fa4-b6ab-48f8-bc96-d12377d657a7
5a43643b-887b-4cca-8e14-259dddb62f7d	2025-06-17 15:25:49.955371+00	2025-06-17 15:25:49.955371+00	password	978658b1-65c0-4187-a3b2-5614587a7318
da099d3e-bfb8-4577-a728-f60a462665c9	2025-06-17 15:26:04.43546+00	2025-06-17 15:26:04.43546+00	password	f8796088-e7d2-467e-9952-a294b9bd7893
e8b98818-9c9c-4836-a547-d6931c71b1f8	2025-06-17 15:26:09.910808+00	2025-06-17 15:26:09.910808+00	password	27ae4658-d2b7-4d04-948b-bc4b94881062
5d52b593-e4e1-4a1d-8434-371df3bf1119	2025-06-17 15:30:26.552996+00	2025-06-17 15:30:26.552996+00	password	a3b4a779-297a-4458-a7c9-1a5138371cfc
0dceef46-9d54-4672-b8ea-31e7d6846fff	2025-06-17 15:30:37.157911+00	2025-06-17 15:30:37.157911+00	password	8466d48b-3a71-4fea-9543-2cb39fb60e08
e48814df-b82d-4f85-9e10-d7225821629e	2025-06-17 17:36:10.751269+00	2025-06-17 17:36:10.751269+00	password	7cc2d6f4-295f-4c37-b783-cc3de69b3d70
c9fe46df-ce27-40a1-bb34-039ce0630e57	2025-06-17 17:37:35.307572+00	2025-06-17 17:37:35.307572+00	password	7439f4e0-711b-470d-b259-57d7abca978d
3fbd17e1-2c70-4f32-a691-bc196948e3c7	2025-06-19 11:52:38.161582+00	2025-06-19 11:52:38.161582+00	password	74d52bcb-2b5a-4a92-9660-1fc3f016e0cb
67634db9-803e-4805-8dd4-e96277e8c9cd	2025-06-19 11:52:46.507652+00	2025-06-19 11:52:46.507652+00	password	0e3cb3b3-34e6-4b3a-83eb-519844cae10c
2e27d7c8-dcf3-4ee7-8d44-7cd0b710c65a	2025-06-19 11:54:56.305252+00	2025-06-19 11:54:56.305252+00	password	4ceb598a-dd87-4e01-9704-fc0101286253
e14fa4e0-e176-4eff-8b5d-66b6b0f4b361	2025-06-19 12:00:17.007823+00	2025-06-19 12:00:17.007823+00	password	24786712-ac85-4184-9aa3-cde2bd23edec
9dce2de9-4d71-4c6d-881c-1ea3debd6bfa	2025-06-19 12:01:05.007606+00	2025-06-19 12:01:05.007606+00	password	72e12f7d-f51c-4fb1-a6b0-63ff578ae86c
ba3b4bdd-fd32-425b-969c-538a40577d7d	2025-06-19 12:03:46.490868+00	2025-06-19 12:03:46.490868+00	password	621df41e-842f-4c55-9c23-8f0779f61362
da1ed432-a569-4cf5-9800-73348f59e446	2025-06-19 12:04:56.314021+00	2025-06-19 12:04:56.314021+00	password	a7d90edb-f875-4f33-a97f-8cfda14ee21c
82020d94-74fd-4919-9d58-9d6ee7e718f7	2025-06-19 12:06:51.779527+00	2025-06-19 12:06:51.779527+00	password	03fe8022-42f8-466e-aeba-96fddfd2ed51
\.


--
-- TOC entry 4022 (class 0 OID 16782)
-- Dependencies: 284
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- TOC entry 4021 (class 0 OID 16769)
-- Dependencies: 283
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- TOC entry 4029 (class 0 OID 16957)
-- Dependencies: 291
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
7864537a-993a-4c44-82af-8d371cb2d1a1	c52985ac-c3c0-4555-ae52-3c1486f814f0	confirmation_token	098be004d745fb731d8c71b61b4706a7ef35d4d9f501bfd7b838a06c	testuser@gmail.com	2025-06-01 14:37:46.177847	2025-06-01 14:37:46.177847
\.


--
-- TOC entry 4012 (class 0 OID 16501)
-- Dependencies: 271
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	11	drmpbutskrnf	a25826c2-495d-4234-8e20-97d97f4db18e	f	2025-05-26 12:48:34.63205+00	2025-05-26 12:48:34.63205+00	\N	94fd430e-5921-46bd-81ad-bbbcae5bcbfc
00000000-0000-0000-0000-000000000000	12	ajjjy6h3s3ws	a25826c2-495d-4234-8e20-97d97f4db18e	f	2025-05-26 12:51:33.421904+00	2025-05-26 12:51:33.421904+00	\N	04236f6f-4d18-4866-a2fa-6a5d0fbbe196
00000000-0000-0000-0000-000000000000	13	fuucqs3lcujk	a25826c2-495d-4234-8e20-97d97f4db18e	f	2025-05-26 12:52:03.647248+00	2025-05-26 12:52:03.647248+00	\N	44c1c938-d156-4979-9501-cf7161d8a111
00000000-0000-0000-0000-000000000000	27	qx7ktyxtn5xo	a25826c2-495d-4234-8e20-97d97f4db18e	t	2025-05-29 12:00:52.122007+00	2025-05-29 16:54:43.920579+00	\N	219730dc-e11d-4696-8dd9-8b1d80ca550d
00000000-0000-0000-0000-000000000000	28	yoodeg6rfdls	a25826c2-495d-4234-8e20-97d97f4db18e	f	2025-05-29 16:54:43.925423+00	2025-05-29 16:54:43.925423+00	qx7ktyxtn5xo	219730dc-e11d-4696-8dd9-8b1d80ca550d
00000000-0000-0000-0000-000000000000	29	roxpwrj2uusf	a25826c2-495d-4234-8e20-97d97f4db18e	t	2025-05-29 17:03:51.741871+00	2025-05-29 19:09:07.59597+00	\N	7c8f9b7a-ca69-4a84-b657-50be6d1f5d80
00000000-0000-0000-0000-000000000000	30	pm5q4pclje62	a25826c2-495d-4234-8e20-97d97f4db18e	t	2025-05-29 19:09:07.600748+00	2025-05-29 20:07:38.870891+00	roxpwrj2uusf	7c8f9b7a-ca69-4a84-b657-50be6d1f5d80
00000000-0000-0000-0000-000000000000	31	2linaohi5ken	a25826c2-495d-4234-8e20-97d97f4db18e	t	2025-05-29 20:07:38.873765+00	2025-05-30 12:34:00.350702+00	pm5q4pclje62	7c8f9b7a-ca69-4a84-b657-50be6d1f5d80
00000000-0000-0000-0000-000000000000	32	yafa7m5qxsgj	a25826c2-495d-4234-8e20-97d97f4db18e	t	2025-05-30 12:34:00.369603+00	2025-05-30 13:32:36.598172+00	2linaohi5ken	7c8f9b7a-ca69-4a84-b657-50be6d1f5d80
00000000-0000-0000-0000-000000000000	33	jlyqk76wpuay	a25826c2-495d-4234-8e20-97d97f4db18e	f	2025-05-30 13:32:36.600849+00	2025-05-30 13:32:36.600849+00	yafa7m5qxsgj	7c8f9b7a-ca69-4a84-b657-50be6d1f5d80
00000000-0000-0000-0000-000000000000	34	dwkudtqrrvdp	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-05-30 14:26:14.547743+00	2025-05-30 14:26:14.547743+00	\N	78ca5516-3a8c-4620-921c-0ba1ab63960e
00000000-0000-0000-0000-000000000000	35	fuquzzjhe7wo	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-05-30 14:26:23.088976+00	2025-05-30 14:26:23.088976+00	\N	e6ddf728-d588-45ce-a6c8-47d42bb5eb7e
00000000-0000-0000-0000-000000000000	36	blilicicoss7	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-05-30 14:28:47.782769+00	2025-05-30 14:28:47.782769+00	\N	66bce24e-5f75-4826-a9c1-a4d14a04650a
00000000-0000-0000-0000-000000000000	37	l7qwsbn5twku	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-05-30 15:19:31.634564+00	2025-05-30 15:19:31.634564+00	\N	36c48278-22e1-47e9-871f-d3d953f11e6b
00000000-0000-0000-0000-000000000000	38	2wwsxlh5ixvl	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-05-30 15:24:07.53945+00	2025-05-30 15:24:07.53945+00	\N	7dad5c3e-d28b-4142-9a61-213de4248271
00000000-0000-0000-0000-000000000000	42	66f4q2k33eka	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-05-30 15:35:22.410845+00	2025-05-30 15:35:22.410845+00	\N	b0e25f6b-bc3f-4764-aa0d-a6833e389980
00000000-0000-0000-0000-000000000000	46	vnjlpnqic2kl	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-05-30 15:38:25.604201+00	2025-05-30 15:38:25.604201+00	\N	227fc40c-ff8f-4bfd-8c89-2611c97df30a
00000000-0000-0000-0000-000000000000	51	smcg6o5hizj4	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 11:44:02.096834+00	2025-06-01 11:44:02.096834+00	\N	27a2a4b7-37a6-4f52-a07b-e56a3330edb1
00000000-0000-0000-0000-000000000000	52	wd44v4kcxmiw	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 11:50:19.971187+00	2025-06-01 11:50:19.971187+00	\N	84197ea1-f4ca-4bbd-a44b-d3c371304e1c
00000000-0000-0000-0000-000000000000	53	477nav6oeenm	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:35:07.649143+00	2025-06-01 14:35:07.649143+00	\N	4b801d4b-6572-477e-acd6-771ff1286d79
00000000-0000-0000-0000-000000000000	54	vldf73u3ot6r	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:35:15.659003+00	2025-06-01 14:35:15.659003+00	\N	e760a07d-bee3-4c26-a9fd-12ec6f5c1497
00000000-0000-0000-0000-000000000000	55	matmrajx633h	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:35:27.79337+00	2025-06-01 14:35:27.79337+00	\N	01388606-7303-4960-9c33-0e1e53f72d15
00000000-0000-0000-0000-000000000000	56	hn5l2mkua67v	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:39:05.208032+00	2025-06-01 14:39:05.208032+00	\N	3d58f7ff-ad0b-4f78-8317-ec2680c88ac1
00000000-0000-0000-0000-000000000000	57	5xfsdp25mrzx	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:41:41.968843+00	2025-06-01 14:41:41.968843+00	\N	6cc008e9-5ab7-44fb-9dd5-f6b6caffeea8
00000000-0000-0000-0000-000000000000	58	c4o4mbs6keui	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:42:01.632923+00	2025-06-01 14:42:01.632923+00	\N	baa4688f-1994-45a9-9512-67611c7fc828
00000000-0000-0000-0000-000000000000	59	ghqlgoj4xi2k	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:42:12.26416+00	2025-06-01 14:42:12.26416+00	\N	89c43366-6eea-4d6e-92d9-78ebc720854c
00000000-0000-0000-0000-000000000000	60	pvzku6enyjtk	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:42:59.079907+00	2025-06-01 14:42:59.079907+00	\N	696864ff-7097-4a6e-af96-6df7710b8c96
00000000-0000-0000-0000-000000000000	61	rubo7dw3cqbz	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:44:04.971075+00	2025-06-01 14:44:04.971075+00	\N	a4687930-563c-4c1f-b14c-8d15ca0bd868
00000000-0000-0000-0000-000000000000	62	2iay32526swt	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:47:52.66782+00	2025-06-01 14:47:52.66782+00	\N	90266394-6a92-4e5a-b7bd-1fc29b9cbaff
00000000-0000-0000-0000-000000000000	63	24umnejfqu5l	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:50:03.905426+00	2025-06-01 14:50:03.905426+00	\N	4518f59f-e9bd-4f8a-b52c-dc590871ce9e
00000000-0000-0000-0000-000000000000	64	khq73gxpd4t3	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 14:59:41.033652+00	2025-06-01 14:59:41.033652+00	\N	d8afcbe2-f4b6-48ad-aea1-7d8438dd651a
00000000-0000-0000-0000-000000000000	65	gvsq6ot657xe	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 15:04:40.16124+00	2025-06-01 15:04:40.16124+00	\N	ba3dde97-82de-481e-860f-dd1c8a14f124
00000000-0000-0000-0000-000000000000	66	3goxdqlgg63a	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 15:16:23.304402+00	2025-06-01 15:16:23.304402+00	\N	fc983bdd-a9d3-4756-bc08-cc7ab7836e63
00000000-0000-0000-0000-000000000000	67	g2pn76a4spoq	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 15:34:41.662113+00	2025-06-01 15:34:41.662113+00	\N	d5cbee0f-db5e-4987-99b3-6388b6e6955a
00000000-0000-0000-0000-000000000000	68	nyvwylsluo4t	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 16:15:07.325572+00	2025-06-01 16:15:07.325572+00	\N	1aad1538-5b3e-4623-a7b0-ea353eece504
00000000-0000-0000-0000-000000000000	69	w5mfekmvpqpk	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 16:19:55.622181+00	2025-06-01 16:19:55.622181+00	\N	8be73308-9ae3-4259-ad8d-28c474fc2ef1
00000000-0000-0000-0000-000000000000	70	gbedmdo73kln	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 16:20:43.529876+00	2025-06-01 16:20:43.529876+00	\N	67ab4420-da4d-406c-b85d-ba4e614e3e6a
00000000-0000-0000-0000-000000000000	71	rgw2pxcyxj33	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 16:23:13.503795+00	2025-06-01 16:23:13.503795+00	\N	34488907-af8a-46c5-9399-491dcb72e981
00000000-0000-0000-0000-000000000000	72	eoekfhcnoijy	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 16:25:46.304208+00	2025-06-01 16:25:46.304208+00	\N	7aac3bd0-926c-4890-bfe7-811b27c0d353
00000000-0000-0000-0000-000000000000	73	vjvnoalmmez4	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 17:10:25.668649+00	2025-06-01 17:10:25.668649+00	\N	290e65e4-685a-4c3e-a6d4-45639e47e14f
00000000-0000-0000-0000-000000000000	74	mdaxiplumeef	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 17:10:43.344541+00	2025-06-01 17:10:43.344541+00	\N	e08294bb-04db-4a43-b4d4-77c1547a99f6
00000000-0000-0000-0000-000000000000	75	xhr2keznhsr6	8211960d-7c4c-4fc3-9816-370d52dda6c8	t	2025-06-01 17:12:01.78929+00	2025-06-01 18:12:57.07311+00	\N	76f4c616-f5cb-4b45-abb7-bb522c2c3987
00000000-0000-0000-0000-000000000000	76	y345ps4mr46l	8211960d-7c4c-4fc3-9816-370d52dda6c8	t	2025-06-01 18:12:57.07793+00	2025-06-01 19:11:27.231726+00	xhr2keznhsr6	76f4c616-f5cb-4b45-abb7-bb522c2c3987
00000000-0000-0000-0000-000000000000	77	nva2zybmbfgi	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 19:11:27.234683+00	2025-06-01 19:11:27.234683+00	y345ps4mr46l	76f4c616-f5cb-4b45-abb7-bb522c2c3987
00000000-0000-0000-0000-000000000000	78	auda6gxlle2n	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 20:29:20.866715+00	2025-06-01 20:29:20.866715+00	\N	41a3d84c-ddfb-4b38-a4b5-97f6214417ca
00000000-0000-0000-0000-000000000000	79	hxa4nohf6xys	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 20:36:51.29513+00	2025-06-01 20:36:51.29513+00	\N	e1e612b4-d5cf-414a-b7b5-02ab125aed2e
00000000-0000-0000-0000-000000000000	80	vwo2ijkfglkg	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 20:40:08.421844+00	2025-06-01 20:40:08.421844+00	\N	29948e9b-5c56-49c0-9883-e702bc2782b5
00000000-0000-0000-0000-000000000000	81	g2vlw66wgehe	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 20:45:04.131692+00	2025-06-01 20:45:04.131692+00	\N	f10c3ac3-827b-4984-a18e-b33746b9e168
00000000-0000-0000-0000-000000000000	82	mo5bdhyeuv5t	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 20:49:12.73455+00	2025-06-01 20:49:12.73455+00	\N	10d36310-4944-4444-b89d-d1d61025a7b5
00000000-0000-0000-0000-000000000000	83	3nl5expevoy2	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 21:00:12.345478+00	2025-06-01 21:00:12.345478+00	\N	50877aa4-93f1-413d-87d9-236edb3b178d
00000000-0000-0000-0000-000000000000	84	nr2odbpkxexb	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 21:06:00.806518+00	2025-06-01 21:06:00.806518+00	\N	f87814c2-446b-49c3-b405-7b7ca650be2b
00000000-0000-0000-0000-000000000000	85	5e2rvdyqfedt	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 21:10:57.779055+00	2025-06-01 21:10:57.779055+00	\N	ff64626b-926f-4d4d-87fa-075020b0d7a7
00000000-0000-0000-0000-000000000000	86	hnkgv7uk7hay	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 21:14:42.996718+00	2025-06-01 21:14:42.996718+00	\N	1253e712-210d-4d8f-b738-18f7ce5300c0
00000000-0000-0000-0000-000000000000	87	skig664atqdv	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-01 21:15:00.467215+00	2025-06-01 21:15:00.467215+00	\N	b67d7d22-32b8-463b-bf0c-620ba61b5a0b
00000000-0000-0000-0000-000000000000	88	ot73742pcork	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-02 10:22:46.673091+00	2025-06-02 10:22:46.673091+00	\N	0dd3a5d2-b14a-46e3-8579-a1575265c5cc
00000000-0000-0000-0000-000000000000	89	wpmyx4s2p524	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-02 11:10:01.989739+00	2025-06-02 11:10:01.989739+00	\N	b7783291-fa05-4fe1-bacf-56940bd7c192
00000000-0000-0000-0000-000000000000	90	gtddovgjwx3c	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-02 11:26:03.803604+00	2025-06-02 11:26:03.803604+00	\N	85328d21-70d7-4db2-bb09-2884b12b4696
00000000-0000-0000-0000-000000000000	91	nenovbp7rikg	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-02 11:44:05.875331+00	2025-06-02 11:44:05.875331+00	\N	e3b9e3fe-488d-4f03-b49d-9f47c898fb43
00000000-0000-0000-0000-000000000000	92	re3a7pig6opt	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-02 13:20:05.969824+00	2025-06-02 13:20:05.969824+00	\N	d9f64ac8-bd0c-41f4-9ded-b5ca2783de62
00000000-0000-0000-0000-000000000000	93	ww27sodsxor6	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-02 13:20:16.918841+00	2025-06-02 13:20:16.918841+00	\N	c97fd6e9-460c-4bdf-aa51-3918dbe9bf1b
00000000-0000-0000-0000-000000000000	94	2winwnda7kx7	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-02 15:21:42.476385+00	2025-06-02 15:21:42.476385+00	\N	e0e64b51-1e4b-49b5-8ccc-2c99ce65a877
00000000-0000-0000-0000-000000000000	95	gzy5y7qiimm3	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-02 15:22:56.400389+00	2025-06-02 15:22:56.400389+00	\N	3fbb858b-a44c-4150-86cf-3bcbe90df062
00000000-0000-0000-0000-000000000000	96	464jcmkgzbls	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-02 15:30:25.09978+00	2025-06-02 15:30:25.09978+00	\N	d92cec79-40ee-423a-85eb-3965c4f35f32
00000000-0000-0000-0000-000000000000	97	bdw22lbnwwe6	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-02 15:37:36.341216+00	2025-06-02 15:37:36.341216+00	\N	95a3a6f2-1760-48f9-bbd7-b9a376403451
00000000-0000-0000-0000-000000000000	98	bwfmhvckotry	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-02 15:37:45.482708+00	2025-06-02 15:37:45.482708+00	\N	7e9e393d-f945-4901-9631-b95770225d1d
00000000-0000-0000-0000-000000000000	99	i6q7qv3sw5x4	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-02 15:42:08.774918+00	2025-06-02 15:42:08.774918+00	\N	e2613f0b-7b8f-49e1-82fb-2b2d1c6cc12f
00000000-0000-0000-0000-000000000000	100	pn225ed3e5qg	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-02 15:47:24.48928+00	2025-06-02 15:47:24.48928+00	\N	d6d08e44-e846-4dc7-a1ed-aa98a64f8c92
00000000-0000-0000-0000-000000000000	101	baa2zixze6iy	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-03 09:08:42.959009+00	2025-06-03 09:08:42.959009+00	\N	c887c5c6-94c2-4c69-a07a-58311ec8c52b
00000000-0000-0000-0000-000000000000	102	w4xx3fupkzx6	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-03 09:57:16.979665+00	2025-06-03 09:57:16.979665+00	\N	9e9a7501-2462-4bbb-96ac-d8a2a6a46b54
00000000-0000-0000-0000-000000000000	103	2eu4sll7qnka	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-03 16:01:48.669301+00	2025-06-03 16:01:48.669301+00	\N	01c65b13-7588-4285-af8b-69880e679870
00000000-0000-0000-0000-000000000000	104	xeynbwavd7id	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-03 17:04:09.752109+00	2025-06-03 17:04:09.752109+00	\N	385ff898-5a32-4ed7-8277-b17f9d99b032
00000000-0000-0000-0000-000000000000	105	tyqn7bgyu2gz	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-03 17:15:27.041916+00	2025-06-03 17:15:27.041916+00	\N	81ee472a-a1e5-4008-96d1-acd2308fdb12
00000000-0000-0000-0000-000000000000	106	x4mgnkcdwyxz	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-03 17:44:49.482689+00	2025-06-03 17:44:49.482689+00	\N	fe293b8a-cbc9-4510-90cd-8cf62586808a
00000000-0000-0000-0000-000000000000	107	tumg7gl7flzt	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-05 09:23:00.080913+00	2025-06-05 09:23:00.080913+00	\N	2bdcb6c7-d8b8-4ab4-8f82-415361ccdf5a
00000000-0000-0000-0000-000000000000	108	c7zdrk4sjtjw	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-05 09:57:36.209547+00	2025-06-05 09:57:36.209547+00	\N	effb726b-d217-474e-a49d-00a419ad9207
00000000-0000-0000-0000-000000000000	109	xcvrlu7uoxj3	589ba55a-f5c6-4880-b814-b23632e637a4	t	2025-06-09 12:01:13.558067+00	2025-06-09 12:59:26.387068+00	\N	bdbf7dc4-5910-4a3b-8af8-f36a5e5243a0
00000000-0000-0000-0000-000000000000	110	ucyioczhwuqp	589ba55a-f5c6-4880-b814-b23632e637a4	t	2025-06-09 12:59:26.396418+00	2025-06-09 13:57:26.560543+00	xcvrlu7uoxj3	bdbf7dc4-5910-4a3b-8af8-f36a5e5243a0
00000000-0000-0000-0000-000000000000	111	yg5f5hxsii73	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-09 13:57:26.564861+00	2025-06-09 13:57:26.564861+00	ucyioczhwuqp	bdbf7dc4-5910-4a3b-8af8-f36a5e5243a0
00000000-0000-0000-0000-000000000000	112	f3oa6ut2h5xk	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-10 13:29:25.48393+00	2025-06-10 13:29:25.48393+00	\N	c01220eb-2743-49b3-b740-c5d28c912006
00000000-0000-0000-0000-000000000000	113	zaovoe377dbs	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-10 13:40:10.121705+00	2025-06-10 13:40:10.121705+00	\N	17734dfe-c921-4486-aca9-8510576a165e
00000000-0000-0000-0000-000000000000	114	lj3wyynash2l	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-10 13:40:18.789437+00	2025-06-10 13:40:18.789437+00	\N	f0250f26-3cd2-4b26-8684-10fde6995742
00000000-0000-0000-0000-000000000000	115	6ruwpsm52ddu	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-10 13:41:19.074016+00	2025-06-10 13:41:19.074016+00	\N	935d349b-c7aa-4567-8741-796be4a0ca66
00000000-0000-0000-0000-000000000000	116	yqwsumjcjorr	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-10 13:58:14.068117+00	2025-06-10 13:58:14.068117+00	\N	b49de846-9433-4c1a-82ca-0150975bc794
00000000-0000-0000-0000-000000000000	117	s4k6a4xp5uc4	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-10 14:05:08.45562+00	2025-06-10 14:05:08.45562+00	\N	d1713cd0-1f38-4bb4-a5ce-c4efd702e8f1
00000000-0000-0000-0000-000000000000	118	6uzfgvfbmxhe	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-10 14:11:36.297698+00	2025-06-10 14:11:36.297698+00	\N	cb669d12-a79e-402f-b215-866307389ccc
00000000-0000-0000-0000-000000000000	119	5i3ewcuphqh4	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-10 14:16:27.840271+00	2025-06-10 14:16:27.840271+00	\N	c45a27ae-27af-43e6-a09e-2404dbb6a650
00000000-0000-0000-0000-000000000000	120	uk453gtrubtt	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-10 14:25:00.710599+00	2025-06-10 14:25:00.710599+00	\N	2ae251f8-dbcd-42bc-aa67-1204a284ce3e
00000000-0000-0000-0000-000000000000	121	6pmag2sa6ojq	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-10 14:29:02.266077+00	2025-06-10 14:29:02.266077+00	\N	812aae94-1821-46a3-a8bb-78ea02c90f4a
00000000-0000-0000-0000-000000000000	122	u2pffec6npi4	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-10 14:29:14.676571+00	2025-06-10 14:29:14.676571+00	\N	cb9d95c5-c2a7-42d9-abd3-e4da631a957b
00000000-0000-0000-0000-000000000000	123	viptki5qad7l	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-10 14:44:21.030958+00	2025-06-10 14:44:21.030958+00	\N	a7e1a434-fc4a-4d00-8d6c-01b0a04282ce
00000000-0000-0000-0000-000000000000	124	gspg4knfar6m	8211960d-7c4c-4fc3-9816-370d52dda6c8	t	2025-06-10 14:45:50.7081+00	2025-06-10 15:51:15.989121+00	\N	1c10072a-a28b-4f3d-b1ea-d7575d2cb5d3
00000000-0000-0000-0000-000000000000	125	d35ixehdac7d	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-10 15:51:15.999393+00	2025-06-10 15:51:15.999393+00	gspg4knfar6m	1c10072a-a28b-4f3d-b1ea-d7575d2cb5d3
00000000-0000-0000-0000-000000000000	126	3n3hyoi7iokg	8211960d-7c4c-4fc3-9816-370d52dda6c8	t	2025-06-10 16:12:53.976857+00	2025-06-10 17:11:44.63641+00	\N	224d0aad-78df-48d9-ad1f-eb05fa43d1c8
00000000-0000-0000-0000-000000000000	127	xhxjsgl2bzdx	8211960d-7c4c-4fc3-9816-370d52dda6c8	t	2025-06-10 17:11:44.641529+00	2025-06-10 19:09:07.52282+00	3n3hyoi7iokg	224d0aad-78df-48d9-ad1f-eb05fa43d1c8
00000000-0000-0000-0000-000000000000	128	ep5u2fwrnmwb	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-10 19:09:07.52868+00	2025-06-10 19:09:07.52868+00	xhxjsgl2bzdx	224d0aad-78df-48d9-ad1f-eb05fa43d1c8
00000000-0000-0000-0000-000000000000	129	y3ksxrb7aoht	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:23:21.538242+00	2025-06-13 17:23:21.538242+00	\N	a9959d9d-4918-48d0-8189-e087c821c169
00000000-0000-0000-0000-000000000000	130	omtezmx22yck	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:23:28.984669+00	2025-06-13 17:23:28.984669+00	\N	72662a99-1f9c-4c20-a223-c5a8577bdc4c
00000000-0000-0000-0000-000000000000	131	i32esfjbf6dz	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:23:30.49965+00	2025-06-13 17:23:30.49965+00	\N	f452ee0f-c15f-4693-9b9e-2fbc5fd35004
00000000-0000-0000-0000-000000000000	132	m3vueuj2f65c	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:37:40.391432+00	2025-06-13 17:37:40.391432+00	\N	ccee215e-2d0b-44aa-9e24-82f02fb08438
00000000-0000-0000-0000-000000000000	133	bohz7qbyazcj	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:39:10.398175+00	2025-06-13 17:39:10.398175+00	\N	5ece34d0-9c45-4acd-911f-b2619ff59e8d
00000000-0000-0000-0000-000000000000	134	jdwubv2qtbis	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:47:01.862252+00	2025-06-13 17:47:01.862252+00	\N	cc3dd629-cb27-48d0-91dd-22b09bda0081
00000000-0000-0000-0000-000000000000	135	uflcnr6c4wvo	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:47:06.553995+00	2025-06-13 17:47:06.553995+00	\N	bdb214a4-d628-4877-b657-2fb1e359b85e
00000000-0000-0000-0000-000000000000	136	fnuzpslnqsjn	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:47:30.114489+00	2025-06-13 17:47:30.114489+00	\N	8551e867-aabf-4b46-8cab-1ff841f3871a
00000000-0000-0000-0000-000000000000	137	5tio2joxohie	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:47:40.776262+00	2025-06-13 17:47:40.776262+00	\N	43775378-ae9c-40eb-931e-28f35d00bb13
00000000-0000-0000-0000-000000000000	138	2fz6bcwqknkh	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:48:54.545622+00	2025-06-13 17:48:54.545622+00	\N	57c205d1-5ffa-4019-a426-215ab12da703
00000000-0000-0000-0000-000000000000	139	3ix3a3u24plo	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:50:59.246813+00	2025-06-13 17:50:59.246813+00	\N	3a374dcb-e37e-4101-bb4e-256afe70e363
00000000-0000-0000-0000-000000000000	140	ok6ikx7bfhqy	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:51:50.127535+00	2025-06-13 17:51:50.127535+00	\N	b0f84562-a15d-4ebb-befb-ce83a21e1434
00000000-0000-0000-0000-000000000000	141	473opdphl2aq	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:52:02.72403+00	2025-06-13 17:52:02.72403+00	\N	87d897f9-f174-4261-af5c-ad175a20565c
00000000-0000-0000-0000-000000000000	142	tkscemoq564v	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:53:27.010647+00	2025-06-13 17:53:27.010647+00	\N	e152e237-e555-47ff-a393-3464a31ce3bb
00000000-0000-0000-0000-000000000000	143	zq6o64223uc4	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:55:36.206142+00	2025-06-13 17:55:36.206142+00	\N	8f0c6575-4705-43d7-87be-e3398ec01ef7
00000000-0000-0000-0000-000000000000	144	wmcmss4oyu6h	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:57:04.487958+00	2025-06-13 17:57:04.487958+00	\N	ef2801d2-85ad-4506-9bf0-e231ca8c4023
00000000-0000-0000-0000-000000000000	145	km5u7ohov6kp	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 17:57:15.25381+00	2025-06-13 17:57:15.25381+00	\N	afe8f4da-faa4-492e-ba53-0ae415103724
00000000-0000-0000-0000-000000000000	146	3h6lsbxb3wkf	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-13 17:57:19.01688+00	2025-06-13 17:57:19.01688+00	\N	57a5ea36-69ab-486b-bf85-e504fd2f11a6
00000000-0000-0000-0000-000000000000	147	lghsma5jet3o	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-13 17:57:29.574134+00	2025-06-13 17:57:29.574134+00	\N	d43f6e2c-a583-4bdf-82d6-4747837b6e1a
00000000-0000-0000-0000-000000000000	148	onu2mk4eersf	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-13 18:06:06.399392+00	2025-06-13 18:06:06.399392+00	\N	32ada9ff-4c9d-4b1c-a29b-bec1619d6c33
00000000-0000-0000-0000-000000000000	149	cclrlykbizpr	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-13 18:08:51.097416+00	2025-06-13 18:08:51.097416+00	\N	f8e42108-b9a9-4bc6-8584-afa802058543
00000000-0000-0000-0000-000000000000	150	dns7f54cp5j3	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-13 18:08:56.51144+00	2025-06-13 18:08:56.51144+00	\N	f1380e23-e836-46ef-9d0a-b226f735f2a9
00000000-0000-0000-0000-000000000000	151	mvmi5xah73p3	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-13 18:12:32.471519+00	2025-06-13 18:12:32.471519+00	\N	4dd94fab-7bd2-43b1-abf4-2476c9de00ca
00000000-0000-0000-0000-000000000000	152	ne34qefcyudx	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:12:37.576628+00	2025-06-13 18:12:37.576628+00	\N	3936b9cd-5d14-4f53-a469-9a17112ceb8b
00000000-0000-0000-0000-000000000000	153	x7obuvapz2mr	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:16:10.737214+00	2025-06-13 18:16:10.737214+00	\N	5aa15941-bca2-4f9f-a766-e6e135ceae65
00000000-0000-0000-0000-000000000000	154	thxund4wtvgs	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:16:29.551143+00	2025-06-13 18:16:29.551143+00	\N	395af682-fc4a-47b2-90ae-e6a78978c700
00000000-0000-0000-0000-000000000000	155	22bqwelv75uk	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:17:58.883611+00	2025-06-13 18:17:58.883611+00	\N	b52e369a-1b2d-4781-8e10-0cb2e0771039
00000000-0000-0000-0000-000000000000	156	f4az2eii2y67	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:18:13.756935+00	2025-06-13 18:18:13.756935+00	\N	7e782e1e-2b92-44bc-8542-1e723affb206
00000000-0000-0000-0000-000000000000	157	uat2rzt5xaur	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:20:33.291441+00	2025-06-13 18:20:33.291441+00	\N	40655390-2af8-410c-a41c-50dc154487f2
00000000-0000-0000-0000-000000000000	158	lvxy7rn36v7u	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:20:43.601499+00	2025-06-13 18:20:43.601499+00	\N	832e1267-8689-43fb-8707-31a85a4ec0ee
00000000-0000-0000-0000-000000000000	159	r27wv4adhbc3	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:22:55.149965+00	2025-06-13 18:22:55.149965+00	\N	e3de2713-a908-4f1c-9e85-58da53281b41
00000000-0000-0000-0000-000000000000	160	d5tjqn32m35i	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:23:06.836259+00	2025-06-13 18:23:06.836259+00	\N	c16b4cea-147e-4ccc-aa8d-2f0474d16811
00000000-0000-0000-0000-000000000000	161	zb3gzmyl74mb	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:24:19.970496+00	2025-06-13 18:24:19.970496+00	\N	c59bad02-323e-4810-97bb-2afe732b698f
00000000-0000-0000-0000-000000000000	162	ocxesgz5izeq	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:24:32.502319+00	2025-06-13 18:24:32.502319+00	\N	baba198b-f2be-43f8-98f4-d09bba604c20
00000000-0000-0000-0000-000000000000	163	b3fyrblkremf	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:25:51.198615+00	2025-06-13 18:25:51.198615+00	\N	69df712f-b1ef-45b4-bc09-71825e8b9e75
00000000-0000-0000-0000-000000000000	164	vemlrodhwg7j	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:34:42.612925+00	2025-06-13 18:34:42.612925+00	\N	fc3a81d0-9926-4cf6-b342-31f2f16e604e
00000000-0000-0000-0000-000000000000	165	asgp72lf5lqo	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:36:07.034886+00	2025-06-13 18:36:07.034886+00	\N	9a62d7ac-70cb-44ac-8b28-f64230d1994b
00000000-0000-0000-0000-000000000000	166	p5vtl5a4jtns	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:38:56.088458+00	2025-06-13 18:38:56.088458+00	\N	b60b6b86-1243-4e5c-b1e5-e79f3c40e4a3
00000000-0000-0000-0000-000000000000	167	sfkvufa64xrq	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:39:23.047175+00	2025-06-13 18:39:23.047175+00	\N	85340914-2c4e-4fca-821d-4ef310073811
00000000-0000-0000-0000-000000000000	168	rrbkrntnfcet	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:41:27.248167+00	2025-06-13 18:41:27.248167+00	\N	26435738-4945-498e-b402-323de3f4d1d1
00000000-0000-0000-0000-000000000000	169	qt2mn46byjg6	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:41:37.970234+00	2025-06-13 18:41:37.970234+00	\N	574fa09f-8daf-47fe-bb65-7c8bceff0b67
00000000-0000-0000-0000-000000000000	170	ytbq6xc6lghz	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:43:40.440561+00	2025-06-13 18:43:40.440561+00	\N	a42432b2-200f-4115-b021-060281ca4b8f
00000000-0000-0000-0000-000000000000	171	scpd3sy7zfyc	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:43:49.314604+00	2025-06-13 18:43:49.314604+00	\N	0f9919d1-2cb0-41db-8cd7-014810751b22
00000000-0000-0000-0000-000000000000	172	kcjcd26sup76	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:43:54.239974+00	2025-06-13 18:43:54.239974+00	\N	21e426cb-13bc-401a-86c1-514bc43deb8b
00000000-0000-0000-0000-000000000000	173	yhwpdwlgg4h6	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:44:07.505401+00	2025-06-13 18:44:07.505401+00	\N	4d0abd7a-521c-4d28-8ec2-eda65edc43f3
00000000-0000-0000-0000-000000000000	174	eiubaew5v3pn	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:45:31.571503+00	2025-06-13 18:45:31.571503+00	\N	94c2dda4-b0be-463d-b188-38566b891ea7
00000000-0000-0000-0000-000000000000	175	gvniajwu6oil	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:45:36.728529+00	2025-06-13 18:45:36.728529+00	\N	66e2bbca-68bc-4f30-83f9-f6056829cf50
00000000-0000-0000-0000-000000000000	176	kwsfkd4v34j2	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:46:54.211401+00	2025-06-13 18:46:54.211401+00	\N	7d34f1d3-85ab-4131-b3e2-df88ec066bd9
00000000-0000-0000-0000-000000000000	177	744cl7czw7nt	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:49:17.976543+00	2025-06-13 18:49:17.976543+00	\N	55fafd0e-2833-43fc-b291-55a18752773b
00000000-0000-0000-0000-000000000000	178	mkjx463d7g4r	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:49:24.330194+00	2025-06-13 18:49:24.330194+00	\N	f9cc77dd-f687-4d47-b4e3-1905edb05748
00000000-0000-0000-0000-000000000000	179	6i4rmhkkn3de	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 18:50:37.813758+00	2025-06-13 18:50:37.813758+00	\N	0ac9421c-06f2-4a0c-b953-440c79f17a3a
00000000-0000-0000-0000-000000000000	180	lxt7np3tnpbr	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 19:28:26.950727+00	2025-06-13 19:28:26.950727+00	\N	d974988f-6f87-448a-957c-5b9fb870e97d
00000000-0000-0000-0000-000000000000	181	yvyucr6e5ha5	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 19:31:19.479487+00	2025-06-13 19:31:19.479487+00	\N	768be3f0-ac83-479d-9217-5af29f4bae16
00000000-0000-0000-0000-000000000000	182	xmxlwpdzxphq	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 19:31:26.314548+00	2025-06-13 19:31:26.314548+00	\N	a3d4999d-5849-4b40-b671-109cabe28f3c
00000000-0000-0000-0000-000000000000	183	j3cvapznrdu4	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 19:33:29.524127+00	2025-06-13 19:33:29.524127+00	\N	d05ededb-b83c-4be7-93aa-c08b42f2d3ed
00000000-0000-0000-0000-000000000000	184	qgebg6fdowhv	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 19:34:15.202922+00	2025-06-13 19:34:15.202922+00	\N	b305c3e7-b76f-4278-9bba-c732a4e4425b
00000000-0000-0000-0000-000000000000	185	dnkzstvdiw4a	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 20:33:03.556404+00	2025-06-13 20:33:03.556404+00	\N	3ffda28e-fb0c-4e5c-b340-2bb31485f90c
00000000-0000-0000-0000-000000000000	186	brli5jf6vlzq	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 20:33:10.333524+00	2025-06-13 20:33:10.333524+00	\N	ce4f9220-6ddd-40e4-adaa-e6ff6456380c
00000000-0000-0000-0000-000000000000	187	nhtfbllvj5ns	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 20:36:37.802214+00	2025-06-13 20:36:37.802214+00	\N	12d1ebdc-a6e9-4f76-b812-e105bc7dbfd7
00000000-0000-0000-0000-000000000000	188	ldetw5csjpge	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 20:40:59.253857+00	2025-06-13 20:40:59.253857+00	\N	1b4eda20-9717-42a6-88da-76a7260942a9
00000000-0000-0000-0000-000000000000	189	wu2zonr5uzvc	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 20:47:18.858643+00	2025-06-13 20:47:18.858643+00	\N	96e80344-f4d7-410f-aebf-8f430f04ec36
00000000-0000-0000-0000-000000000000	190	s3c33zhvrzmo	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 20:49:53.563294+00	2025-06-13 20:49:53.563294+00	\N	d1079952-4303-4c11-af0d-4e418e7bb6b7
00000000-0000-0000-0000-000000000000	191	6utbt6r3bzn3	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 20:50:57.480611+00	2025-06-13 20:50:57.480611+00	\N	9ab90fb8-f005-4e3b-933c-aa8c38eb943a
00000000-0000-0000-0000-000000000000	192	gkbvlprapliq	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 20:58:53.760052+00	2025-06-13 20:58:53.760052+00	\N	61956de8-ee8c-4857-985c-ed7c5c2e966e
00000000-0000-0000-0000-000000000000	193	7rbe6h54efps	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 21:14:03.567312+00	2025-06-13 21:14:03.567312+00	\N	ce3342cb-166b-40a9-90b1-b104fe3f1216
00000000-0000-0000-0000-000000000000	194	r3n7auoo5oln	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 21:18:37.89969+00	2025-06-13 21:18:37.89969+00	\N	6aa8fe10-742a-45c7-b222-716c5790e41e
00000000-0000-0000-0000-000000000000	195	rllleqky3bmi	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 21:24:11.961323+00	2025-06-13 21:24:11.961323+00	\N	4b0e7106-e059-4402-be60-f5c9c7e2dff1
00000000-0000-0000-0000-000000000000	196	rkq6qrxh6sst	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 21:37:11.971465+00	2025-06-13 21:37:11.971465+00	\N	3c230eff-8f4b-4e22-9bdc-7deacd8ea466
00000000-0000-0000-0000-000000000000	197	xbxl4gbxwc5s	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 21:37:12.33372+00	2025-06-13 21:37:12.33372+00	\N	aa634547-abc6-46ce-8ef2-d776bc654fd7
00000000-0000-0000-0000-000000000000	198	7ydgjptvgcam	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-13 21:54:27.602485+00	2025-06-13 21:54:27.602485+00	\N	512fda62-f162-4093-95a1-e4aaecb4c50f
00000000-0000-0000-0000-000000000000	199	vmpv66juqjdc	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-13 21:56:16.723377+00	2025-06-13 21:56:16.723377+00	\N	d82d7328-233e-4675-8386-3b916c7efa37
00000000-0000-0000-0000-000000000000	200	o2ty7o4pflu4	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-14 13:36:05.989938+00	2025-06-14 13:36:05.989938+00	\N	df92cea2-78cd-4c3e-bed1-7c9df8c9d7be
00000000-0000-0000-0000-000000000000	201	ou2upzoztvdo	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-14 13:36:44.724399+00	2025-06-14 13:36:44.724399+00	\N	cffd461e-102b-4947-a530-3d553926417f
00000000-0000-0000-0000-000000000000	202	c537isn4molv	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-14 13:36:59.631812+00	2025-06-14 13:36:59.631812+00	\N	35fd2080-7138-4430-9300-dd7b3e0e1952
00000000-0000-0000-0000-000000000000	203	zgvxjpbrjpkz	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-14 13:37:46.871435+00	2025-06-14 13:37:46.871435+00	\N	bb1a1585-803c-4e12-8e06-82097ce3b19f
00000000-0000-0000-0000-000000000000	204	r7cl6zl5rmu5	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-14 13:51:35.532864+00	2025-06-14 13:51:35.532864+00	\N	0e7e9fee-7bed-4fc1-8f8c-000c1ef997f9
00000000-0000-0000-0000-000000000000	205	jskigswktsxq	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-14 13:53:36.332528+00	2025-06-14 13:53:36.332528+00	\N	b82955c4-4a7c-4746-9918-3c37bcbb42d1
00000000-0000-0000-0000-000000000000	206	y6lrngl3frfk	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-16 13:31:48.805121+00	2025-06-16 13:31:48.805121+00	\N	0da91356-03ab-4b4d-a5f7-c72c32e35012
00000000-0000-0000-0000-000000000000	207	rrd5m7vrntd5	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-16 13:33:50.824973+00	2025-06-16 13:33:50.824973+00	\N	e90c0908-78be-4eb6-8dda-10bac673f8b7
00000000-0000-0000-0000-000000000000	208	wdz6jn2zk5kr	bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	f	2025-06-16 13:44:41.900542+00	2025-06-16 13:44:41.900542+00	\N	ea1f7f48-8983-4071-bac2-61fc13015ad4
00000000-0000-0000-0000-000000000000	209	za7scwygdgsl	bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	f	2025-06-16 13:45:42.317069+00	2025-06-16 13:45:42.317069+00	\N	d08d3d75-3785-499a-838a-81a2c0f7f0bc
00000000-0000-0000-0000-000000000000	210	hj6u4tb4cgcg	bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	f	2025-06-16 13:45:52.962752+00	2025-06-16 13:45:52.962752+00	\N	f8dca749-bc5f-40b7-ace8-daa72dd301cc
00000000-0000-0000-0000-000000000000	211	l23dgz55k6oq	bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	f	2025-06-16 13:46:19.889879+00	2025-06-16 13:46:19.889879+00	\N	27e14048-4194-41b1-b78c-65ada6d55ff1
00000000-0000-0000-0000-000000000000	212	fa3ixhjvr4w6	fd9ce997-3b05-471e-9d87-1f82688b9d97	f	2025-06-16 15:22:40.033829+00	2025-06-16 15:22:40.033829+00	\N	f19d4fb4-ecbe-4fa9-a681-6ead8c59f993
00000000-0000-0000-0000-000000000000	213	4kwprj36whfu	fd9ce997-3b05-471e-9d87-1f82688b9d97	f	2025-06-16 15:23:23.274516+00	2025-06-16 15:23:23.274516+00	\N	7795aed5-1e5a-441c-9d81-fe6638178517
00000000-0000-0000-0000-000000000000	214	bt26f4wzuw75	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-16 15:25:13.434519+00	2025-06-16 15:25:13.434519+00	\N	a1213af3-d174-4bb2-af90-f0c4f112628a
00000000-0000-0000-0000-000000000000	215	ff4ap4t63xs7	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-17 13:35:22.289467+00	2025-06-17 13:35:22.289467+00	\N	c6f65703-1237-4510-adfb-f3506a31a35e
00000000-0000-0000-0000-000000000000	216	6xdumb3lblya	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-17 13:35:50.412388+00	2025-06-17 13:35:50.412388+00	\N	bb7c5d5d-c035-4310-ac9a-3a97586c34a5
00000000-0000-0000-0000-000000000000	217	4w5nfmaqvfce	e2696184-e809-4108-b08b-ece20065cde3	f	2025-06-17 15:02:05.376438+00	2025-06-17 15:02:05.376438+00	\N	87039e32-7e21-40a5-b330-4cf1998f37fa
00000000-0000-0000-0000-000000000000	218	jiys3svjylx6	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-17 15:02:12.687798+00	2025-06-17 15:02:12.687798+00	\N	d51e22c1-8633-41b2-8417-1604eb4d1b76
00000000-0000-0000-0000-000000000000	219	xdgp5yfsxbca	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-17 15:02:22.241103+00	2025-06-17 15:02:22.241103+00	\N	a2137bc3-3e4c-4183-9ad5-aafc5927c275
00000000-0000-0000-0000-000000000000	220	juwtpmv4ucrn	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-17 15:18:17.11247+00	2025-06-17 15:18:17.11247+00	\N	9568fdb6-9de5-4bea-aff7-39cfd275a827
00000000-0000-0000-0000-000000000000	221	ve3cn5vdirj3	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-17 15:19:04.307408+00	2025-06-17 15:19:04.307408+00	\N	cfc77c50-7648-4bfe-acc0-5699a03415ff
00000000-0000-0000-0000-000000000000	222	6xhcejbc5mdq	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-17 15:24:02.902013+00	2025-06-17 15:24:02.902013+00	\N	059ee39f-ec24-40b8-9c72-722b449d8e08
00000000-0000-0000-0000-000000000000	223	odofjvus3lgg	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-17 15:25:49.951386+00	2025-06-17 15:25:49.951386+00	\N	5a43643b-887b-4cca-8e14-259dddb62f7d
00000000-0000-0000-0000-000000000000	224	etq23r27moab	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-17 15:26:04.434325+00	2025-06-17 15:26:04.434325+00	\N	da099d3e-bfb8-4577-a728-f60a462665c9
00000000-0000-0000-0000-000000000000	225	jse7ohptzgsq	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-17 15:26:09.904386+00	2025-06-17 15:26:09.904386+00	\N	e8b98818-9c9c-4836-a547-d6931c71b1f8
00000000-0000-0000-0000-000000000000	226	zmhrcs2ylgwu	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-17 15:30:26.545059+00	2025-06-17 15:30:26.545059+00	\N	5d52b593-e4e1-4a1d-8434-371df3bf1119
00000000-0000-0000-0000-000000000000	227	xj47wpthovht	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-17 15:30:37.156698+00	2025-06-17 15:30:37.156698+00	\N	0dceef46-9d54-4672-b8ea-31e7d6846fff
00000000-0000-0000-0000-000000000000	228	okmsxs5wgc74	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-17 17:36:10.741111+00	2025-06-17 17:36:10.741111+00	\N	e48814df-b82d-4f85-9e10-d7225821629e
00000000-0000-0000-0000-000000000000	229	zyahqmhwmbkm	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-17 17:37:35.305607+00	2025-06-17 17:37:35.305607+00	\N	c9fe46df-ce27-40a1-bb34-039ce0630e57
00000000-0000-0000-0000-000000000000	230	ezdwwpcfmki6	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-19 11:52:38.13579+00	2025-06-19 11:52:38.13579+00	\N	3fbd17e1-2c70-4f32-a691-bc196948e3c7
00000000-0000-0000-0000-000000000000	231	umck7rqdgsdn	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-19 11:52:46.505241+00	2025-06-19 11:52:46.505241+00	\N	67634db9-803e-4805-8dd4-e96277e8c9cd
00000000-0000-0000-0000-000000000000	232	pebttxg6e22n	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-19 11:54:56.302624+00	2025-06-19 11:54:56.302624+00	\N	2e27d7c8-dcf3-4ee7-8d44-7cd0b710c65a
00000000-0000-0000-0000-000000000000	233	ba6ulgegi24j	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-19 12:00:16.99885+00	2025-06-19 12:00:16.99885+00	\N	e14fa4e0-e176-4eff-8b5d-66b6b0f4b361
00000000-0000-0000-0000-000000000000	234	j6zl3cju7s2z	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-19 12:01:05.000073+00	2025-06-19 12:01:05.000073+00	\N	9dce2de9-4d71-4c6d-881c-1ea3debd6bfa
00000000-0000-0000-0000-000000000000	235	flchsywgk6sx	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-19 12:03:46.485456+00	2025-06-19 12:03:46.485456+00	\N	ba3b4bdd-fd32-425b-969c-538a40577d7d
00000000-0000-0000-0000-000000000000	236	jfcrfndumcma	8211960d-7c4c-4fc3-9816-370d52dda6c8	f	2025-06-19 12:04:56.312117+00	2025-06-19 12:04:56.312117+00	\N	da1ed432-a569-4cf5-9800-73348f59e446
00000000-0000-0000-0000-000000000000	237	qjpbrmzg4v26	589ba55a-f5c6-4880-b814-b23632e637a4	f	2025-06-19 12:06:51.772267+00	2025-06-19 12:06:51.772267+00	\N	82020d94-74fd-4919-9d58-9d6ee7e718f7
\.


--
-- TOC entry 4026 (class 0 OID 16836)
-- Dependencies: 288
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- TOC entry 4027 (class 0 OID 16854)
-- Dependencies: 289
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- TOC entry 4015 (class 0 OID 16527)
-- Dependencies: 274
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- TOC entry 4020 (class 0 OID 16734)
-- Dependencies: 282
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
94fd430e-5921-46bd-81ad-bbbcae5bcbfc	a25826c2-495d-4234-8e20-97d97f4db18e	2025-05-26 12:48:34.626915+00	2025-05-26 12:48:34.626915+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	176.33.66.195	\N
04236f6f-4d18-4866-a2fa-6a5d0fbbe196	a25826c2-495d-4234-8e20-97d97f4db18e	2025-05-26 12:51:33.420066+00	2025-05-26 12:51:33.420066+00	\N	aal1	\N	\N	node	176.33.66.195	\N
44c1c938-d156-4979-9501-cf7161d8a111	a25826c2-495d-4234-8e20-97d97f4db18e	2025-05-26 12:52:03.644581+00	2025-05-26 12:52:03.644581+00	\N	aal1	\N	\N	node	176.33.66.195	\N
219730dc-e11d-4696-8dd9-8b1d80ca550d	a25826c2-495d-4234-8e20-97d97f4db18e	2025-05-29 12:00:52.119449+00	2025-05-29 16:54:43.932558+00	\N	aal1	\N	2025-05-29 16:54:43.932464	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	176.227.24.174	\N
227fc40c-ff8f-4bfd-8c89-2611c97df30a	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-05-30 15:38:25.602107+00	2025-05-30 15:38:25.602107+00	\N	aal1	\N	\N	node	78.185.204.30	\N
7c8f9b7a-ca69-4a84-b657-50be6d1f5d80	a25826c2-495d-4234-8e20-97d97f4db18e	2025-05-29 17:03:51.735876+00	2025-05-30 13:32:37.129402+00	\N	aal1	\N	2025-05-30 13:32:37.129317	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	78.185.204.30	\N
78ca5516-3a8c-4620-921c-0ba1ab63960e	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-05-30 14:26:14.540434+00	2025-05-30 14:26:14.540434+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/136.0.7103.91 Mobile/15E148 Safari/604.1	78.185.204.30	\N
e6ddf728-d588-45ce-a6c8-47d42bb5eb7e	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-05-30 14:26:23.088251+00	2025-05-30 14:26:23.088251+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	78.185.204.30	\N
66bce24e-5f75-4826-a9c1-a4d14a04650a	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-05-30 14:28:47.7789+00	2025-05-30 14:28:47.7789+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	78.185.204.30	\N
36c48278-22e1-47e9-871f-d3d953f11e6b	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-05-30 15:19:31.630341+00	2025-05-30 15:19:31.630341+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	78.185.204.30	\N
7dad5c3e-d28b-4142-9a61-213de4248271	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-05-30 15:24:07.535562+00	2025-05-30 15:24:07.535562+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	78.185.204.30	\N
b0e25f6b-bc3f-4764-aa0d-a6833e389980	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-05-30 15:35:22.410068+00	2025-05-30 15:35:22.410068+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	78.185.204.30	\N
27a2a4b7-37a6-4f52-a07b-e56a3330edb1	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 11:44:02.079961+00	2025-06-01 11:44:02.079961+00	\N	aal1	\N	\N	node	217.131.108.186	\N
84197ea1-f4ca-4bbd-a44b-d3c371304e1c	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 11:50:19.968288+00	2025-06-01 11:50:19.968288+00	\N	aal1	\N	\N	node	217.131.108.186	\N
4b801d4b-6572-477e-acd6-771ff1286d79	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:35:07.641025+00	2025-06-01 14:35:07.641025+00	\N	aal1	\N	\N	node	176.237.116.107	\N
e760a07d-bee3-4c26-a9fd-12ec6f5c1497	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:35:15.657361+00	2025-06-01 14:35:15.657361+00	\N	aal1	\N	\N	node	176.237.116.107	\N
01388606-7303-4960-9c33-0e1e53f72d15	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:35:27.792621+00	2025-06-01 14:35:27.792621+00	\N	aal1	\N	\N	node	176.237.116.107	\N
3d58f7ff-ad0b-4f78-8317-ec2680c88ac1	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:39:05.203985+00	2025-06-01 14:39:05.203985+00	\N	aal1	\N	\N	node	176.237.116.107	\N
6cc008e9-5ab7-44fb-9dd5-f6b6caffeea8	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:41:41.966161+00	2025-06-01 14:41:41.966161+00	\N	aal1	\N	\N	node	176.237.116.107	\N
baa4688f-1994-45a9-9512-67611c7fc828	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:42:01.632138+00	2025-06-01 14:42:01.632138+00	\N	aal1	\N	\N	node	176.237.116.107	\N
89c43366-6eea-4d6e-92d9-78ebc720854c	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:42:12.263443+00	2025-06-01 14:42:12.263443+00	\N	aal1	\N	\N	node	176.237.116.107	\N
696864ff-7097-4a6e-af96-6df7710b8c96	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:42:59.079192+00	2025-06-01 14:42:59.079192+00	\N	aal1	\N	\N	node	176.237.116.107	\N
a4687930-563c-4c1f-b14c-8d15ca0bd868	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:44:04.969932+00	2025-06-01 14:44:04.969932+00	\N	aal1	\N	\N	node	176.237.116.107	\N
90266394-6a92-4e5a-b7bd-1fc29b9cbaff	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:47:52.664257+00	2025-06-01 14:47:52.664257+00	\N	aal1	\N	\N	node	176.237.116.107	\N
4518f59f-e9bd-4f8a-b52c-dc590871ce9e	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:50:03.902+00	2025-06-01 14:50:03.902+00	\N	aal1	\N	\N	node	176.237.116.107	\N
d8afcbe2-f4b6-48ad-aea1-7d8438dd651a	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 14:59:41.030572+00	2025-06-01 14:59:41.030572+00	\N	aal1	\N	\N	node	176.237.116.107	\N
ba3dde97-82de-481e-860f-dd1c8a14f124	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 15:04:40.158606+00	2025-06-01 15:04:40.158606+00	\N	aal1	\N	\N	node	176.237.116.107	\N
fc983bdd-a9d3-4756-bc08-cc7ab7836e63	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 15:16:23.30128+00	2025-06-01 15:16:23.30128+00	\N	aal1	\N	\N	node	176.237.116.107	\N
d5cbee0f-db5e-4987-99b3-6388b6e6955a	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 15:34:41.657664+00	2025-06-01 15:34:41.657664+00	\N	aal1	\N	\N	node	176.237.116.107	\N
1aad1538-5b3e-4623-a7b0-ea353eece504	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 16:15:07.322232+00	2025-06-01 16:15:07.322232+00	\N	aal1	\N	\N	node	217.131.108.186	\N
8be73308-9ae3-4259-ad8d-28c474fc2ef1	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 16:19:55.618506+00	2025-06-01 16:19:55.618506+00	\N	aal1	\N	\N	node	217.131.108.186	\N
67ab4420-da4d-406c-b85d-ba4e614e3e6a	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 16:20:43.529223+00	2025-06-01 16:20:43.529223+00	\N	aal1	\N	\N	node	217.131.108.186	\N
34488907-af8a-46c5-9399-491dcb72e981	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 16:23:13.502694+00	2025-06-01 16:23:13.502694+00	\N	aal1	\N	\N	node	217.131.108.186	\N
7aac3bd0-926c-4890-bfe7-811b27c0d353	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 16:25:46.300031+00	2025-06-01 16:25:46.300031+00	\N	aal1	\N	\N	node	217.131.108.186	\N
290e65e4-685a-4c3e-a6d4-45639e47e14f	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 17:10:25.665622+00	2025-06-01 17:10:25.665622+00	\N	aal1	\N	\N	node	217.131.108.186	\N
e08294bb-04db-4a43-b4d4-77c1547a99f6	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 17:10:43.343176+00	2025-06-01 17:10:43.343176+00	\N	aal1	\N	\N	node	217.131.108.186	\N
50877aa4-93f1-413d-87d9-236edb3b178d	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 21:00:12.342869+00	2025-06-01 21:00:12.342869+00	\N	aal1	\N	\N	node	217.131.108.186	\N
76f4c616-f5cb-4b45-abb7-bb522c2c3987	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 17:12:01.787944+00	2025-06-01 19:11:27.238607+00	\N	aal1	\N	2025-06-01 19:11:27.238532	node	217.131.108.186	\N
41a3d84c-ddfb-4b38-a4b5-97f6214417ca	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 20:29:20.862344+00	2025-06-01 20:29:20.862344+00	\N	aal1	\N	\N	node	217.131.108.186	\N
e1e612b4-d5cf-414a-b7b5-02ab125aed2e	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 20:36:51.291675+00	2025-06-01 20:36:51.291675+00	\N	aal1	\N	\N	node	217.131.108.186	\N
29948e9b-5c56-49c0-9883-e702bc2782b5	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 20:40:08.41806+00	2025-06-01 20:40:08.41806+00	\N	aal1	\N	\N	node	217.131.108.186	\N
f10c3ac3-827b-4984-a18e-b33746b9e168	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 20:45:04.129274+00	2025-06-01 20:45:04.129274+00	\N	aal1	\N	\N	node	217.131.108.186	\N
10d36310-4944-4444-b89d-d1d61025a7b5	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 20:49:12.733444+00	2025-06-01 20:49:12.733444+00	\N	aal1	\N	\N	node	217.131.108.186	\N
f87814c2-446b-49c3-b405-7b7ca650be2b	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 21:06:00.803974+00	2025-06-01 21:06:00.803974+00	\N	aal1	\N	\N	node	217.131.108.186	\N
ff64626b-926f-4d4d-87fa-075020b0d7a7	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 21:10:57.776568+00	2025-06-01 21:10:57.776568+00	\N	aal1	\N	\N	node	217.131.108.186	\N
1253e712-210d-4d8f-b738-18f7ce5300c0	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 21:14:42.994914+00	2025-06-01 21:14:42.994914+00	\N	aal1	\N	\N	node	217.131.108.186	\N
b67d7d22-32b8-463b-bf0c-620ba61b5a0b	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-01 21:15:00.466456+00	2025-06-01 21:15:00.466456+00	\N	aal1	\N	\N	node	217.131.108.186	\N
0dd3a5d2-b14a-46e3-8579-a1575265c5cc	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-02 10:22:46.665434+00	2025-06-02 10:22:46.665434+00	\N	aal1	\N	\N	node	217.131.106.28	\N
b7783291-fa05-4fe1-bacf-56940bd7c192	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-02 11:10:01.98371+00	2025-06-02 11:10:01.98371+00	\N	aal1	\N	\N	node	217.131.106.28	\N
85328d21-70d7-4db2-bb09-2884b12b4696	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-02 11:26:03.800192+00	2025-06-02 11:26:03.800192+00	\N	aal1	\N	\N	node	217.131.106.28	\N
e3b9e3fe-488d-4f03-b49d-9f47c898fb43	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-02 11:44:05.870718+00	2025-06-02 11:44:05.870718+00	\N	aal1	\N	\N	node	217.131.106.28	\N
d9f64ac8-bd0c-41f4-9ded-b5ca2783de62	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-02 13:20:05.966499+00	2025-06-02 13:20:05.966499+00	\N	aal1	\N	\N	node	217.131.106.28	\N
c97fd6e9-460c-4bdf-aa51-3918dbe9bf1b	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-02 13:20:16.918138+00	2025-06-02 13:20:16.918138+00	\N	aal1	\N	\N	node	217.131.106.28	\N
e0e64b51-1e4b-49b5-8ccc-2c99ce65a877	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-02 15:21:42.465565+00	2025-06-02 15:21:42.465565+00	\N	aal1	\N	\N	node	217.131.106.28	\N
3fbb858b-a44c-4150-86cf-3bcbe90df062	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-02 15:22:56.399162+00	2025-06-02 15:22:56.399162+00	\N	aal1	\N	\N	node	217.131.106.28	\N
d92cec79-40ee-423a-85eb-3965c4f35f32	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-02 15:30:25.097276+00	2025-06-02 15:30:25.097276+00	\N	aal1	\N	\N	node	217.131.106.28	\N
95a3a6f2-1760-48f9-bbd7-b9a376403451	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-02 15:37:36.336699+00	2025-06-02 15:37:36.336699+00	\N	aal1	\N	\N	node	217.131.106.28	\N
7e9e393d-f945-4901-9631-b95770225d1d	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-02 15:37:45.481946+00	2025-06-02 15:37:45.481946+00	\N	aal1	\N	\N	node	217.131.106.28	\N
e2613f0b-7b8f-49e1-82fb-2b2d1c6cc12f	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-02 15:42:08.771162+00	2025-06-02 15:42:08.771162+00	\N	aal1	\N	\N	node	217.131.106.28	\N
d6d08e44-e846-4dc7-a1ed-aa98a64f8c92	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-02 15:47:24.485511+00	2025-06-02 15:47:24.485511+00	\N	aal1	\N	\N	node	217.131.106.28	\N
c887c5c6-94c2-4c69-a07a-58311ec8c52b	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-03 09:08:42.94466+00	2025-06-03 09:08:42.94466+00	\N	aal1	\N	\N	node	217.131.106.28	\N
9e9a7501-2462-4bbb-96ac-d8a2a6a46b54	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-03 09:57:16.970032+00	2025-06-03 09:57:16.970032+00	\N	aal1	\N	\N	node	217.131.106.28	\N
01c65b13-7588-4285-af8b-69880e679870	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-03 16:01:48.661282+00	2025-06-03 16:01:48.661282+00	\N	aal1	\N	\N	node	176.30.190.139	\N
385ff898-5a32-4ed7-8277-b17f9d99b032	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-03 17:04:09.742825+00	2025-06-03 17:04:09.742825+00	\N	aal1	\N	\N	node	176.30.190.139	\N
81ee472a-a1e5-4008-96d1-acd2308fdb12	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-03 17:15:27.038095+00	2025-06-03 17:15:27.038095+00	\N	aal1	\N	\N	node	176.30.190.139	\N
fe293b8a-cbc9-4510-90cd-8cf62586808a	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-03 17:44:49.47617+00	2025-06-03 17:44:49.47617+00	\N	aal1	\N	\N	node	176.30.190.139	\N
2bdcb6c7-d8b8-4ab4-8f82-415361ccdf5a	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-05 09:23:00.064552+00	2025-06-05 09:23:00.064552+00	\N	aal1	\N	\N	node	176.89.226.42	\N
effb726b-d217-474e-a49d-00a419ad9207	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-05 09:57:36.205223+00	2025-06-05 09:57:36.205223+00	\N	aal1	\N	\N	node	176.89.226.42	\N
7d34f1d3-85ab-4131-b3e2-df88ec066bd9	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:46:54.210341+00	2025-06-13 18:46:54.210341+00	\N	aal1	\N	\N	node	78.185.204.30	\N
bdbf7dc4-5910-4a3b-8af8-f36a5e5243a0	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-09 12:01:13.544282+00	2025-06-09 13:57:26.569515+00	\N	aal1	\N	2025-06-09 13:57:26.569441	node	78.185.204.30	\N
c01220eb-2743-49b3-b740-c5d28c912006	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-10 13:29:25.467815+00	2025-06-10 13:29:25.467815+00	\N	aal1	\N	\N	node	176.33.66.195	\N
17734dfe-c921-4486-aca9-8510576a165e	e2696184-e809-4108-b08b-ece20065cde3	2025-06-10 13:40:10.116193+00	2025-06-10 13:40:10.116193+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 16_7_11 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.1 Mobile/15E148 Safari/604.1	176.33.66.195	\N
f0250f26-3cd2-4b26-8684-10fde6995742	e2696184-e809-4108-b08b-ece20065cde3	2025-06-10 13:40:18.788655+00	2025-06-10 13:40:18.788655+00	\N	aal1	\N	\N	node	176.33.66.195	\N
935d349b-c7aa-4567-8741-796be4a0ca66	e2696184-e809-4108-b08b-ece20065cde3	2025-06-10 13:41:19.070787+00	2025-06-10 13:41:19.070787+00	\N	aal1	\N	\N	node	176.33.66.195	\N
b49de846-9433-4c1a-82ca-0150975bc794	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-10 13:58:14.062383+00	2025-06-10 13:58:14.062383+00	\N	aal1	\N	\N	node	176.33.66.195	\N
d1713cd0-1f38-4bb4-a5ce-c4efd702e8f1	e2696184-e809-4108-b08b-ece20065cde3	2025-06-10 14:05:08.451746+00	2025-06-10 14:05:08.451746+00	\N	aal1	\N	\N	node	176.33.66.195	\N
cb669d12-a79e-402f-b215-866307389ccc	e2696184-e809-4108-b08b-ece20065cde3	2025-06-10 14:11:36.294036+00	2025-06-10 14:11:36.294036+00	\N	aal1	\N	\N	node	176.33.66.195	\N
c45a27ae-27af-43e6-a09e-2404dbb6a650	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-10 14:16:27.835364+00	2025-06-10 14:16:27.835364+00	\N	aal1	\N	\N	node	176.33.66.195	\N
2ae251f8-dbcd-42bc-aa67-1204a284ce3e	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-10 14:25:00.707016+00	2025-06-10 14:25:00.707016+00	\N	aal1	\N	\N	node	176.33.66.195	\N
812aae94-1821-46a3-a8bb-78ea02c90f4a	e2696184-e809-4108-b08b-ece20065cde3	2025-06-10 14:29:02.262941+00	2025-06-10 14:29:02.262941+00	\N	aal1	\N	\N	node	176.33.66.195	\N
cb9d95c5-c2a7-42d9-abd3-e4da631a957b	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-10 14:29:14.675882+00	2025-06-10 14:29:14.675882+00	\N	aal1	\N	\N	node	176.33.66.195	\N
a7e1a434-fc4a-4d00-8d6c-01b0a04282ce	e2696184-e809-4108-b08b-ece20065cde3	2025-06-10 14:44:21.027361+00	2025-06-10 14:44:21.027361+00	\N	aal1	\N	\N	node	176.33.66.195	\N
1c10072a-a28b-4f3d-b1ea-d7575d2cb5d3	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-10 14:45:50.706994+00	2025-06-10 15:51:16.013944+00	\N	aal1	\N	2025-06-10 15:51:16.013857	node	176.33.67.21	\N
55fafd0e-2833-43fc-b291-55a18752773b	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:49:17.971635+00	2025-06-13 18:49:17.971635+00	\N	aal1	\N	\N	node	78.185.204.30	\N
224d0aad-78df-48d9-ad1f-eb05fa43d1c8	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-10 16:12:53.97294+00	2025-06-10 19:09:07.532084+00	\N	aal1	\N	2025-06-10 19:09:07.532001	node	78.185.204.30	\N
a9959d9d-4918-48d0-8189-e087c821c169	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:23:21.516987+00	2025-06-13 17:23:21.516987+00	\N	aal1	\N	\N	node	78.185.204.30	\N
72662a99-1f9c-4c20-a223-c5a8577bdc4c	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:23:28.983885+00	2025-06-13 17:23:28.983885+00	\N	aal1	\N	\N	node	78.185.204.30	\N
f452ee0f-c15f-4693-9b9e-2fbc5fd35004	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:23:30.497569+00	2025-06-13 17:23:30.497569+00	\N	aal1	\N	\N	node	78.185.204.30	\N
ccee215e-2d0b-44aa-9e24-82f02fb08438	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:37:40.380097+00	2025-06-13 17:37:40.380097+00	\N	aal1	\N	\N	node	78.185.204.30	\N
5ece34d0-9c45-4acd-911f-b2619ff59e8d	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:39:10.393524+00	2025-06-13 17:39:10.393524+00	\N	aal1	\N	\N	node	78.185.204.30	\N
cc3dd629-cb27-48d0-91dd-22b09bda0081	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:47:01.858087+00	2025-06-13 17:47:01.858087+00	\N	aal1	\N	\N	node	78.185.204.30	\N
bdb214a4-d628-4877-b657-2fb1e359b85e	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:47:06.553316+00	2025-06-13 17:47:06.553316+00	\N	aal1	\N	\N	node	78.185.204.30	\N
8551e867-aabf-4b46-8cab-1ff841f3871a	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:47:30.113763+00	2025-06-13 17:47:30.113763+00	\N	aal1	\N	\N	node	78.185.204.30	\N
43775378-ae9c-40eb-931e-28f35d00bb13	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:47:40.775531+00	2025-06-13 17:47:40.775531+00	\N	aal1	\N	\N	node	78.185.204.30	\N
57c205d1-5ffa-4019-a426-215ab12da703	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:48:54.542581+00	2025-06-13 17:48:54.542581+00	\N	aal1	\N	\N	node	78.185.204.30	\N
3a374dcb-e37e-4101-bb4e-256afe70e363	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:50:59.245686+00	2025-06-13 17:50:59.245686+00	\N	aal1	\N	\N	node	78.185.204.30	\N
b0f84562-a15d-4ebb-befb-ce83a21e1434	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:51:50.126857+00	2025-06-13 17:51:50.126857+00	\N	aal1	\N	\N	node	78.185.204.30	\N
87d897f9-f174-4261-af5c-ad175a20565c	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:52:02.723342+00	2025-06-13 17:52:02.723342+00	\N	aal1	\N	\N	node	78.185.204.30	\N
e152e237-e555-47ff-a393-3464a31ce3bb	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:53:27.009546+00	2025-06-13 17:53:27.009546+00	\N	aal1	\N	\N	node	78.185.204.30	\N
8f0c6575-4705-43d7-87be-e3398ec01ef7	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:55:36.202473+00	2025-06-13 17:55:36.202473+00	\N	aal1	\N	\N	node	78.185.204.30	\N
ef2801d2-85ad-4506-9bf0-e231ca8c4023	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:57:04.486838+00	2025-06-13 17:57:04.486838+00	\N	aal1	\N	\N	node	78.185.204.30	\N
afe8f4da-faa4-492e-ba53-0ae415103724	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 17:57:15.253111+00	2025-06-13 17:57:15.253111+00	\N	aal1	\N	\N	node	78.185.204.30	\N
57a5ea36-69ab-486b-bf85-e504fd2f11a6	e2696184-e809-4108-b08b-ece20065cde3	2025-06-13 17:57:19.016131+00	2025-06-13 17:57:19.016131+00	\N	aal1	\N	\N	node	78.185.204.30	\N
d43f6e2c-a583-4bdf-82d6-4747837b6e1a	e2696184-e809-4108-b08b-ece20065cde3	2025-06-13 17:57:29.573443+00	2025-06-13 17:57:29.573443+00	\N	aal1	\N	\N	node	78.185.204.30	\N
32ada9ff-4c9d-4b1c-a29b-bec1619d6c33	e2696184-e809-4108-b08b-ece20065cde3	2025-06-13 18:06:06.395239+00	2025-06-13 18:06:06.395239+00	\N	aal1	\N	\N	node	78.185.204.30	\N
f8e42108-b9a9-4bc6-8584-afa802058543	e2696184-e809-4108-b08b-ece20065cde3	2025-06-13 18:08:51.096303+00	2025-06-13 18:08:51.096303+00	\N	aal1	\N	\N	node	78.185.204.30	\N
f1380e23-e836-46ef-9d0a-b226f735f2a9	e2696184-e809-4108-b08b-ece20065cde3	2025-06-13 18:08:56.507988+00	2025-06-13 18:08:56.507988+00	\N	aal1	\N	\N	node	78.185.204.30	\N
4dd94fab-7bd2-43b1-abf4-2476c9de00ca	e2696184-e809-4108-b08b-ece20065cde3	2025-06-13 18:12:32.470372+00	2025-06-13 18:12:32.470372+00	\N	aal1	\N	\N	node	78.185.204.30	\N
3936b9cd-5d14-4f53-a469-9a17112ceb8b	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:12:37.575868+00	2025-06-13 18:12:37.575868+00	\N	aal1	\N	\N	node	78.185.204.30	\N
5aa15941-bca2-4f9f-a766-e6e135ceae65	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:16:10.734234+00	2025-06-13 18:16:10.734234+00	\N	aal1	\N	\N	node	78.185.204.30	\N
395af682-fc4a-47b2-90ae-e6a78978c700	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:16:29.550462+00	2025-06-13 18:16:29.550462+00	\N	aal1	\N	\N	node	78.185.204.30	\N
b52e369a-1b2d-4781-8e10-0cb2e0771039	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:17:58.882505+00	2025-06-13 18:17:58.882505+00	\N	aal1	\N	\N	node	78.185.204.30	\N
7e782e1e-2b92-44bc-8542-1e723affb206	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:18:13.756251+00	2025-06-13 18:18:13.756251+00	\N	aal1	\N	\N	node	78.185.204.30	\N
40655390-2af8-410c-a41c-50dc154487f2	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:20:33.289476+00	2025-06-13 18:20:33.289476+00	\N	aal1	\N	\N	node	78.185.204.30	\N
832e1267-8689-43fb-8707-31a85a4ec0ee	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:20:43.600819+00	2025-06-13 18:20:43.600819+00	\N	aal1	\N	\N	node	78.185.204.30	\N
e3de2713-a908-4f1c-9e85-58da53281b41	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:22:55.148795+00	2025-06-13 18:22:55.148795+00	\N	aal1	\N	\N	node	78.185.204.30	\N
c16b4cea-147e-4ccc-aa8d-2f0474d16811	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:23:06.835556+00	2025-06-13 18:23:06.835556+00	\N	aal1	\N	\N	node	78.185.204.30	\N
c59bad02-323e-4810-97bb-2afe732b698f	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:24:19.965877+00	2025-06-13 18:24:19.965877+00	\N	aal1	\N	\N	node	78.185.204.30	\N
baba198b-f2be-43f8-98f4-d09bba604c20	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:24:32.501635+00	2025-06-13 18:24:32.501635+00	\N	aal1	\N	\N	node	78.185.204.30	\N
69df712f-b1ef-45b4-bc09-71825e8b9e75	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:25:51.197531+00	2025-06-13 18:25:51.197531+00	\N	aal1	\N	\N	node	78.185.204.30	\N
fc3a81d0-9926-4cf6-b342-31f2f16e604e	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:34:42.607251+00	2025-06-13 18:34:42.607251+00	\N	aal1	\N	\N	node	78.185.204.30	\N
9a62d7ac-70cb-44ac-8b28-f64230d1994b	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:36:07.033789+00	2025-06-13 18:36:07.033789+00	\N	aal1	\N	\N	node	78.185.204.30	\N
b60b6b86-1243-4e5c-b1e5-e79f3c40e4a3	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:38:56.0836+00	2025-06-13 18:38:56.0836+00	\N	aal1	\N	\N	node	78.185.204.30	\N
85340914-2c4e-4fca-821d-4ef310073811	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:39:23.046458+00	2025-06-13 18:39:23.046458+00	\N	aal1	\N	\N	node	78.185.204.30	\N
26435738-4945-498e-b402-323de3f4d1d1	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:41:27.24705+00	2025-06-13 18:41:27.24705+00	\N	aal1	\N	\N	node	78.185.204.30	\N
574fa09f-8daf-47fe-bb65-7c8bceff0b67	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:41:37.969579+00	2025-06-13 18:41:37.969579+00	\N	aal1	\N	\N	node	78.185.204.30	\N
a42432b2-200f-4115-b021-060281ca4b8f	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:43:40.439332+00	2025-06-13 18:43:40.439332+00	\N	aal1	\N	\N	node	78.185.204.30	\N
0f9919d1-2cb0-41db-8cd7-014810751b22	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:43:49.313931+00	2025-06-13 18:43:49.313931+00	\N	aal1	\N	\N	node	78.185.204.30	\N
21e426cb-13bc-401a-86c1-514bc43deb8b	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:43:54.239253+00	2025-06-13 18:43:54.239253+00	\N	aal1	\N	\N	node	78.185.204.30	\N
4d0abd7a-521c-4d28-8ec2-eda65edc43f3	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:44:07.501262+00	2025-06-13 18:44:07.501262+00	\N	aal1	\N	\N	node	78.185.204.30	\N
94c2dda4-b0be-463d-b188-38566b891ea7	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:45:31.570321+00	2025-06-13 18:45:31.570321+00	\N	aal1	\N	\N	node	78.185.204.30	\N
66e2bbca-68bc-4f30-83f9-f6056829cf50	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:45:36.727846+00	2025-06-13 18:45:36.727846+00	\N	aal1	\N	\N	node	78.185.204.30	\N
f9cc77dd-f687-4d47-b4e3-1905edb05748	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:49:24.329548+00	2025-06-13 18:49:24.329548+00	\N	aal1	\N	\N	node	78.185.204.30	\N
0ac9421c-06f2-4a0c-b953-440c79f17a3a	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 18:50:37.81261+00	2025-06-13 18:50:37.81261+00	\N	aal1	\N	\N	node	78.185.204.30	\N
d974988f-6f87-448a-957c-5b9fb870e97d	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 19:28:26.947128+00	2025-06-13 19:28:26.947128+00	\N	aal1	\N	\N	node	78.185.204.30	\N
768be3f0-ac83-479d-9217-5af29f4bae16	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 19:31:19.474014+00	2025-06-13 19:31:19.474014+00	\N	aal1	\N	\N	node	78.185.204.30	\N
a3d4999d-5849-4b40-b671-109cabe28f3c	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 19:31:26.313839+00	2025-06-13 19:31:26.313839+00	\N	aal1	\N	\N	node	78.185.204.30	\N
d05ededb-b83c-4be7-93aa-c08b42f2d3ed	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 19:33:29.52294+00	2025-06-13 19:33:29.52294+00	\N	aal1	\N	\N	node	78.185.204.30	\N
b305c3e7-b76f-4278-9bba-c732a4e4425b	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 19:34:15.200752+00	2025-06-13 19:34:15.200752+00	\N	aal1	\N	\N	node	78.185.204.30	\N
3ffda28e-fb0c-4e5c-b340-2bb31485f90c	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 20:33:03.552344+00	2025-06-13 20:33:03.552344+00	\N	aal1	\N	\N	node	78.185.204.30	\N
ce4f9220-6ddd-40e4-adaa-e6ff6456380c	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 20:33:10.332858+00	2025-06-13 20:33:10.332858+00	\N	aal1	\N	\N	node	78.185.204.30	\N
12d1ebdc-a6e9-4f76-b812-e105bc7dbfd7	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 20:36:37.799183+00	2025-06-13 20:36:37.799183+00	\N	aal1	\N	\N	node	78.185.204.30	\N
1b4eda20-9717-42a6-88da-76a7260942a9	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 20:40:59.249064+00	2025-06-13 20:40:59.249064+00	\N	aal1	\N	\N	node	78.185.204.30	\N
96e80344-f4d7-410f-aebf-8f430f04ec36	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 20:47:18.853915+00	2025-06-13 20:47:18.853915+00	\N	aal1	\N	\N	node	78.185.204.30	\N
d1079952-4303-4c11-af0d-4e418e7bb6b7	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 20:49:53.560181+00	2025-06-13 20:49:53.560181+00	\N	aal1	\N	\N	node	78.185.204.30	\N
9ab90fb8-f005-4e3b-933c-aa8c38eb943a	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 20:50:57.479506+00	2025-06-13 20:50:57.479506+00	\N	aal1	\N	\N	node	78.185.204.30	\N
61956de8-ee8c-4857-985c-ed7c5c2e966e	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 20:58:53.756152+00	2025-06-13 20:58:53.756152+00	\N	aal1	\N	\N	node	78.185.204.30	\N
ce3342cb-166b-40a9-90b1-b104fe3f1216	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 21:14:03.562594+00	2025-06-13 21:14:03.562594+00	\N	aal1	\N	\N	node	78.185.204.30	\N
6aa8fe10-742a-45c7-b222-716c5790e41e	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 21:18:37.898623+00	2025-06-13 21:18:37.898623+00	\N	aal1	\N	\N	node	78.185.204.30	\N
4b0e7106-e059-4402-be60-f5c9c7e2dff1	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 21:24:11.956647+00	2025-06-13 21:24:11.956647+00	\N	aal1	\N	\N	node	78.185.204.30	\N
3c230eff-8f4b-4e22-9bdc-7deacd8ea466	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 21:37:11.966343+00	2025-06-13 21:37:11.966343+00	\N	aal1	\N	\N	node	78.185.204.30	\N
aa634547-abc6-46ce-8ef2-d776bc654fd7	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 21:37:12.333025+00	2025-06-13 21:37:12.333025+00	\N	aal1	\N	\N	node	78.185.204.30	\N
512fda62-f162-4093-95a1-e4aaecb4c50f	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-13 21:54:27.592277+00	2025-06-13 21:54:27.592277+00	\N	aal1	\N	\N	node	78.185.204.30	\N
d82d7328-233e-4675-8386-3b916c7efa37	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-13 21:56:16.722175+00	2025-06-13 21:56:16.722175+00	\N	aal1	\N	\N	node	78.185.204.30	\N
df92cea2-78cd-4c3e-bed1-7c9df8c9d7be	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-14 13:36:05.965302+00	2025-06-14 13:36:05.965302+00	\N	aal1	\N	\N	node	178.244.133.70	\N
cffd461e-102b-4947-a530-3d553926417f	e2696184-e809-4108-b08b-ece20065cde3	2025-06-14 13:36:44.722386+00	2025-06-14 13:36:44.722386+00	\N	aal1	\N	\N	node	178.244.133.70	\N
35fd2080-7138-4430-9300-dd7b3e0e1952	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-14 13:36:59.628541+00	2025-06-14 13:36:59.628541+00	\N	aal1	\N	\N	node	178.244.133.70	\N
bb1a1585-803c-4e12-8e06-82097ce3b19f	e2696184-e809-4108-b08b-ece20065cde3	2025-06-14 13:37:46.868865+00	2025-06-14 13:37:46.868865+00	\N	aal1	\N	\N	node	178.244.133.70	\N
0e7e9fee-7bed-4fc1-8f8c-000c1ef997f9	e2696184-e809-4108-b08b-ece20065cde3	2025-06-14 13:51:35.529779+00	2025-06-14 13:51:35.529779+00	\N	aal1	\N	\N	node	178.244.133.70	\N
b82955c4-4a7c-4746-9918-3c37bcbb42d1	e2696184-e809-4108-b08b-ece20065cde3	2025-06-14 13:53:36.331404+00	2025-06-14 13:53:36.331404+00	\N	aal1	\N	\N	node	178.244.133.70	\N
0da91356-03ab-4b4d-a5f7-c72c32e35012	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-16 13:31:48.782429+00	2025-06-16 13:31:48.782429+00	\N	aal1	\N	\N	node	176.33.65.118	\N
e90c0908-78be-4eb6-8dda-10bac673f8b7	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-16 13:33:50.822553+00	2025-06-16 13:33:50.822553+00	\N	aal1	\N	\N	node	176.33.65.118	\N
ea1f7f48-8983-4071-bac2-61fc13015ad4	bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	2025-06-16 13:44:41.896963+00	2025-06-16 13:44:41.896963+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 17_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Mobile/15E148 Safari/604.1	176.33.65.118	\N
d08d3d75-3785-499a-838a-81a2c0f7f0bc	bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	2025-06-16 13:45:42.314214+00	2025-06-16 13:45:42.314214+00	\N	aal1	\N	\N	node	176.33.65.118	\N
f8dca749-bc5f-40b7-ace8-daa72dd301cc	bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	2025-06-16 13:45:52.962057+00	2025-06-16 13:45:52.962057+00	\N	aal1	\N	\N	node	176.33.65.118	\N
27e14048-4194-41b1-b78c-65ada6d55ff1	bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	2025-06-16 13:46:19.889198+00	2025-06-16 13:46:19.889198+00	\N	aal1	\N	\N	node	176.33.65.118	\N
f19d4fb4-ecbe-4fa9-a681-6ead8c59f993	fd9ce997-3b05-471e-9d87-1f82688b9d97	2025-06-16 15:22:40.021198+00	2025-06-16 15:22:40.021198+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/137.0.7151.107 Mobile/15E148 Safari/604.1	176.33.65.118	\N
7795aed5-1e5a-441c-9d81-fe6638178517	fd9ce997-3b05-471e-9d87-1f82688b9d97	2025-06-16 15:23:23.271829+00	2025-06-16 15:23:23.271829+00	\N	aal1	\N	\N	node	176.33.65.118	\N
a1213af3-d174-4bb2-af90-f0c4f112628a	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-16 15:25:13.428482+00	2025-06-16 15:25:13.428482+00	\N	aal1	\N	\N	node	176.33.65.118	\N
c6f65703-1237-4510-adfb-f3506a31a35e	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-17 13:35:22.274538+00	2025-06-17 13:35:22.274538+00	\N	aal1	\N	\N	node	176.89.153.214	\N
bb7c5d5d-c035-4310-ac9a-3a97586c34a5	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-17 13:35:50.411718+00	2025-06-17 13:35:50.411718+00	\N	aal1	\N	\N	node	176.89.153.214	\N
87039e32-7e21-40a5-b330-4cf1998f37fa	e2696184-e809-4108-b08b-ece20065cde3	2025-06-17 15:02:05.372364+00	2025-06-17 15:02:05.372364+00	\N	aal1	\N	\N	node	176.89.153.214	\N
d51e22c1-8633-41b2-8417-1604eb4d1b76	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-17 15:02:12.687075+00	2025-06-17 15:02:12.687075+00	\N	aal1	\N	\N	node	176.89.153.214	\N
a2137bc3-3e4c-4183-9ad5-aafc5927c275	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-17 15:02:22.240408+00	2025-06-17 15:02:22.240408+00	\N	aal1	\N	\N	node	176.89.153.214	\N
9568fdb6-9de5-4bea-aff7-39cfd275a827	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-17 15:18:17.108971+00	2025-06-17 15:18:17.108971+00	\N	aal1	\N	\N	node	195.49.219.236	\N
cfc77c50-7648-4bfe-acc0-5699a03415ff	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-17 15:19:04.306761+00	2025-06-17 15:19:04.306761+00	\N	aal1	\N	\N	node	195.49.219.236	\N
059ee39f-ec24-40b8-9c72-722b449d8e08	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-17 15:24:02.896619+00	2025-06-17 15:24:02.896619+00	\N	aal1	\N	\N	node	195.49.219.236	\N
5a43643b-887b-4cca-8e14-259dddb62f7d	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-17 15:25:49.948501+00	2025-06-17 15:25:49.948501+00	\N	aal1	\N	\N	node	176.89.153.214	\N
da099d3e-bfb8-4577-a728-f60a462665c9	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-17 15:26:04.433669+00	2025-06-17 15:26:04.433669+00	\N	aal1	\N	\N	node	176.89.153.214	\N
e8b98818-9c9c-4836-a547-d6931c71b1f8	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-17 15:26:09.903683+00	2025-06-17 15:26:09.903683+00	\N	aal1	\N	\N	node	176.89.153.214	\N
5d52b593-e4e1-4a1d-8434-371df3bf1119	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-17 15:30:26.53967+00	2025-06-17 15:30:26.53967+00	\N	aal1	\N	\N	node	176.89.153.214	\N
0dceef46-9d54-4672-b8ea-31e7d6846fff	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-17 15:30:37.155985+00	2025-06-17 15:30:37.155985+00	\N	aal1	\N	\N	node	176.89.153.214	\N
e48814df-b82d-4f85-9e10-d7225821629e	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-17 17:36:10.727979+00	2025-06-17 17:36:10.727979+00	\N	aal1	\N	\N	node	176.33.69.222	\N
c9fe46df-ce27-40a1-bb34-039ce0630e57	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-17 17:37:35.304396+00	2025-06-17 17:37:35.304396+00	\N	aal1	\N	\N	node	176.33.69.222	\N
3fbd17e1-2c70-4f32-a691-bc196948e3c7	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-19 11:52:38.119544+00	2025-06-19 11:52:38.119544+00	\N	aal1	\N	\N	node	78.185.204.30	\N
67634db9-803e-4805-8dd4-e96277e8c9cd	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-19 11:52:46.503905+00	2025-06-19 11:52:46.503905+00	\N	aal1	\N	\N	node	78.185.204.30	\N
2e27d7c8-dcf3-4ee7-8d44-7cd0b710c65a	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-19 11:54:56.300036+00	2025-06-19 11:54:56.300036+00	\N	aal1	\N	\N	node	78.185.204.30	\N
e14fa4e0-e176-4eff-8b5d-66b6b0f4b361	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-19 12:00:16.993767+00	2025-06-19 12:00:16.993767+00	\N	aal1	\N	\N	node	78.185.204.30	\N
9dce2de9-4d71-4c6d-881c-1ea3debd6bfa	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-19 12:01:04.994759+00	2025-06-19 12:01:04.994759+00	\N	aal1	\N	\N	node	78.185.204.30	\N
ba3b4bdd-fd32-425b-969c-538a40577d7d	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-19 12:03:46.482513+00	2025-06-19 12:03:46.482513+00	\N	aal1	\N	\N	node	78.185.204.30	\N
da1ed432-a569-4cf5-9800-73348f59e446	8211960d-7c4c-4fc3-9816-370d52dda6c8	2025-06-19 12:04:56.310953+00	2025-06-19 12:04:56.310953+00	\N	aal1	\N	\N	node	78.185.204.30	\N
82020d94-74fd-4919-9d58-9d6ee7e718f7	589ba55a-f5c6-4880-b814-b23632e637a4	2025-06-19 12:06:51.765185+00	2025-06-19 12:06:51.765185+00	\N	aal1	\N	\N	node	78.185.204.30	\N
\.


--
-- TOC entry 4025 (class 0 OID 16821)
-- Dependencies: 287
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4024 (class 0 OID 16812)
-- Dependencies: 286
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4010 (class 0 OID 16489)
-- Dependencies: 269
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	8211960d-7c4c-4fc3-9816-370d52dda6c8	authenticated	authenticated	hsngrbz7106@gmail.com	$2a$10$AiTCPONVpALrmWT9kqgnW.NP1pdtlgwWdKLwCh9LSJLtstxP5pK8e	2025-05-30 14:26:14.536505+00	\N		2025-05-30 14:24:19.788741+00		\N			\N	2025-06-19 12:04:56.31088+00	{"provider": "email", "providers": ["email"]}	{"sub": "8211960d-7c4c-4fc3-9816-370d52dda6c8", "email": "hsngrbz7106@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-05-30 14:24:19.77701+00	2025-06-19 12:04:56.313487+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c52985ac-c3c0-4555-ae52-3c1486f814f0	authenticated	authenticated	testuser@gmail.com	$2a$10$lTqBukJ99v9WgaQ0M7Xy3epezZ1I/uO2WlpEQK6IiCfQZ9PIoFu1K	\N	\N	098be004d745fb731d8c71b61b4706a7ef35d4d9f501bfd7b838a06c	2025-06-01 14:37:45.35633+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "c52985ac-c3c0-4555-ae52-3c1486f814f0", "email": "testuser@gmail.com", "email_verified": false, "phone_verified": false}	\N	2025-06-01 14:37:45.350346+00	2025-06-01 14:37:46.170062+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e2696184-e809-4108-b08b-ece20065cde3	authenticated	authenticated	efesecen@hotmail.com	$2a$10$Df4epN6Y1qUHSKk8RlHBa.UiF0In8VdpOlza.E9A.upe4N/Dse6ky	2025-06-10 13:40:10.106747+00	\N		2025-06-10 13:38:10.409939+00		\N			\N	2025-06-17 15:02:05.372276+00	{"provider": "email", "providers": ["email"]}	{"sub": "e2696184-e809-4108-b08b-ece20065cde3", "email": "efesecen@hotmail.com", "email_verified": true, "phone_verified": false}	\N	2025-06-10 13:38:10.371706+00	2025-06-17 15:02:05.383224+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	589ba55a-f5c6-4880-b814-b23632e637a4	authenticated	authenticated	hasangurbuzc@gmail.com	$2a$10$tgPHX0iJFXFKWDZeQ4ijz.Xqi67.oYPLAzk7E7LRjzo.SmT6A2.yK	2025-05-30 15:27:46.299905+00	\N		2025-05-30 15:27:31.704894+00		\N			\N	2025-06-19 12:06:51.76511+00	{"provider": "email", "providers": ["email"]}	{"sub": "589ba55a-f5c6-4880-b814-b23632e637a4", "email": "hasangurbuzc@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-05-30 15:27:31.691382+00	2025-06-19 12:06:51.778959+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	authenticated	authenticated	eren-omur@hotmail.com	$2a$10$eiRGD9k5tqTMoC5MRRKKeuVyBBa6Mg9pLmrWaIWBd4FoX4ORi/7I6	2025-06-16 13:44:41.890129+00	\N		2025-06-16 13:43:19.309061+00		\N			\N	2025-06-16 13:46:19.889119+00	{"provider": "email", "providers": ["email"]}	{"sub": "bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c", "email": "eren-omur@hotmail.com", "email_verified": true, "phone_verified": false}	\N	2025-06-16 13:41:46.514524+00	2025-06-16 13:46:19.890852+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a25826c2-495d-4234-8e20-97d97f4db18e	authenticated	authenticated	alperyigit88@gmail.com	$2a$10$EsM0pVF.Fl0DUNMdR0rV6Oma8kXHpHLxamvqOIq5blyWGF.3l0fH2	2025-05-26 12:48:34.614366+00	\N		2025-05-26 12:48:12.058783+00		\N			\N	2025-05-29 17:03:51.73579+00	{"provider": "email", "providers": ["email"]}	{"sub": "a25826c2-495d-4234-8e20-97d97f4db18e", "email": "alperyigit88@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-05-26 12:48:11.997937+00	2025-05-30 13:32:36.603942+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	fd9ce997-3b05-471e-9d87-1f82688b9d97	authenticated	authenticated	iremkivraak2003@gmail.com	$2a$10$XXKHzsrBz.YTVTUoBl2GjuGDCFE/TAqKnahcbxPd3Ak6mBKim2mwi	2025-06-16 15:22:40.010258+00	\N		2025-06-16 15:22:23.149781+00		\N			\N	2025-06-16 15:23:23.271763+00	{"provider": "email", "providers": ["email"]}	{"sub": "fd9ce997-3b05-471e-9d87-1f82688b9d97", "email": "iremkivraak2003@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-06-16 15:22:23.11216+00	2025-06-16 15:23:23.276033+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- TOC entry 4035 (class 0 OID 18373)
-- Dependencies: 301
-- Data for Name: coupon_usages; Type: TABLE DATA; Schema: cupons; Owner: postgres
--

COPY cupons.coupon_usages (coupon_usages_id, user_id, order_id, used_date, coupons_id) FROM stdin;
\.


--
-- TOC entry 4036 (class 0 OID 18376)
-- Dependencies: 302
-- Data for Name: coupons; Type: TABLE DATA; Schema: cupons; Owner: postgres
--

COPY cupons.coupons (coupon_id, coupon_code, description, discount_type, discount_value, min_order_value, max_uses, uses_count, valid_from, valid_until, is_active) FROM stdin;
\.


--
-- TOC entry 4037 (class 0 OID 18384)
-- Dependencies: 303
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cards (user_id, card_id, user_card_name, user_card_number, user_card_ending_date, user_card_code) FROM stdin;
10	2	MERT ÇAKIR 	5646 4646 5655 6465	12/28	311
\.


--
-- TOC entry 4038 (class 0 OID 18389)
-- Dependencies: 304
-- Data for Name: delivery_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.delivery_address (user_id, user_address_id, city, neighborhood, street, floor, apartment, full_address, district, "userUserId") FROM stdin;
4	11	İstanbul	Semsipaşa 	15.sokak	26	7	Semsipaşa  Mah., 15.sokak No:7, Kat:26, Gop/İstanbul	Gop	\N
10	15	İstanbul 	Semsipaşa 	19	3	5	Semsipaşa  Mah., 19 No:5, Kat:3, Gop/İstanbul 	Gop	\N
11	16	Ankara	Beyazıt	Hançer sokak	8	7	Beyazıt Mah., Hançer sokak No:7, Kat:8, Akyurt/Ankara	Akyurt	\N
4	6	İstanbul	Caferağa	Örnek Sokak	3	5A	Örnek Adres Caddesi No:14	Kadıköy	\N
\.


--
-- TOC entry 4039 (class 0 OID 18394)
-- Dependencies: 305
-- Data for Name: farmer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.farmer (farmer_id, farmer_password, farmer_name, farmer_last_name, farmer_age, farmer_address, farmer_city, farmer_town, farmer_neighbourhood, farmer_phone_number, farmer_mail, farm_name, farmer_tc_no, farmer_biografi, auth_id, img_url, farmer_activity_status, farmer_store_activity) FROM stdin;
29	123456	Hasan	Gurbuz	16	istanbu/ataşehir inönü mahallesi	İSTANBUL	Ataşehir	şişli	05383042540	alperyigit88@gmail.com	alper farm	12312345123	\N	a25826c2-495d-4234-8e20-97d97f4db18e	\N	Active	active
49	123456789	Test	User	30	Test Address	Test City	Test Town	Test Neighbourhood	1234567890	testuser@gmail.com	Test Farm	12345678901	\N	c52985ac-c3c0-4555-ae52-3c1486f814f0	\N	Active	active
50	Efesçn	Efe	Seçen	22	Yeditepe üni erkek yurdu	İSTANBUL	Ataşehir	inönü	05537748606	efesecen@hotmail.com	Seçen Farm	12312345123	\N	e2696184-e809-4108-b08b-ece20065cde3	\N	Active	active
51	12345678	Eren	ömür	23	aydınevler mahallesi seren sokak bina no 5 daire no 1	İSTANBUL	Maltepe	Aydınevler	05537366687	eren-omur@hotmail.com	Ömür Çiftlik	4567834567	ömür çiftliğe hogeldin	bb6ec5e5-7877-40d5-9d9a-68c83fcbf67c	\N	Active	active
52	irem123	irem	kıvrak	22	Umurça mahallesi ocak sokak 11	muğla	bodrum	umurça	05535503233	iremkivraak2003@gmail.com	kıvraklar tarım	12727727272	bodrumda doğal üretici	fd9ce997-3b05-471e-9d87-1f82688b9d97	\N	Active	active
46	1234567	Hasan	Gurbuz	22	Kayışdağı mahallesi mansur sokak bina no/59 daire no 7	İSTANBUL	İSTANBUL	şeyhler	05383042540	hsngrbz7106@gmail.com	gürbüz farm	12312312312	Merhaba çiftliğimize hoş geldiniz	8211960d-7c4c-4fc3-9816-370d52dda6c8	\N	Active	active
47	1234567	Hasan	Gurbuz	22	istanbu/ataşehir inönü mahallesi	İSTANBUL	Ataşehir	inönü	05383042540	hasangurbuzc@gmail.com	as çiftlik	12345123451	Merhaba bu benim çiftliğim	589ba55a-f5c6-4880-b814-b23632e637a4	\N	Active	active
\.


--
-- TOC entry 4053 (class 0 OID 57027)
-- Dependencies: 319
-- Data for Name: farmer_certificate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.farmer_certificate (id, farmer_id, images) FROM stdin;
6	29	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-documents/29/sertifika.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5Xzk4ODM5Mjg2LTFmMDgtNGJlNC1hNzY1LTdkZTBmNzI1NTlmNyJ9.eyJ1cmwiOiJmYXJtZXItZG9jdW1lbnRzLzI5L3NlcnRpZmlrYS5wbmciLCJpYXQiOjE3NDgyNjM2OTMsImV4cCI6MjA2MzYyMzY5M30.tecZNrnJaWjHc7-I18mgk4AVpl7GhTCegb8Qv9ECY3o
15	46	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-documents/46/sertifika-1748812301686-1.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5Xzk4ODM5Mjg2LTFmMDgtNGJlNC1hNzY1LTdkZTBmNzI1NTlmNyJ9.eyJ1cmwiOiJmYXJtZXItZG9jdW1lbnRzLzQ2L3NlcnRpZmlrYS0xNzQ4ODEyMzAxNjg2LTEucG5nIiwiaWF0IjoxNzQ4ODEyMzAzLCJleHAiOjMzMjU2MTIzMDN9.yl3bPllhNbctMVlSswqhYUkDkUE2hb6uuTUjoloQAA8
16	47	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-documents/47/sertifika-1748860162072-0.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItZG9jdW1lbnRzLzQ3L3NlcnRpZmlrYS0xNzQ4ODYwMTYyMDcyLTAucG5nIiwiaWF0IjoxNzQ4ODYwMTYzLCJleHAiOjMzMjU2NjAxNjN9.tUgTEKCoRePAeXjzk7YGqhwiW4E7DhTZt0dR1ay9zuM
17	47	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-documents/47/sertifika-1748860163302-1.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItZG9jdW1lbnRzLzQ3L3NlcnRpZmlrYS0xNzQ4ODYwMTYzMzAyLTEucG5nIiwiaWF0IjoxNzQ4ODYwMTY1LCJleHAiOjMzMjU2NjAxNjV9.DQOtYEiHRomge7KQCchRFMlVk-D9KLqPkqMYPR3-ppc
19	46	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-documents/46/sertifika-1748879004321-0.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItZG9jdW1lbnRzLzQ2L3NlcnRpZmlrYS0xNzQ4ODc5MDA0MzIxLTAucG5nIiwiaWF0IjoxNzQ4ODc5MDA4LCJleHAiOjMzMjU2NzkwMDh9.XuJ23DXH6zIWuUXUrmAEiHuj56ntGAT81GEbXmrN-xI
20	51	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-documents/51/sertifika.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItZG9jdW1lbnRzLzUxL3NlcnRpZmlrYS5wbmciLCJpYXQiOjE3NTAwODE0MDAsImV4cCI6MjA2NTQ0MTQwMH0.mpOrK9l-V1jBxfNOSPhKOum9wgq19_2y4VvbVDH2xoM
21	51	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-documents/51/sertifika-1750081638382-0.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItZG9jdW1lbnRzLzUxL3NlcnRpZmlrYS0xNzUwMDgxNjM4MzgyLTAucG5nIiwiaWF0IjoxNzUwMDgxNjM5LCJleHAiOjMzMjY4ODE2Mzl9.8NQoSQC4TiWFDBaHEnpkWfxZc57yEZaR5k7At-TjSe8
22	51	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-documents/51/sertifika-1750081641420-0.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItZG9jdW1lbnRzLzUxL3NlcnRpZmlrYS0xNzUwMDgxNjQxNDIwLTAucG5nIiwiaWF0IjoxNzUwMDgxNjQyLCJleHAiOjMzMjY4ODE2NDJ9.z4CuFLHR4oHUt07hy0zRBOpwWUJRnRiiSEimsfPHy5c
23	52	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-documents/52/sertifika.pdf?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItZG9jdW1lbnRzLzUyL3NlcnRpZmlrYS5wZGYiLCJpYXQiOjE3NTAwODczNDUsImV4cCI6MjA2NTQ0NzM0NX0.hTGsSNhvqUWxdPeWAS5cWoV3Gk_pXsausbzaRIVlpQM
24	52	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-documents/52/sertifika-1750087494278-0.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItZG9jdW1lbnRzLzUyL3NlcnRpZmlrYS0xNzUwMDg3NDk0Mjc4LTAucG5nIiwiaWF0IjoxNzUwMDg3NDk3LCJleHAiOjMzMjY4ODc0OTd9.q-in8z9IFyNz6hLel1VpjO-y3EyNXfDB_I85s4KylrA
\.


--
-- TOC entry 4051 (class 0 OID 57016)
-- Dependencies: 317
-- Data for Name: farmer_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.farmer_images (id, farmer_id, farmer_image) FROM stdin;
6	46	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-images/46/1748812297175-0.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5Xzk4ODM5Mjg2LTFmMDgtNGJlNC1hNzY1LTdkZTBmNzI1NTlmNyJ9.eyJ1cmwiOiJmYXJtZXItaW1hZ2VzLzQ2LzE3NDg4MTIyOTcxNzUtMC5qcGciLCJpYXQiOjE3NDg4MTIyOTcsImV4cCI6MzMyNTYxMjI5N30.tjXevtmhWi8ABestdAtJhZiY-HIS_3PgWQbZsSLPVuw
8	46	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-images/46/1748812775843-0.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5Xzk4ODM5Mjg2LTFmMDgtNGJlNC1hNzY1LTdkZTBmNzI1NTlmNyJ9.eyJ1cmwiOiJmYXJtZXItaW1hZ2VzLzQ2LzE3NDg4MTI3NzU4NDMtMC5qcGciLCJpYXQiOjE3NDg4MTI3NzYsImV4cCI6MzMyNTYxMjc3Nn0.fqKVCPjbB1h8i1JvOGMablqZFLDmhXnWi-gIKPDlBeE
9	47	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-images/47/1748860160785-0.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItaW1hZ2VzLzQ3LzE3NDg4NjAxNjA3ODUtMC5qcGciLCJpYXQiOjE3NDg4NjAxNjEsImV4cCI6MzMyNTY2MDE2MX0.MzWjEFoJb_RXZLQIjU6NA6P7El82DlcCaJP4WiEbFKE
10	47	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-images/47/1748860161382-1.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItaW1hZ2VzLzQ3LzE3NDg4NjAxNjEzODItMS5qcGciLCJpYXQiOjE3NDg4NjAxNjEsImV4cCI6MzMyNTY2MDE2MX0.vwVSQqyHBDKtQ-rVLIKgWq_kJ2GcjBT_IaDO0mf6oxc
11	51	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-images/51/1750081635881-0.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItaW1hZ2VzLzUxLzE3NTAwODE2MzU4ODEtMC5wbmciLCJpYXQiOjE3NTAwODE2MzcsImV4cCI6MzMyNjg4MTYzN30.xYKYCTjnSLxgTex6sjW6Dh9Y0lSPh2-EqFIfEX0k8tE
12	51	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-images/51/1750081637519-1.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItaW1hZ2VzLzUxLzE3NTAwODE2Mzc1MTktMS5qcGciLCJpYXQiOjE3NTAwODE2MzgsImV4cCI6MzMyNjg4MTYzOH0.kkGlKkT8LRkmnuweMCSL__3lGWlGW2ZOCnbLZpF905c
15	52	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-images/52/1750087491048-0.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItaW1hZ2VzLzUyLzE3NTAwODc0OTEwNDgtMC5wbmciLCJpYXQiOjE3NTAwODc0OTMsImV4cCI6MzMyNjg4NzQ5M30.qs7aLDF34ZlenyS3gTjQZ0g3VasS1HtBgquN7O4VczQ
16	52	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/farmer-images/52/1750087493137-1.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJmYXJtZXItaW1hZ2VzLzUyLzE3NTAwODc0OTMxMzctMS5qcGciLCJpYXQiOjE3NTAwODc0OTMsImV4cCI6MzMyNjg4NzQ5M30.QL-DT5M1r3j7--BWGt30-wo4_Ae2tBS0wO3KmQXiSZA
\.


--
-- TOC entry 4056 (class 0 OID 67626)
-- Dependencies: 322
-- Data for Name: farmer_product_income; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.farmer_product_income (id, order_prduct_id, product_id, farmer_id, farmer_name, product_name, product_quantity, product_income, created_at) FROM stdin;
1	3	46f1f768-db28-450d-9217-42073cc6b3d0	46	Hasan	Karpuz	40	500	2025-06-03 16:41:16.175424+00
2	7	42067206-de49-4b97-8008-c2fedd8b5248	46	Hasan	Kavun	20	500	2025-06-03 17:06:03.729+00
3	8	42067206-de49-4b97-8008-c2fedd8b5248	46	Hasan	Kavun	49	1175	2025-06-03 17:08:36.82+00
4	2	a6871afe-b121-45fb-8969-38661cf1d9f2	47	Hasan	Çilek	50	1000	2025-06-03 17:15:37.55+00
5	9	78a96f2b-9f0e-4516-92c1-9f90cd7fe76c	47	Hasan	Karnıbahar	40	800	2025-06-03 17:43:48.114+00
6	7	42067206-de49-4b97-8008-c2fedd8b5248	46	Hasan	Kavun	20	500	2025-06-13 21:06:29.521+00
7	100	a6871afe-b121-45fb-8969-38661cf1d9f2	46	Hasan Gürbüz	Taze Çilek	3	45	2025-06-13 21:06:36.725+00
8	302	a6871afe-b121-45fb-8969-38661cf1d9f2	46	Hasan Gürbüz	Taze Çilek	2	40	2025-06-13 21:06:42.136+00
9	9	78a96f2b-9f0e-4516-92c1-9f90cd7fe76c	47	Hasan	Karnıbahar	40	800	2025-06-13 21:58:15.49+00
10	6	78a96f2b-9f0e-4516-92c1-9f90cd7fe76c	47	Farmer servisinden çekilecek	Karnıbahar	10	200	2025-06-13 21:58:18.895+00
11	1	46f1f768-db28-450d-9217-42073cc6b3d0	47	Farmer servisinden çekilecek	Karpuz	10	200	2025-06-13 21:58:23.119+00
12	2	a6871afe-b121-45fb-8969-38661cf1d9f2	47	Hasan	Çilek	50	1000	2025-06-13 21:58:25.421+00
13	301	a6871afe-b121-45fb-8969-38661cf1d9f2	46	Hasan Gürbüz	Taze Çilek	3	45	2025-06-14 13:37:11.487+00
14	300	a6871afe-b121-45fb-8969-38661cf1d9f2	46	Hasan Gürbüz	Taze Çilek	5	50	2025-06-16 13:35:11.808+00
15	3	46f1f768-db28-450d-9217-42073cc6b3d0	46	Hasan	Karpuz	20	240	2025-06-16 15:25:36.578+00
16	101	a6871afe-b121-45fb-8969-38661cf1d9f2	46	Hasan Gürbüz	Taze Çilek	5	63	2025-06-16 15:26:34.114+00
17	10	427a407a-5041-49fe-b05d-6df69f84e6ef	47	Hasan	Havuç	20	600	2025-06-17 15:26:17.636+00
18	11	427a407a-5041-49fe-b05d-6df69f84e6ef	47	Hasan gürbüz	Havuç	20	360	2025-06-17 15:37:14.351+00
19	11	427a407a-5041-49fe-b05d-6df69f84e6ef	47	Hasan gürbüz	Havuç	20	360	2025-06-19 11:54:43.987+00
20	9	78a96f2b-9f0e-4516-92c1-9f90cd7fe76c	47	Hasan	Karnıbahar	40	800	2025-06-19 11:59:08.104+00
21	10	427a407a-5041-49fe-b05d-6df69f84e6ef	47	Hasan	Havuç	20	600	2025-06-19 11:59:25.828+00
22	6	78a96f2b-9f0e-4516-92c1-9f90cd7fe76c	47	Farmer servisinden çekilecek	Karnıbahar	10	200	2025-06-19 11:59:36.548+00
23	2	a6871afe-b121-45fb-8969-38661cf1d9f2	47	Hasan	Çilek	50	1000	2025-06-19 11:59:39.176+00
24	1	46f1f768-db28-450d-9217-42073cc6b3d0	47	Farmer servisinden çekilecek	Karpuz	10	200	2025-06-19 11:59:42.362+00
25	3	46f1f768-db28-450d-9217-42073cc6b3d0	46	Hasan	Karpuz	20	240	2025-06-19 12:00:23.605+00
26	100	a6871afe-b121-45fb-8969-38661cf1d9f2	46	Hasan Gürbüz	Taze Çilek	3	45	2025-06-19 12:05:10.444+00
27	8	42067206-de49-4b97-8008-c2fedd8b5248	46	Hasan	Kavun	49	1175	2025-06-19 12:05:49.416+00
28	7	42067206-de49-4b97-8008-c2fedd8b5248	46	Hasan	Kavun	20	500	2025-06-19 12:05:52.414+00
\.


--
-- TOC entry 4040 (class 0 OID 18399)
-- Dependencies: 306
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (order_id, user_id, order_status, order_date, estimated_delivery_date, delivery_date, use_any_coupon, delivery_address_id, address_full, address_city, address_district, address_neighborhood, address_street, address_floor, address_apartment, rate_for_order) FROM stdin;
5	4	pending	2025-04-30T18:10:46.697Z	2025-05-01T18:10:46.697Z	\N	f	6	\N	\N	\N	\N	\N	\N	\N	\N
6	4	pending	2025-05-02T13:12:56.568Z	2025-05-03T13:12:56.568Z	\N	f	6	\N	\N	\N	\N	\N	\N	\N	\N
7	4	pending	2025-05-02T13:23:26.068Z	2025-05-03T13:23:26.069Z	\N	f	6	\N	\N	\N	\N	\N	\N	\N	\N
8	4	pending	2025-05-04T20:48:12.514Z	2025-05-05T20:48:12.514Z	\N	f	6	\N	\N	\N	\N	\N	\N	\N	\N
10	10	Hazırlanıyor	12.06.2025	13.06.2025	\N	f	3	\N	\N	\N	\N	\N	\N	\N	\N
11	3	Sipariş alınıd	20.11.2025	22.11.20225	\N	f	5	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- TOC entry 4041 (class 0 OID 18404)
-- Dependencies: 307
-- Data for Name: order_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_product (order_id, order_product_id, farmer_id, farmer_name, unit_quantity, unit_price, total_product_price, order_product_rate, delivery_address_id, product_name, product_id, order_product_status) FROM stdin;
6	301	46	Hasan Gürbüz	3	15	45	\N	2	Taze Çilek	a6871afe-b121-45fb-8969-38661cf1d9f2	\N
6	300	46	Hasan Gürbüz	5	10	50	\N	1	Taze Çilek	a6871afe-b121-45fb-8969-38661cf1d9f2	\N
6	101	46	Hasan Gürbüz	5	13	63	\N	2	Taze Çilek	a6871afe-b121-45fb-8969-38661cf1d9f2	\N
11	11	47	Hasan gürbüz	20	18	360	\N	2	Havuç	427a407a-5041-49fe-b05d-6df69f84e6ef	hazırlandı
11	9	47	Hasan	40	20	800	\N	5	Karnıbahar	78a96f2b-9f0e-4516-92c1-9f90cd7fe76c	hazırlandı
6	302	46	Hasan Gürbüz	2	20	40	\N	3	Taze Çilek	a6871afe-b121-45fb-8969-38661cf1d9f2	\N
6	10	47	Hasan	20	30	600	\N	2	Havuç	427a407a-5041-49fe-b05d-6df69f84e6ef	hazırlandı
8	6	47	Farmer servisinden çekilecek	10	20	200	\N	6	Karnıbahar	78a96f2b-9f0e-4516-92c1-9f90cd7fe76c	hazırlandı
6	2	47	Hasan	50	20	1000	5	1	Çilek	a6871afe-b121-45fb-8969-38661cf1d9f2	hazırlandı
7	1	47	Farmer servisinden çekilecek	10	20	200	\N	6	Karpuz	46f1f768-db28-450d-9217-42073cc6b3d0	hazırlandı
6	3	46	Hasan	20	12	240	5	5	Karpuz	46f1f768-db28-450d-9217-42073cc6b3d0	hazırlandı
6	100	46	Hasan Gürbüz	3	15	45	\N	1	Taze Çilek	a6871afe-b121-45fb-8969-38661cf1d9f2	hazırlandı
7	8	46	Hasan	49	25	1175	\N	4	Kavun	42067206-de49-4b97-8008-c2fedd8b5248	hazırlandı
8	7	46	Hasan	20	25	500	\N	5	Kavun	42067206-de49-4b97-8008-c2fedd8b5248	hazırlandı
\.


--
-- TOC entry 4042 (class 0 OID 18407)
-- Dependencies: 308
-- Data for Name: product_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_table (farmer_id, product_id, product_katalog_name, farmer_price, tarladan_commission, tarladan_price, product_rating, product_name, stock_quantity) FROM stdin;
46	1	Salatalık	15	5	20	4.4	Çengelköy Salatalığı	130
46	2	Ayva	20	8	28	5	Yaz ayvası	270
46	3	Salatalık	18	5	23	4.6	Köy salatalığı	150
46	4	Vişne 	24	10	34	4.8	Bahar Vişnesi	180
46	5	Sebzeler	89.06	0.05	93.51	4.7	Soğan	396
46	6	Meyveler	59.4	0.06	62.96	4.1	Armut	482
46	7	Baklagiller	85.63	0.13	96.76	3.6	Bakla	452
1	8	Meyveler	39.57	0.11	43.92	3.8	Portakal	482
1	9	Baklagiller	51.99	0.1	57.19	3.5	Nohut	84
1	10	Tahıllar	7.92	0.09	8.63	3.5	Arpa	150
1	11	Baklagiller	13.2	0.06	13.99	4.9	Nohut	467
1	12	Baklagiller	13.46	0.13	15.21	3.2	Bakla	54
1	13	Tahıllar	14.77	0.09	16.1	3.5	Arpa	15
1	14	Sebzeler	1.34	0.12	1.5	4.5	Kabak	76
1	15	Sebzeler	4.09	0.17	4.79	4.1	Patlıcan	43
1	16	Sebzeler	76.03	0.17	88.96	3.4	Ispanak	469
1	17	Sebzeler	11.99	0.07	12.83	4.4	Kabak	208
1	18	Tahıllar	62.2	0.07	66.55	4.1	Çavdar	414
1	19	Sebzeler	22.72	0.11	25.22	3	Salatalık	77
1	20	Baklagiller	19.97	0.18	23.56	5	Mercimek	84
1	21	Sebzeler	29.42	0.18	34.72	3.4	Biber	280
1	22	Baklagiller	74.82	0.2	89.78	4.3	Nohut	59
1	23	Baklagiller	54.96	0.13	62.1	4.1	Barbunya	50
1	24	Meyveler	91.73	0.17	107.32	4.3	Kiraz	469
1	25	Baklagiller	78.99	0.06	83.73	4.9	Nohut	460
1	26	Meyveler	84.5	0.05	88.73	3.4	Üzüm	32
1	27	Sebzeler	27.28	0.14	31.1	4.8	Havuç	306
1	28	Sebzeler	56.57	0.13	63.92	3.8	Soğan	162
1	29	Baklagiller	13.33	0.06	14.13	3.9	Bakla	462
1	30	Sebzeler	42.51	0.17	49.74	3.5	Patlıcan	221
1	31	Meyveler	22.76	0.15	26.17	4.4	Karpuz	170
1	32	Meyveler	8.78	0.05	9.22	4.3	Kiraz	23
1	33	Meyveler	65.63	0.09	71.54	4.9	Muz	415
1	34	Sebzeler	94.66	0.16	109.81	4	Sarımsak	13
1	35	Sebzeler	32.62	0.13	36.86	4	Sarımsak	242
1	36	Tahıllar	10.98	0.17	12.85	4	Buğday	461
1	37	Meyveler	9.58	0.11	10.63	3.2	Üzüm	202
1	38	Meyveler	96.65	0.13	109.21	4.6	Üzüm	290
1	39	Meyveler	33.44	0.1	36.78	3.4	Çilek	239
1	40	Tahıllar	52.74	0.16	61.18	3.6	Mısır	270
1	41	Meyveler	98.18	0.06	104.07	3.2	Kavun	312
1	42	Sebzeler	95.12	0.2	114.14	4.3	Sarımsak	51
1	43	Meyveler	89.88	0.15	103.36	3.4	İncir	79
1	44	Sebzeler	42.26	0.16	49.02	3.2	Marul	311
1	45	Tahıllar	68.73	0.09	74.92	3.3	Yulaf	352
1	46	Sebzeler	94.29	0.17	110.32	3.1	Patlıcan	481
1	47	Tahıllar	97.08	0.09	105.82	4.7	Arpa	238
1	48	Tahıllar	59.89	0.16	69.47	3.9	Çavdar	408
1	49	Sebzeler	40.5	0.09	44.15	3.7	Salatalık	368
1	50	Sebzeler	17.34	0.13	19.59	4	Domates	85
1	51	Tahıllar	39.07	0.08	42.2	3.2	Arpa	147
1	52	Sebzeler	12.73	0.1	14	3.1	Soğan	297
1	53	Tahıllar	91.11	0.19	108.42	4.5	Yulaf	87
1	54	Tahıllar	37.59	0.12	42.1	3.9	Yulaf	424
1	55	Tahıllar	60.5	0.14	68.97	3.3	Mısır	405
1	56	Baklagiller	74.63	0.13	84.33	3.6	Nohut	73
1	57	Baklagiller	53.08	0.17	62.1	3.4	Bakla	400
1	58	Baklagiller	25.04	0.14	28.55	3.5	Bakla	335
1	59	Sebzeler	46.76	0.1	51.44	4.8	Patlıcan	178
1	60	Meyveler	92.79	0.06	98.36	3.6	Muz	182
1	61	Baklagiller	63.66	0.05	66.84	4.6	Barbunya	418
1	62	Meyveler	7.51	0.12	8.41	3.1	Portakal	497
1	63	Tahıllar	41.43	0.1	45.57	4	Mısır	377
1	64	Sebzeler	66.61	0.07	71.27	4.5	Ispanak	461
1	65	Tahıllar	65.94	0.16	76.49	3.7	Yulaf	321
1	66	Tahıllar	42.45	0.11	47.12	3.8	Yulaf	463
1	67	Tahıllar	72.6	0.14	82.76	3.4	Buğday	233
1	68	Baklagiller	69.5	0.16	80.62	3.7	Nohut	103
1	69	Sebzeler	28.71	0.09	31.29	4.9	Kabak	430
1	70	Meyveler	19.72	0.08	21.3	4	Portakal	206
1	71	Meyveler	60.87	0.15	70	3.1	Kiraz	98
1	72	Baklagiller	93.21	0.12	104.4	4.2	Fasulye	312
1	73	Baklagiller	11.18	0.05	11.74	5	Bakla	489
1	74	Meyveler	91.79	0.11	101.89	4.1	Karpuz	205
1	75	Sebzeler	17.85	0.14	20.35	3.6	Patlıcan	59
1	76	Meyveler	80.21	0.14	91.44	4.1	Portakal	391
1	77	Sebzeler	90.28	0.17	105.63	3.6	Sarımsak	392
1	78	Tahıllar	26.7	0.17	31.24	4.4	Buğday	448
1	79	Sebzeler	80.92	0.08	87.39	3.1	Ispanak	190
1	80	Meyveler	37.88	0.15	43.56	3.1	Karpuz	239
1	81	Sebzeler	36.43	0.07	38.98	3.9	Sarımsak	293
1	82	Sebzeler	31.7	0.16	36.77	4.5	Biber	157
1	83	Baklagiller	74.04	0.07	79.22	4.8	Bakla	87
1	84	Meyveler	23.22	0.19	27.63	3.2	Kavun	326
1	85	Meyveler	10.64	0.17	12.45	4.7	Armut	445
1	86	Tahıllar	22.35	0.15	25.7	3.7	Buğday	392
1	87	Tahıllar	24.95	0.11	27.69	3.2	Çavdar	307
1	88	Tahıllar	8.91	0.18	10.51	4.7	Arpa	131
1	89	Tahıllar	25.4	0.08	27.43	3.5	Yulaf	500
1	90	Baklagiller	33.31	0.11	36.97	4.1	Fasulye	499
1	91	Baklagiller	96.22	0.05	101.03	4.8	Bakla	107
1	92	Tahıllar	98.35	0.13	111.14	3.2	Çavdar	29
1	93	Sebzeler	70.54	0.19	83.94	4.2	Domates	398
1	94	Tahıllar	56.51	0.06	59.9	4.5	Buğday	240
1	95	Meyveler	75.81	0.05	79.6	3.3	Kiraz	147
1	96	Meyveler	87.71	0.07	93.85	3.9	Çilek	436
1	97	Tahıllar	14.82	0.19	17.64	4.6	Buğday	423
1	98	Baklagiller	55.17	0.1	60.69	3.7	Mercimek	183
1	99	Meyveler	20.41	0.08	22.04	4	Üzüm	212
1	100	Sebzeler	75.93	0.06	80.49	4.3	Havuç	154
1	101	Baklagiller	17.95	0.19	21.36	3.1	Mercimek	485
1	102	Baklagiller	52.54	0.07	56.22	5	Barbunya	348
1	103	Sebzeler	60.76	0.1	66.84	3.5	Salatalık	310
1	104	Meyveler	81.43	0.16	94.46	3.1	Portakal	481
1	105	Meyveler	69.11	0.1	76.02	3.5	Çilek	205
1	106	Sebzeler	33.44	0.19	39.79	3	Biber	349
1	107	Meyveler	26.15	0.09	28.5	4.4	Muz	359
1	108	Meyveler	26.48	0.07	28.33	3.8	İncir	88
1	109	Meyveler	78.92	0.16	91.55	3.9	Armut	114
1	110	Tahıllar	68.95	0.06	73.09	3.7	Arpa	119
1	111	Baklagiller	34.19	0.18	40.34	4.6	Bakla	203
1	112	Meyveler	34.74	0.16	40.3	3.9	Kiraz	66
1	113	Tahıllar	89.18	0.1	98.1	4.7	Arpa	169
1	114	Sebzeler	49.51	0.17	57.93	3.4	Kabak	21
1	115	Meyveler	41.6	0.14	47.42	3.7	Kavun	318
1	116	Baklagiller	79.54	0.11	88.29	4	Barbunya	475
1	117	Tahıllar	15.84	0.16	18.37	5	Arpa	459
1	118	Baklagiller	23.64	0.17	27.66	3.3	Barbunya	288
1	119	Sebzeler	61.83	0.1	68.01	4.3	Marul	136
1	120	Tahıllar	76.47	0.15	87.94	5	Yulaf	60
1	121	Sebzeler	72.08	0.1	79.29	3.4	Domates	440
1	122	Sebzeler	47.63	0.16	55.25	4.3	Ispanak	148
1	123	Sebzeler	14.31	0.05	15.03	4.8	Sarımsak	111
1	124	Sebzeler	5.54	0.14	6.32	3.7	Marul	422
1	125	Baklagiller	53.31	0.08	57.57	3.5	Barbunya	423
1	126	Baklagiller	54.37	0.07	58.18	4.5	Barbunya	395
1	127	Tahıllar	14.71	0.11	16.33	3.4	Çavdar	185
1	128	Meyveler	16.51	0.1	18.16	4.6	Kiraz	401
1	129	Sebzeler	71.29	0.15	81.98	3.4	Patlıcan	340
1	130	Meyveler	41.77	0.14	47.62	4.7	Elma	322
1	131	Baklagiller	79.9	0.16	92.68	3.6	Mercimek	355
1	132	Baklagiller	85.05	0.18	100.36	4	Bakla	189
1	133	Tahıllar	72.97	0.16	84.65	3.5	Buğday	496
1	134	Tahıllar	69.37	0.16	80.47	3.6	Buğday	368
1	135	Tahıllar	23.19	0.11	25.74	3.6	Yulaf	213
1	136	Sebzeler	46.96	0.19	55.88	3.4	Havuç	66
1	137	Baklagiller	30.59	0.15	35.18	3	Mercimek	172
1	138	Sebzeler	87.01	0.15	100.06	3.2	Salatalık	216
1	139	Sebzeler	43.55	0.09	47.47	3.4	Sarımsak	20
1	140	Tahıllar	87.01	0.16	100.93	4.9	Mısır	247
1	141	Meyveler	14.78	0.19	17.59	4.7	Armut	490
1	142	Tahıllar	68.16	0.08	73.61	3.7	Buğday	305
1	143	Baklagiller	54.58	0.15	62.77	4.6	Mercimek	331
1	144	Baklagiller	62.75	0.15	72.16	3	Fasulye	62
1	145	Tahıllar	98.64	0.11	109.49	3.8	Arpa	355
1	146	Baklagiller	47.39	0.15	54.5	4.5	Nohut	460
1	147	Sebzeler	5.56	0.06	5.89	3.3	Sarımsak	406
1	148	Tahıllar	89.13	0.15	102.5	3.7	Yulaf	122
1	149	Baklagiller	3.07	0.14	3.5	4.3	Fasulye	393
1	150	Baklagiller	54.16	0.06	57.41	3.8	Fasulye	122
1	151	Baklagiller	26.91	0.06	28.52	3.7	Fasulye	434
1	152	Meyveler	43.07	0.2	51.68	3.3	Karpuz	107
1	153	Sebzeler	65.7	0.09	71.61	4.7	Patlıcan	435
1	154	Tahıllar	19.04	0.19	22.66	3.7	Yulaf	306
1	155	Tahıllar	6.96	0.17	8.14	3.9	Buğday	277
1	156	Baklagiller	19.23	0.1	21.15	4.5	Bakla	193
1	157	Tahıllar	25.39	0.13	28.69	4.7	Çavdar	424
1	158	Baklagiller	9.47	0.12	10.61	3.3	Barbunya	480
1	159	Sebzeler	8.63	0.11	9.58	3.5	Soğan	242
1	160	Tahıllar	36.76	0.11	40.8	4	Mısır	86
1	161	Sebzeler	91.9	0.16	106.6	3.3	Soğan	375
1	162	Sebzeler	23.64	0.05	24.82	3.3	Kabak	487
1	163	Baklagiller	75.68	0.18	89.3	4.4	Mercimek	473
1	164	Meyveler	56.03	0.18	66.12	3.2	Kiraz	123
1	165	Meyveler	9	0.13	10.17	4.2	Kavun	82
1	166	Sebzeler	84.56	0.09	92.17	3.3	Havuç	126
1	167	Tahıllar	57.35	0.14	65.38	3.1	Yulaf	50
1	168	Tahıllar	43.81	0.07	46.88	3.6	Arpa	46
1	169	Baklagiller	11.8	0.08	12.74	3.7	Barbunya	467
1	170	Baklagiller	66.62	0.2	79.94	3.9	Barbunya	338
1	171	Baklagiller	30.91	0.18	36.47	4	Mercimek	199
1	172	Meyveler	72.43	0.18	85.47	4.2	Üzüm	433
1	173	Baklagiller	51.85	0.17	60.66	4.9	Fasulye	190
1	174	Sebzeler	60.35	0.09	65.78	3.5	Domates	440
1	175	Tahıllar	46.75	0.1	51.43	4.7	Arpa	165
1	176	Baklagiller	27.71	0.14	31.59	4.2	Mercimek	271
1	177	Meyveler	28.68	0.06	30.4	3.9	Karpuz	32
1	178	Tahıllar	93.01	0.07	99.52	4.3	Mısır	61
1	179	Tahıllar	45.09	0.08	48.7	4.7	Arpa	292
1	180	Meyveler	8.2	0.18	9.68	4.6	Karpuz	378
1	181	Tahıllar	11.26	0.18	13.29	4.8	Yulaf	440
1	182	Meyveler	40.62	0.16	47.12	4.9	Armut	159
1	183	Tahıllar	78.54	0.15	90.32	4	Yulaf	103
1	184	Meyveler	36.2	0.07	38.73	3.4	Elma	147
1	185	Tahıllar	78.17	0.1	85.99	3.1	Yulaf	231
1	186	Baklagiller	34.8	0.18	41.06	4.5	Mercimek	24
1	187	Meyveler	40.91	0.09	44.59	3.3	Muz	128
1	188	Meyveler	91.28	0.07	97.67	3.3	Armut	449
1	189	Tahıllar	36.77	0.19	43.76	4.8	Yulaf	395
1	190	Meyveler	12.35	0.06	13.09	4.6	Karpuz	475
1	191	Tahıllar	78.04	0.1	85.84	3.3	Çavdar	404
1	192	Meyveler	39.9	0.1	43.89	3.4	Kavun	305
1	193	Tahıllar	56.29	0.09	61.36	4.9	Buğday	20
1	194	Tahıllar	64.7	0.18	76.35	3.4	Arpa	196
1	195	Baklagiller	20.54	0.11	22.8	4.8	Barbunya	413
1	196	Sebzeler	16.37	0.12	18.33	3.1	Patlıcan	48
1	197	Baklagiller	3.37	0.18	3.98	3.5	Bakla	368
1	198	Meyveler	55.62	0.1	61.18	3.3	Karpuz	204
1	199	Tahıllar	2.06	0.14	2.35	4.9	Arpa	37
1	200	Meyveler	9.09	0.07	9.73	3.8	Kiraz	317
1	201	Sebzeler	58.11	0.15	66.83	3.8	Havuç	288
1	202	Sebzeler	13.69	0.14	15.61	3	Patlıcan	19
1	203	Baklagiller	45.45	0.09	49.54	3.4	Barbunya	287
1	204	Baklagiller	4.59	0.05	4.82	4.8	Nohut	283
1	205	Sebzeler	3.97	0.19	4.72	3.7	Kabak	426
1	206	Sebzeler	23.43	0.06	24.84	3.4	Domates	91
1	207	Baklagiller	91.44	0.11	101.5	3.4	Barbunya	396
1	208	Tahıllar	30.81	0.07	32.97	4.7	Yulaf	364
1	209	Sebzeler	85.56	0.05	89.84	4.4	Salatalık	50
1	210	Baklagiller	87.59	0.06	92.85	3.8	Barbunya	430
1	211	Meyveler	91.07	0.15	104.73	4.4	Karpuz	389
1	212	Sebzeler	64.74	0.05	67.98	4.7	Ispanak	237
1	213	Sebzeler	75.05	0.14	85.56	3.4	Domates	374
1	214	Sebzeler	34.32	0.07	36.72	4.6	Soğan	464
1	215	Meyveler	93.14	0.14	106.18	3.1	Kavun	355
1	216	Baklagiller	2.32	0.15	2.67	4.2	Barbunya	97
1	217	Tahıllar	3.91	0.05	4.11	4.8	Buğday	110
1	218	Baklagiller	94.93	0.16	110.12	4	Barbunya	276
1	219	Meyveler	62.41	0.15	71.77	4.5	Armut	226
1	220	Sebzeler	90.51	0.2	108.61	3	Biber	286
1	221	Tahıllar	96.77	0.17	113.22	3.4	Mısır	17
1	222	Meyveler	66.54	0.2	79.85	3.2	Karpuz	382
1	223	Tahıllar	68.11	0.12	76.28	4.9	Çavdar	398
1	224	Tahıllar	47.61	0.15	54.75	3.8	Arpa	177
1	225	Meyveler	51.16	0.1	56.28	3.6	Portakal	93
1	226	Meyveler	81.72	0.12	91.53	3	Karpuz	491
1	227	Meyveler	63.43	0.16	73.58	4.3	Muz	170
1	228	Baklagiller	52.33	0.16	60.7	3.5	Fasulye	447
1	229	Tahıllar	29.45	0.09	32.1	3.2	Yulaf	455
1	230	Meyveler	53.05	0.17	62.07	3.8	İncir	167
1	231	Tahıllar	3.14	0.19	3.74	3.3	Mısır	172
1	232	Sebzeler	88.52	0.08	95.6	4.4	Salatalık	498
1	233	Tahıllar	79.64	0.06	84.42	4.7	Buğday	180
1	234	Tahıllar	19.96	0.17	23.35	3.2	Arpa	21
1	235	Baklagiller	22.18	0.15	25.51	4.8	Nohut	444
1	236	Sebzeler	21.05	0.19	25.05	3.8	Ispanak	253
1	237	Meyveler	24.75	0.1	27.23	3.1	Elma	106
1	238	Sebzeler	39.17	0.11	43.48	4.5	Ispanak	363
1	239	Baklagiller	34.56	0.15	39.74	4.9	Nohut	117
1	240	Sebzeler	73.66	0.11	81.76	4.5	Kabak	77
1	241	Meyveler	93.28	0.13	105.41	4.7	Üzüm	106
1	242	Sebzeler	68.07	0.1	74.88	4.2	Patlıcan	320
1	243	Sebzeler	69.74	0.15	80.2	4.9	Soğan	69
1	244	Meyveler	66.19	0.14	75.46	4.3	İncir	285
1	245	Sebzeler	68.21	0.19	81.17	3.4	Havuç	350
1	246	Meyveler	87.42	0.11	97.04	3.7	Kavun	262
1	247	Sebzeler	98.06	0.15	112.77	4.1	Soğan	269
1	248	Sebzeler	53.84	0.08	58.15	3.7	Kabak	390
1	249	Meyveler	81.48	0.08	88	4.6	Elma	69
1	250	Sebzeler	73.18	0.13	82.69	3.7	Salatalık	24
1	251	Meyveler	77.68	0.18	91.66	3.3	İncir	334
1	252	Tahıllar	52.02	0.12	58.26	3.1	Buğday	145
1	253	Tahıllar	46.03	0.1	50.63	3.8	Yulaf	52
1	254	Sebzeler	96.84	0.17	113.3	4	Kabak	489
1	255	Sebzeler	26.82	0.08	28.97	3.8	Biber	279
1	256	Meyveler	3.13	0.13	3.54	4.5	İncir	356
1	257	Sebzeler	36.42	0.17	42.61	3.5	Soğan	57
1	258	Baklagiller	64.76	0.18	76.42	4.3	Fasulye	326
1	259	Sebzeler	69.05	0.17	80.79	4.3	Domates	168
1	260	Meyveler	98.8	0.06	104.73	3.4	Kiraz	257
1	261	Baklagiller	69.81	0.11	77.49	3.2	Bakla	380
1	262	Tahıllar	99.29	0.19	118.16	4.3	Mısır	407
1	263	Baklagiller	17.99	0.2	21.59	3.4	Bakla	126
1	264	Sebzeler	89.54	0.18	105.66	3.9	Sarımsak	474
1	265	Tahıllar	61.59	0.2	73.91	4.7	Çavdar	311
1	266	Sebzeler	71.95	0.14	82.02	4.6	Kabak	49
1	267	Baklagiller	34.2	0.1	37.62	3.9	Nohut	67
1	268	Baklagiller	28.77	0.14	32.8	5	Barbunya	75
1	269	Sebzeler	6.39	0.19	7.6	4.7	Sarımsak	494
1	270	Baklagiller	22.62	0.18	26.69	4.1	Bakla	21
1	271	Tahıllar	67.34	0.19	80.13	4.8	Arpa	183
1	272	Meyveler	46.39	0.09	50.57	4.5	Kiraz	89
1	273	Meyveler	19.57	0.16	22.7	4.7	Portakal	414
1	274	Meyveler	51.22	0.08	55.32	4.1	Portakal	274
1	275	Meyveler	20.58	0.07	22.02	5	Kavun	329
1	276	Meyveler	29.23	0.07	31.28	3.4	İncir	387
1	277	Sebzeler	79.76	0.15	91.72	4.5	Marul	412
1	278	Tahıllar	71.02	0.13	80.25	4.4	Mısır	392
1	279	Baklagiller	18.42	0.14	21	3.1	Fasulye	463
1	280	Tahıllar	38.13	0.15	43.85	4.6	Buğday	125
1	281	Baklagiller	34.49	0.16	40.01	4.4	Mercimek	213
1	282	Tahıllar	70.07	0.13	79.18	4.5	Mısır	339
1	283	Sebzeler	25.64	0.16	29.74	3.3	Kabak	253
1	284	Sebzeler	74.62	0.1	82.08	4.4	Domates	433
1	285	Tahıllar	84.8	0.12	94.98	4	Buğday	42
1	286	Meyveler	97.24	0.19	115.72	3.2	Armut	280
1	287	Tahıllar	74.46	0.17	87.12	3.8	Yulaf	377
1	288	Tahıllar	33.39	0.11	37.06	3.2	Yulaf	384
1	289	Sebzeler	76.34	0.09	83.21	3.1	Salatalık	16
1	290	Tahıllar	58.6	0.19	69.73	3.8	Çavdar	186
1	291	Baklagiller	94.95	0.11	105.39	4.7	Barbunya	181
1	292	Tahıllar	76.81	0.07	82.19	4.7	Mısır	17
1	293	Sebzeler	60.35	0.11	66.99	3.2	Ispanak	87
1	294	Sebzeler	82.28	0.18	97.09	4.5	Salatalık	310
1	295	Tahıllar	54.87	0.06	58.16	3.8	Yulaf	317
1	296	Meyveler	43.03	0.17	50.35	4	Elma	235
1	297	Meyveler	6.71	0.07	7.18	5	Kiraz	49
1	298	Baklagiller	59.83	0.08	64.62	4.7	Mercimek	71
1	299	Baklagiller	47.21	0.15	54.29	3.2	Bakla	10
1	300	Meyveler	33.6	0.09	36.62	4.3	Armut	408
1	301	Baklagiller	19.46	0.12	21.8	3.9	Bakla	252
1	302	Baklagiller	23.84	0.09	25.99	4.9	Bakla	13
1	303	Baklagiller	95.72	0.07	102.42	4.7	Mercimek	353
1	304	Tahıllar	3.26	0.07	3.49	3.7	Buğday	394
1	305	Sebzeler	52.5	0.13	59.32	3.5	Domates	113
1	306	Sebzeler	55.67	0.1	61.24	4.4	Salatalık	380
1	307	Meyveler	77.44	0.1	85.18	4	Çilek	234
1	308	Tahıllar	85.1	0.07	91.06	4	Arpa	105
1	309	Tahıllar	80.99	0.15	93.14	4.7	Buğday	86
1	310	Meyveler	27.39	0.1	30.13	3.5	Portakal	102
1	311	Meyveler	68.65	0.14	78.26	3.8	Çilek	439
1	312	Baklagiller	14.9	0.07	15.94	4	Barbunya	17
1	313	Meyveler	78.13	0.18	92.19	3.3	Portakal	36
1	314	Baklagiller	62.13	0.12	69.59	4.1	Mercimek	49
1	315	Tahıllar	1.13	0.09	1.23	4.2	Arpa	125
1	316	Meyveler	38.82	0.14	44.25	4.4	Üzüm	225
1	317	Meyveler	21.86	0.05	22.95	3.5	Çilek	235
1	318	Tahıllar	75.35	0.15	86.65	3.6	Yulaf	412
1	319	Tahıllar	64.32	0.1	70.75	3.7	Çavdar	404
1	320	Meyveler	69.55	0.18	82.07	4	Çilek	434
1	321	Meyveler	45.5	0.16	52.78	4.2	Kavun	123
1	322	Sebzeler	34.33	0.07	36.73	3.3	Havuç	306
1	323	Sebzeler	53.61	0.09	58.43	4.2	Patlıcan	249
1	324	Sebzeler	8.42	0.18	9.94	4.8	Domates	13
1	325	Baklagiller	73.36	0.1	80.7	4	Mercimek	142
1	326	Sebzeler	83.82	0.12	93.88	4.9	Ispanak	309
1	327	Sebzeler	71.2	0.07	76.18	3.2	Patlıcan	274
1	328	Sebzeler	10.91	0.05	11.46	3.1	Kabak	350
1	329	Sebzeler	8.92	0.11	9.9	4.3	Soğan	55
1	330	Meyveler	32.41	0.14	36.95	4.3	Armut	435
1	331	Meyveler	60.36	0.17	70.62	3.3	İncir	66
1	332	Meyveler	76.72	0.15	88.23	3.5	Portakal	25
1	333	Tahıllar	11.89	0.1	13.08	4.8	Buğday	28
1	334	Baklagiller	42.47	0.19	50.54	5	Mercimek	117
1	335	Baklagiller	45.75	0.18	53.98	3.6	Mercimek	68
1	336	Meyveler	35.52	0.09	38.72	3.4	Üzüm	116
1	337	Baklagiller	15.55	0.19	18.5	4.3	Mercimek	361
1	338	Baklagiller	44.73	0.16	51.89	4	Barbunya	358
1	339	Meyveler	20.15	0.12	22.57	3.2	Muz	124
1	340	Tahıllar	5.4	0.07	5.78	3.1	Mısır	74
1	341	Baklagiller	36.83	0.08	39.78	4.7	Nohut	375
1	342	Sebzeler	15.93	0.2	19.12	3.6	Patlıcan	425
1	343	Tahıllar	36.56	0.06	38.75	3.6	Buğday	424
1	344	Baklagiller	36.78	0.13	41.56	3.4	Bakla	476
1	345	Sebzeler	78.12	0.14	89.06	4.8	Marul	87
1	346	Sebzeler	77.41	0.17	90.57	3.6	Kabak	467
1	347	Sebzeler	87.24	0.15	100.33	3.5	Salatalık	302
1	348	Sebzeler	63.35	0.18	74.75	4.2	Patlıcan	118
1	349	Tahıllar	8.46	0.19	10.07	4.8	Yulaf	167
1	350	Tahıllar	73.39	0.11	81.46	3.1	Yulaf	186
1	351	Baklagiller	69.6	0.11	77.26	3.1	Barbunya	304
1	352	Meyveler	14.82	0.09	16.15	4.6	Portakal	455
1	353	Baklagiller	17.36	0.17	20.31	4.6	Mercimek	285
1	354	Tahıllar	91.96	0.17	107.59	3	Çavdar	40
1	355	Baklagiller	96.02	0.11	106.58	4.9	Mercimek	370
1	356	Meyveler	6.22	0.11	6.9	3.6	İncir	94
1	357	Sebzeler	17.69	0.18	20.87	3.7	Domates	213
1	358	Meyveler	37.42	0.12	41.91	4.6	İncir	221
1	359	Meyveler	4.79	0.14	5.46	3.5	Çilek	168
1	360	Meyveler	91.47	0.11	101.53	4.1	Çilek	99
1	361	Baklagiller	54.79	0.18	64.65	4.4	Fasulye	435
1	362	Tahıllar	11.2	0.08	12.1	3.4	Yulaf	372
1	363	Tahıllar	46.02	0.14	52.46	3.6	Buğday	409
1	364	Sebzeler	99.67	0.07	106.65	3.5	Marul	52
1	365	Baklagiller	74.37	0.11	82.55	3.8	Mercimek	51
1	366	Sebzeler	5.67	0.07	6.07	3.3	Kabak	470
1	367	Meyveler	87.67	0.13	99.07	4.4	İncir	419
1	368	Baklagiller	28.23	0.15	32.46	4.3	Barbunya	107
1	369	Baklagiller	3.52	0.08	3.8	3.6	Nohut	332
1	370	Meyveler	39.15	0.14	44.63	3.1	Çilek	212
1	371	Baklagiller	62.09	0.1	68.3	4.5	Nohut	175
1	372	Baklagiller	57.88	0.13	65.4	3.7	Bakla	128
1	373	Baklagiller	28.78	0.15	33.1	3.2	Nohut	401
1	374	Meyveler	45.42	0.12	50.87	4.4	Çilek	210
1	375	Meyveler	90.52	0.2	108.62	4.1	Muz	286
1	376	Meyveler	17.89	0.05	18.78	3.1	Karpuz	218
1	377	Sebzeler	92.09	0.18	108.67	3.6	Patlıcan	264
1	378	Sebzeler	89.31	0.08	96.45	4.2	Domates	485
1	379	Tahıllar	21.03	0.14	23.97	4.8	Mısır	272
1	380	Sebzeler	48.05	0.14	54.78	3.9	Havuç	327
1	381	Meyveler	36.62	0.19	43.58	4	Kavun	31
1	382	Sebzeler	8.43	0.11	9.36	4.8	Patlıcan	130
1	383	Meyveler	1.2	0.16	1.39	3.2	Portakal	352
1	384	Meyveler	32.42	0.14	36.96	3.8	Armut	420
1	385	Baklagiller	51.17	0.07	54.75	4.7	Mercimek	368
1	386	Tahıllar	18.04	0.12	20.2	4.4	Çavdar	368
1	387	Tahıllar	35.42	0.18	41.8	4.4	Mısır	453
1	388	Sebzeler	3.91	0.11	4.34	4.4	Havuç	284
1	389	Meyveler	19.3	0.1	21.23	3.6	Armut	358
1	390	Sebzeler	47.26	0.16	54.82	4.8	Biber	231
1	391	Tahıllar	6.62	0.18	7.81	4.6	Çavdar	131
1	392	Baklagiller	22.4	0.09	24.42	4.2	Fasulye	389
1	393	Baklagiller	37.69	0.11	41.84	4.3	Mercimek	76
1	394	Baklagiller	6.22	0.05	6.53	4.9	Fasulye	226
1	395	Baklagiller	71.09	0.11	78.91	4	Mercimek	74
1	396	Tahıllar	57.27	0.18	67.58	3.3	Arpa	162
1	397	Sebzeler	87.07	0.11	96.65	4.6	Sarımsak	183
1	398	Baklagiller	20.67	0.05	21.7	4.5	Nohut	145
1	399	Sebzeler	65.74	0.17	76.92	3.2	Patlıcan	231
1	400	Meyveler	65.82	0.07	70.43	4.9	Çilek	356
1	401	Baklagiller	8.35	0.16	9.69	4.8	Mercimek	252
1	402	Meyveler	80.24	0.2	96.29	4.8	Çilek	54
1	403	Baklagiller	53.59	0.14	61.09	3.6	Fasulye	431
1	404	Meyveler	97.51	0.1	107.26	4.7	Karpuz	43
1	405	Baklagiller	73.14	0.15	84.11	4.3	Mercimek	377
1	406	Tahıllar	77.57	0.11	86.1	3.4	Buğday	12
1	407	Tahıllar	8.4	0.16	9.74	3	Arpa	330
1	408	Tahıllar	71.59	0.19	85.19	3.2	Buğday	120
1	409	Meyveler	31.53	0.14	35.94	4.7	Üzüm	38
1	410	Baklagiller	3.47	0.19	4.13	3.6	Fasulye	193
1	411	Sebzeler	29.56	0.11	32.81	3.7	Sarımsak	437
1	412	Meyveler	17.41	0.1	19.15	4.5	İncir	91
1	413	Sebzeler	82.69	0.12	92.61	3.2	Domates	484
1	414	Tahıllar	91.54	0.06	97.03	3.8	Buğday	25
1	415	Sebzeler	47.59	0.06	50.45	4.6	Havuç	381
1	416	Sebzeler	54.45	0.07	58.26	4.7	Sarımsak	118
1	417	Meyveler	46.65	0.2	55.98	4.9	İncir	20
1	418	Baklagiller	57.09	0.07	61.09	4.5	Barbunya	310
1	419	Meyveler	21.43	0.11	23.79	3.8	Portakal	160
1	420	Meyveler	41.32	0.13	46.69	3.4	Muz	477
1	421	Tahıllar	32.15	0.12	36.01	3	Çavdar	254
1	422	Tahıllar	49.33	0.17	57.72	4.2	Mısır	137
1	423	Tahıllar	77.31	0.12	86.59	3.6	Buğday	492
1	424	Baklagiller	60.4	0.12	67.65	3.9	Mercimek	318
1	425	Tahıllar	11.02	0.09	12.01	4	Çavdar	83
1	426	Sebzeler	78.66	0.15	90.46	4.5	Marul	176
1	427	Sebzeler	38.52	0.18	45.45	3.4	Biber	28
1	428	Baklagiller	66.49	0.11	73.8	3.1	Nohut	118
1	429	Tahıllar	25.36	0.05	26.63	4.2	Buğday	201
1	430	Baklagiller	46.94	0.07	50.23	4.6	Bakla	428
1	431	Sebzeler	24.67	0.08	26.64	3.2	Soğan	460
1	432	Meyveler	59.93	0.19	71.32	4.1	Armut	376
1	433	Tahıllar	40.85	0.12	45.75	3.6	Yulaf	196
1	434	Baklagiller	14.13	0.18	16.67	4.1	Bakla	480
1	435	Tahıllar	77.51	0.19	92.24	4.2	Yulaf	391
1	436	Tahıllar	23.4	0.11	25.97	4.6	Buğday	57
1	437	Meyveler	56.02	0.13	63.3	4.2	Elma	106
1	438	Meyveler	79.77	0.15	91.74	4.7	Armut	239
1	439	Tahıllar	9.75	0.18	11.5	4.1	Buğday	343
1	440	Baklagiller	56.04	0.15	64.45	3.6	Nohut	101
1	441	Tahıllar	59.22	0.14	67.51	4.3	Mısır	313
1	442	Sebzeler	2.43	0.1	2.67	3.5	Havuç	253
1	443	Meyveler	85.31	0.14	97.25	3	Muz	29
1	444	Tahıllar	79.91	0.18	94.29	4.7	Çavdar	433
1	445	Tahıllar	54.64	0.18	64.48	3.9	Mısır	456
1	446	Tahıllar	45.2	0.09	49.27	3.6	Mısır	465
1	447	Baklagiller	37.88	0.14	43.18	3.2	Bakla	371
1	448	Meyveler	8.83	0.12	9.89	3.8	İncir	18
1	449	Meyveler	32.9	0.13	37.18	4.8	Portakal	488
1	450	Meyveler	55.69	0.18	65.71	3.4	Üzüm	295
1	451	Sebzeler	75.21	0.18	88.75	4	Havuç	338
1	452	Sebzeler	83.42	0.19	99.27	3.7	Soğan	322
1	453	Tahıllar	30.61	0.18	36.12	4.9	Arpa	261
1	454	Baklagiller	92.2	0.18	108.8	3.8	Mercimek	313
1	455	Meyveler	35.32	0.08	38.15	4.1	Kiraz	236
1	456	Meyveler	55.58	0.13	62.81	4.7	Muz	72
1	457	Tahıllar	4.78	0.15	5.5	4	Mısır	67
1	458	Baklagiller	77.28	0.15	88.87	3.7	Fasulye	464
1	459	Meyveler	63.29	0.16	73.42	4.9	Üzüm	178
1	460	Tahıllar	99.81	0.09	108.79	3.9	Çavdar	495
1	461	Tahıllar	11.65	0.08	12.58	4.7	Mısır	427
1	462	Meyveler	26.49	0.05	27.81	5	Muz	368
1	463	Sebzeler	67.96	0.15	78.15	4.7	Soğan	420
1	464	Baklagiller	16.8	0.15	19.32	3.7	Barbunya	339
1	465	Sebzeler	38.84	0.13	43.89	3.4	Marul	39
1	466	Baklagiller	22.6	0.11	25.09	4.3	Mercimek	310
1	467	Meyveler	92.27	0.12	103.34	4.3	Armut	424
1	468	Meyveler	33.08	0.18	39.03	3.7	Çilek	179
1	469	Sebzeler	11.26	0.15	12.95	4.8	Kabak	183
1	470	Baklagiller	82.14	0.08	88.71	4.6	Bakla	148
1	471	Tahıllar	3.77	0.08	4.07	4.9	Buğday	254
1	472	Baklagiller	93.88	0.07	100.45	3.4	Nohut	274
1	473	Tahıllar	20.02	0.11	22.22	3.3	Mısır	266
1	474	Sebzeler	72.33	0.19	86.07	4.1	Domates	101
1	475	Tahıllar	57.79	0.18	68.19	3.3	Mısır	45
1	476	Tahıllar	11.33	0.12	12.69	3.7	Yulaf	437
1	477	Sebzeler	81.85	0.1	90.03	3.2	Kabak	226
1	478	Tahıllar	73.96	0.12	82.84	3.8	Mısır	110
1	479	Tahıllar	42.7	0.08	46.12	3.6	Mısır	172
1	480	Sebzeler	67.89	0.18	80.11	3.2	Ispanak	81
1	481	Meyveler	4.86	0.09	5.3	3.6	Muz	16
1	482	Meyveler	26.35	0.13	29.78	4.7	Kavun	249
1	483	Meyveler	78.26	0.15	90	3.5	Kavun	389
1	484	Sebzeler	73.22	0.2	87.86	4.6	Sarımsak	395
1	485	Meyveler	25.05	0.15	28.81	4.4	Elma	297
1	486	Meyveler	72.29	0.07	77.35	3.6	Karpuz	168
1	487	Sebzeler	3.56	0.19	4.24	4.6	Kabak	480
1	488	Meyveler	67.4	0.08	72.79	4.1	Elma	359
1	489	Meyveler	31.18	0.12	34.92	4.1	Portakal	475
1	490	Sebzeler	6.54	0.08	7.06	4.5	Biber	459
1	491	Tahıllar	86.01	0.11	95.47	4.5	Mısır	326
1	492	Sebzeler	35.06	0.11	38.92	3.6	Domates	343
1	493	Sebzeler	1.19	0.17	1.39	4.4	Havuç	199
1	494	Meyveler	46.2	0.15	53.13	3.8	İncir	24
1	495	Baklagiller	46.63	0.14	53.16	4.3	Nohut	494
1	496	Meyveler	42.87	0.11	47.59	4.5	Kiraz	66
1	497	Sebzeler	26.96	0.12	30.2	4	Biber	437
1	498	Tahıllar	32.92	0.1	36.21	3.8	Yulaf	164
1	499	Sebzeler	11.5	0.05	12.08	4.9	Salatalık	184
1	500	Tahıllar	39.6	0.13	44.75	4.7	Yulaf	382
1	501	Tahıllar	64.06	0.09	69.83	3.6	Mısır	10
1	502	Tahıllar	60.78	0.09	66.25	3.3	Buğday	200
1	503	Sebzeler	14.68	0.07	15.71	4.1	Havuç	140
1	504	Meyveler	35.75	0.17	41.83	4.5	Elma	466
1	505	Baklagiller	22.3	0.13	25.2	4.7	Mercimek	258
1	506	Tahıllar	69.14	0.05	72.6	3.3	Çavdar	418
1	507	Baklagiller	33.55	0.18	39.59	3.1	Fasulye	263
1	508	Tahıllar	28.88	0.13	32.63	3.9	Mısır	137
1	509	Baklagiller	78.75	0.07	84.26	5	Nohut	46
1	510	Tahıllar	76.07	0.19	90.52	3.7	Çavdar	117
1	511	Baklagiller	76.47	0.16	88.71	3.8	Bakla	357
1	512	Tahıllar	38.14	0.19	45.39	3.5	Buğday	388
1	513	Sebzeler	11.57	0.19	13.77	3.9	Havuç	238
1	514	Sebzeler	73.36	0.09	79.96	4.9	Salatalık	72
1	515	Tahıllar	96.15	0.06	101.92	4.2	Yulaf	438
1	516	Sebzeler	67.95	0.19	80.86	4.2	Domates	454
1	517	Meyveler	35.04	0.11	38.89	4.5	Kavun	186
1	518	Tahıllar	18.61	0.12	20.84	3.2	Mısır	357
1	519	Meyveler	27.7	0.15	31.85	4.2	Muz	432
1	520	Tahıllar	19.54	0.1	21.49	3.3	Arpa	309
1	521	Baklagiller	90.24	0.13	101.97	3.6	Fasulye	264
1	522	Sebzeler	55.73	0.07	59.63	4.7	Biber	470
1	523	Baklagiller	12.92	0.08	13.95	3	Bakla	228
1	524	Tahıllar	6.86	0.11	7.61	4	Buğday	471
1	525	Baklagiller	95.33	0.19	113.44	4.3	Nohut	336
1	526	Tahıllar	17.82	0.08	19.25	3.4	Arpa	400
1	527	Tahıllar	42.71	0.19	50.82	3.6	Mısır	396
1	528	Meyveler	7.61	0.15	8.75	3.9	Portakal	28
1	529	Baklagiller	7.71	0.11	8.56	3.9	Fasulye	439
1	530	Sebzeler	11.78	0.12	13.19	3.1	Marul	33
1	531	Baklagiller	11.4	0.14	13	3.5	Barbunya	500
1	532	Baklagiller	92.35	0.17	108.05	4.3	Fasulye	24
1	533	Sebzeler	98.63	0.11	109.48	4.9	Marul	285
1	534	Sebzeler	68.82	0.07	73.64	4.4	Patlıcan	53
1	535	Tahıllar	86.4	0.08	93.31	4.7	Mısır	12
1	536	Baklagiller	73.2	0.07	78.32	3.5	Nohut	214
1	537	Sebzeler	71.7	0.17	83.89	4.2	Kabak	111
1	538	Baklagiller	39.9	0.17	46.68	3.6	Nohut	239
1	539	Tahıllar	85.02	0.06	90.12	3.3	Mısır	173
1	540	Baklagiller	54.71	0.19	65.1	3	Fasulye	85
1	541	Meyveler	15.83	0.12	17.73	4.6	Muz	200
1	542	Sebzeler	68.29	0.16	79.22	3.9	Patlıcan	201
1	543	Sebzeler	27.66	0.06	29.32	4.9	Sarımsak	445
1	544	Tahıllar	84.35	0.14	96.16	4.1	Buğday	144
1	545	Meyveler	58.27	0.08	62.93	4.1	Muz	136
1	546	Baklagiller	52.31	0.2	62.77	3.1	Fasulye	60
1	547	Sebzeler	29.1	0.16	33.76	4.1	Patlıcan	153
1	548	Meyveler	83.7	0.11	92.91	3.6	Armut	329
1	549	Sebzeler	63.7	0.15	73.25	4.1	Patlıcan	243
1	550	Baklagiller	30.5	0.06	32.33	3.3	Barbunya	475
1	551	Sebzeler	2.25	0.1	2.48	3.2	Sarımsak	61
1	552	Tahıllar	76.98	0.14	87.76	3.1	Arpa	444
1	553	Sebzeler	74.94	0.12	83.93	3	Havuç	145
1	554	Tahıllar	73.77	0.09	80.41	3.7	Yulaf	414
1	555	Tahıllar	60	0.08	64.8	3.2	Buğday	361
1	556	Meyveler	70.36	0.15	80.91	3.9	Muz	411
1	557	Sebzeler	91.72	0.14	104.56	4.5	Domates	66
1	558	Baklagiller	20.11	0.17	23.53	3.3	Mercimek	193
1	559	Sebzeler	76.27	0.11	84.66	3.4	Biber	347
1	560	Sebzeler	6.08	0.18	7.17	4.2	Marul	432
1	561	Tahıllar	92.61	0.09	100.94	4.5	Mısır	457
1	562	Baklagiller	84.38	0.19	100.41	3.3	Nohut	174
1	563	Baklagiller	6	0.05	6.3	4.8	Nohut	280
1	564	Sebzeler	70.12	0.09	76.43	3.7	Biber	491
1	565	Baklagiller	59.69	0.08	64.47	4.9	Bakla	329
1	566	Tahıllar	51.86	0.12	58.08	3.4	Arpa	346
1	567	Tahıllar	98.11	0.1	107.92	4.2	Yulaf	217
1	568	Baklagiller	84.48	0.09	92.08	3.2	Bakla	443
1	569	Meyveler	21.24	0.09	23.15	4.4	Portakal	314
1	570	Meyveler	53.6	0.06	56.82	5	Üzüm	27
1	571	Sebzeler	63.64	0.07	68.09	3.5	Sarımsak	280
1	572	Sebzeler	77.75	0.17	90.97	3.1	Marul	414
1	573	Tahıllar	33.86	0.11	37.58	3.2	Çavdar	471
1	574	Sebzeler	54.43	0.09	59.33	3	Marul	155
1	575	Baklagiller	82.36	0.13	93.07	3.4	Fasulye	317
1	576	Meyveler	52.43	0.12	58.72	3.6	Çilek	64
1	577	Sebzeler	72.35	0.06	76.69	3.9	Salatalık	154
1	578	Tahıllar	38.77	0.12	43.42	3.8	Buğday	10
1	579	Sebzeler	45.8	0.13	51.75	4.8	Kabak	455
1	580	Tahıllar	66.32	0.13	74.94	3.2	Çavdar	321
1	581	Baklagiller	75.42	0.09	82.21	4.8	Bakla	402
1	582	Baklagiller	37.6	0.06	39.86	4.8	Barbunya	284
1	583	Sebzeler	76.36	0.08	82.47	4.5	Salatalık	242
1	584	Tahıllar	95.32	0.08	102.95	3.2	Mısır	245
1	585	Baklagiller	79.29	0.08	85.63	3.3	Mercimek	22
1	586	Meyveler	4.62	0.17	5.41	4.2	Portakal	13
1	587	Baklagiller	38.1	0.15	43.81	3.7	Bakla	22
1	588	Tahıllar	36.34	0.09	39.61	4.6	Arpa	449
1	589	Baklagiller	13.23	0.16	15.35	5	Bakla	413
1	590	Sebzeler	6.03	0.17	7.06	3.5	Soğan	425
1	591	Baklagiller	40.25	0.11	44.68	4.4	Mercimek	314
1	592	Tahıllar	70.98	0.07	75.95	4.3	Arpa	274
1	593	Sebzeler	52.02	0.09	56.7	4.7	Kabak	123
1	594	Tahıllar	97.76	0.07	104.6	3.5	Buğday	83
1	595	Meyveler	79.09	0.11	87.79	4.5	Muz	418
1	596	Meyveler	65.63	0.13	74.16	4.2	İncir	417
1	597	Tahıllar	34.74	0.19	41.34	3.9	Arpa	253
1	598	Tahıllar	63.19	0.14	72.04	4.8	Mısır	331
1	599	Baklagiller	43.44	0.18	51.26	4.5	Mercimek	275
1	600	Sebzeler	24.8	0.06	26.29	3.2	Salatalık	430
1	601	Meyveler	79.85	0.06	84.64	4.3	Çilek	418
1	602	Meyveler	34.99	0.18	41.29	3.9	Çilek	494
1	603	Sebzeler	22.27	0.05	23.38	3.6	Domates	443
1	604	Meyveler	29.94	0.18	35.33	3.4	İncir	319
1	605	Meyveler	35.33	0.06	37.45	4.9	İncir	195
1	606	Baklagiller	20.86	0.15	23.99	3.5	Bakla	222
1	607	Meyveler	58.32	0.19	69.4	3.4	Kavun	397
1	608	Baklagiller	28.43	0.06	30.14	4.8	Fasulye	226
1	609	Baklagiller	26.23	0.13	29.64	3.3	Fasulye	297
1	610	Tahıllar	89.7	0.09	97.77	4.1	Çavdar	98
1	611	Meyveler	91.54	0.15	105.27	4.7	Muz	46
1	612	Sebzeler	80.24	0.12	89.87	3.3	Biber	167
1	613	Tahıllar	23.87	0.11	26.5	3.6	Arpa	455
1	614	Tahıllar	86.76	0.12	97.17	3.9	Arpa	337
1	615	Baklagiller	46.75	0.1	51.43	3.5	Fasulye	288
1	616	Meyveler	44.97	0.11	49.92	4.6	İncir	491
1	617	Sebzeler	41.21	0.13	46.57	4.7	Soğan	384
1	618	Meyveler	43.97	0.17	51.44	4.7	Kiraz	382
1	619	Meyveler	45.49	0.06	48.22	3.3	İncir	90
1	620	Baklagiller	95.41	0.19	113.54	4.3	Mercimek	370
1	621	Sebzeler	72.48	0.1	79.73	4.5	Domates	357
1	622	Baklagiller	18.79	0.12	21.04	3	Mercimek	268
1	623	Tahıllar	18.51	0.05	19.44	3.8	Çavdar	412
1	624	Baklagiller	93.22	0.13	105.34	3.2	Bakla	161
1	625	Baklagiller	40.33	0.07	43.15	4.5	Mercimek	463
1	626	Tahıllar	68.34	0.17	79.96	3.3	Buğday	488
1	627	Tahıllar	56.49	0.1	62.14	4.3	Yulaf	471
1	628	Sebzeler	74.91	0.14	85.4	3.5	Havuç	186
1	629	Meyveler	27.79	0.06	29.46	4.5	Muz	166
1	630	Meyveler	52.46	0.18	61.9	4	Karpuz	152
1	631	Baklagiller	9.95	0.07	10.65	4.5	Fasulye	199
1	632	Tahıllar	11.48	0.11	12.74	3.7	Mısır	426
1	633	Tahıllar	44.08	0.11	48.93	3.1	Buğday	334
1	634	Meyveler	6.4	0.09	6.98	5	Muz	241
1	635	Meyveler	34.38	0.1	37.82	4.1	İncir	22
1	636	Meyveler	67.86	0.14	77.36	3.1	İncir	234
1	637	Tahıllar	28.71	0.05	30.15	3.8	Çavdar	486
1	638	Tahıllar	3.08	0.16	3.57	4.8	Yulaf	240
1	639	Tahıllar	54.89	0.15	63.12	4.7	Mısır	202
1	640	Sebzeler	88	0.08	95.04	4.5	Biber	364
1	641	Baklagiller	46.75	0.06	49.55	3.7	Fasulye	304
1	642	Baklagiller	35.48	0.15	40.8	4.2	Nohut	474
1	643	Meyveler	64.66	0.07	69.19	3.1	Kavun	254
1	644	Sebzeler	21.86	0.2	26.23	4.6	Biber	491
1	645	Meyveler	77.98	0.09	85	3.8	Kavun	283
1	646	Sebzeler	54.12	0.12	60.61	3.8	Domates	238
1	647	Tahıllar	87.56	0.14	99.82	3.7	Arpa	97
1	648	Sebzeler	52.21	0.16	60.56	4.5	Salatalık	188
1	649	Meyveler	29.47	0.15	33.89	4.1	Kavun	492
1	650	Meyveler	60.13	0.09	65.54	5	Portakal	195
1	651	Meyveler	76.44	0.06	81.03	4.5	Kiraz	61
1	652	Sebzeler	84.81	0.17	99.23	3.9	Sarımsak	449
1	653	Tahıllar	8.61	0.1	9.47	4.2	Mısır	430
1	654	Meyveler	46.86	0.14	53.42	4.8	Muz	49
1	655	Tahıllar	25.96	0.09	28.3	3.5	Buğday	230
1	656	Meyveler	59.09	0.2	70.91	4.4	Üzüm	250
1	657	Meyveler	36.32	0.16	42.13	3.8	Kavun	181
1	658	Meyveler	95.34	0.07	102.01	4.8	Elma	474
1	659	Meyveler	86.32	0.05	90.64	4.4	Portakal	150
1	660	Sebzeler	40.99	0.16	47.55	4.3	Soğan	304
1	661	Tahıllar	77.65	0.08	83.86	4.4	Çavdar	173
1	662	Tahıllar	25.35	0.15	29.15	4.1	Buğday	191
1	663	Baklagiller	80.52	0.17	94.21	3.9	Bakla	225
1	664	Tahıllar	64.51	0.16	74.83	4.9	Çavdar	170
1	665	Baklagiller	60.88	0.18	71.84	4.2	Fasulye	499
1	666	Tahıllar	76.76	0.11	85.2	3.9	Yulaf	337
1	667	Baklagiller	86.14	0.11	95.62	4.8	Barbunya	422
1	668	Meyveler	3.28	0.12	3.67	4	Muz	401
1	669	Baklagiller	42.93	0.06	45.51	3.5	Fasulye	499
1	670	Meyveler	48.89	0.19	58.18	4	Portakal	316
1	671	Tahıllar	43.17	0.18	50.94	3.9	Çavdar	426
1	672	Baklagiller	67.82	0.12	75.96	4.1	Barbunya	74
1	673	Meyveler	34.19	0.11	37.95	4.7	Üzüm	389
1	674	Baklagiller	7.63	0.07	8.16	4.3	Bakla	411
1	675	Sebzeler	89.65	0.05	94.13	3.3	Soğan	423
1	676	Tahıllar	52	0.15	59.8	3.8	Arpa	470
1	677	Baklagiller	89.6	0.08	96.77	3.3	Barbunya	363
1	678	Baklagiller	72.83	0.13	82.3	3.9	Mercimek	80
1	679	Baklagiller	16.27	0.08	17.57	3.1	Nohut	139
1	680	Baklagiller	61.57	0.13	69.57	3.8	Barbunya	306
1	681	Sebzeler	22.63	0.16	26.25	4.9	Kabak	274
1	682	Baklagiller	18.51	0.07	19.81	3.2	Nohut	351
1	683	Sebzeler	39.27	0.17	45.95	5	Sarımsak	111
1	684	Sebzeler	80.05	0.07	85.65	4.4	Patlıcan	89
1	685	Tahıllar	92.25	0.09	100.55	4.3	Çavdar	156
1	686	Sebzeler	63.19	0.18	74.56	4.5	Ispanak	232
1	687	Sebzeler	37.89	0.16	43.95	4	Soğan	430
1	688	Tahıllar	50.33	0.13	56.87	5	Buğday	386
1	689	Sebzeler	25.88	0.1	28.47	3.5	Biber	147
1	690	Sebzeler	38.1	0.06	40.39	4.3	Kabak	117
1	691	Baklagiller	61.29	0.09	66.81	4.8	Bakla	193
1	692	Baklagiller	2.28	0.12	2.55	4.1	Fasulye	166
1	693	Sebzeler	15.7	0.11	17.43	4.6	Patlıcan	220
1	694	Meyveler	49.42	0.15	56.83	3.5	Karpuz	48
1	695	Sebzeler	64.51	0.14	73.54	4.7	Marul	118
1	696	Tahıllar	90.92	0.17	106.38	3.7	Çavdar	430
1	697	Meyveler	98.52	0.09	107.39	3.1	Üzüm	265
1	698	Sebzeler	32.62	0.15	37.51	3.3	Ispanak	147
1	699	Baklagiller	56.54	0.12	63.32	3.2	Nohut	209
1	700	Tahıllar	2.17	0.14	2.47	3.7	Buğday	279
1	701	Meyveler	73.39	0.07	78.53	4.8	Kiraz	14
1	702	Baklagiller	20.76	0.08	22.42	3.2	Nohut	442
1	703	Tahıllar	71.43	0.13	80.72	3.7	Yulaf	370
1	704	Tahıllar	85.23	0.15	98.01	4.8	Buğday	118
1	705	Sebzeler	7.51	0.17	8.79	4.4	Havuç	129
1	706	Tahıllar	62.36	0.17	72.96	3.2	Çavdar	495
1	707	Sebzeler	55.84	0.2	67.01	3.8	Ispanak	149
1	708	Meyveler	88.8	0.18	104.78	3.9	İncir	468
1	709	Baklagiller	68.56	0.14	78.16	4.9	Nohut	59
1	710	Meyveler	2.59	0.19	3.08	3.2	İncir	192
1	711	Sebzeler	46.09	0.07	49.32	3	Sarımsak	203
1	712	Baklagiller	30.44	0.06	32.27	3.5	Bakla	55
1	713	Baklagiller	35.57	0.11	39.48	3.8	Mercimek	310
1	714	Sebzeler	91.47	0.14	104.28	4.1	Marul	490
1	715	Sebzeler	44.42	0.15	51.08	4.5	Marul	460
1	716	Meyveler	32.89	0.11	36.51	4.2	Elma	487
1	717	Tahıllar	72.71	0.19	86.52	4.9	Çavdar	97
1	718	Baklagiller	53.01	0.15	60.96	3.6	Nohut	106
1	719	Sebzeler	23.38	0.18	27.59	4.2	Soğan	495
1	720	Tahıllar	20.68	0.09	22.54	4.5	Buğday	331
1	721	Sebzeler	95.3	0.11	105.78	3.8	Marul	370
1	722	Sebzeler	85.87	0.06	91.02	4.9	Salatalık	216
1	723	Meyveler	35.25	0.2	42.3	4	İncir	319
1	724	Tahıllar	95.92	0.17	112.23	3.6	Yulaf	105
1	725	Baklagiller	73.7	0.19	87.7	4.1	Mercimek	230
1	726	Baklagiller	39.18	0.14	44.67	3.3	Barbunya	178
1	727	Meyveler	93.99	0.15	108.09	4.5	Muz	422
1	728	Meyveler	86.26	0.11	95.75	3.1	Karpuz	204
1	729	Tahıllar	81.68	0.2	98.02	3.7	Buğday	419
1	730	Sebzeler	30.05	0.09	32.75	4	Soğan	36
1	731	Sebzeler	67.67	0.1	74.44	4.1	Havuç	23
1	732	Meyveler	8.3	0.19	9.88	4.6	Üzüm	250
1	733	Baklagiller	10	0.09	10.9	3.3	Bakla	240
1	734	Meyveler	37.72	0.14	43	3.3	Kavun	218
1	735	Meyveler	79.11	0.14	90.19	5	Üzüm	244
1	736	Sebzeler	80.69	0.19	96.02	3.7	Patlıcan	236
1	737	Sebzeler	13.95	0.15	16.04	3.8	Patlıcan	61
1	738	Tahıllar	16.26	0.07	17.4	3.7	Mısır	177
1	739	Baklagiller	99.22	0.13	112.12	4.4	Mercimek	277
1	740	Baklagiller	91.93	0.08	99.28	4.9	Barbunya	73
1	741	Baklagiller	31.89	0.15	36.67	3.6	Fasulye	426
1	742	Meyveler	58.59	0.16	67.96	3.8	Çilek	400
1	743	Meyveler	35.53	0.06	37.66	3.8	İncir	35
1	744	Meyveler	37.52	0.11	41.65	3	Muz	454
1	745	Sebzeler	24.6	0.13	27.8	4.9	Sarımsak	179
1	746	Meyveler	14.91	0.08	16.1	4.8	Karpuz	325
1	747	Sebzeler	11.59	0.19	13.79	3.7	Havuç	181
1	748	Sebzeler	33.65	0.17	39.37	3.8	Domates	162
1	749	Tahıllar	23.96	0.19	28.51	4.1	Arpa	63
1	750	Meyveler	74.88	0.14	85.36	3.5	Elma	45
1	751	Tahıllar	96.14	0.1	105.75	3.5	Çavdar	306
1	752	Baklagiller	9.03	0.12	10.11	4.1	Mercimek	250
1	753	Sebzeler	32.22	0.08	34.8	3.1	Marul	349
1	754	Sebzeler	94.62	0.14	107.87	3.3	Salatalık	348
1	755	Tahıllar	1.56	0.1	1.72	3.4	Mısır	330
1	756	Baklagiller	34.88	0.08	37.67	3	Barbunya	101
1	757	Sebzeler	61.22	0.09	66.73	4.6	Havuç	448
1	758	Meyveler	51.41	0.1	56.55	4.6	Elma	408
1	759	Sebzeler	80.1	0.16	92.92	3.2	Domates	403
1	760	Tahıllar	71.63	0.06	75.93	3.2	Mısır	412
1	761	Tahıllar	47.96	0.08	51.8	4.8	Buğday	87
1	762	Tahıllar	42.74	0.13	48.3	4.7	Çavdar	64
1	763	Baklagiller	58.15	0.08	62.8	3	Fasulye	421
1	764	Baklagiller	83.02	0.1	91.32	4.3	Mercimek	334
1	765	Meyveler	87.94	0.06	93.22	3.8	Karpuz	97
1	766	Sebzeler	70.42	0.18	83.1	4.6	Kabak	170
1	767	Tahıllar	61.98	0.15	71.28	4.2	Arpa	491
1	768	Meyveler	99.94	0.16	115.93	4.3	Armut	256
1	769	Baklagiller	74.26	0.14	84.66	4.7	Mercimek	128
1	770	Meyveler	42.53	0.12	47.63	4.7	Portakal	436
1	771	Baklagiller	25.99	0.16	30.15	3.2	Fasulye	168
1	772	Baklagiller	92.68	0.14	105.66	4.3	Barbunya	203
1	773	Tahıllar	37.08	0.08	40.05	4.6	Çavdar	19
1	774	Tahıllar	67.84	0.06	71.91	3.3	Yulaf	217
1	775	Baklagiller	40.29	0.05	42.3	3.9	Nohut	35
1	776	Tahıllar	97.9	0.08	105.73	5	Çavdar	139
1	777	Tahıllar	60.53	0.14	69	3.6	Mısır	232
1	778	Meyveler	61.57	0.08	66.5	3.7	Muz	196
1	779	Meyveler	3.19	0.12	3.57	3.3	Portakal	106
1	780	Tahıllar	89.37	0.09	97.41	3.9	Çavdar	474
1	781	Baklagiller	40.42	0.06	42.85	4.5	Mercimek	207
1	782	Sebzeler	52.45	0.2	62.94	3	Havuç	343
1	783	Meyveler	6.05	0.07	6.47	4.2	Portakal	73
1	784	Tahıllar	43.88	0.19	52.22	3.5	Mısır	359
1	785	Baklagiller	23.19	0.1	25.51	4.5	Fasulye	233
1	786	Sebzeler	41	0.12	45.92	3.1	Biber	105
1	787	Baklagiller	56.82	0.13	64.21	3.6	Barbunya	481
1	788	Meyveler	25.53	0.12	28.59	4.4	Üzüm	232
1	789	Baklagiller	56.33	0.12	63.09	3.6	Fasulye	120
1	790	Sebzeler	39.95	0.06	42.35	4.2	Soğan	354
1	791	Sebzeler	19.04	0.05	19.99	3.2	Domates	284
1	792	Tahıllar	85.02	0.15	97.77	4.9	Yulaf	339
1	793	Baklagiller	70.39	0.2	84.47	4.5	Mercimek	170
1	794	Meyveler	57.17	0.1	62.89	5	Muz	87
1	795	Baklagiller	3.05	0.2	3.66	4.7	Fasulye	107
1	796	Sebzeler	57.21	0.07	61.21	3.3	Ispanak	451
1	797	Tahıllar	78.16	0.09	85.19	4.4	Mısır	361
1	798	Meyveler	85.4	0.1	93.94	3.5	Portakal	386
1	799	Meyveler	77.59	0.1	85.35	4.7	Elma	369
1	800	Meyveler	59.67	0.18	70.41	3.9	İncir	162
1	801	Baklagiller	26.64	0.1	29.3	3.4	Nohut	209
1	802	Sebzeler	87.74	0.07	93.88	3.3	Salatalık	466
1	803	Sebzeler	31.21	0.12	34.96	4.3	Soğan	246
1	804	Tahıllar	25.93	0.17	30.34	4.4	Arpa	255
1	805	Baklagiller	63.47	0.07	67.91	4.8	Mercimek	295
1	806	Baklagiller	64.66	0.17	75.65	4.8	Nohut	138
1	807	Tahıllar	38.18	0.06	40.47	4.3	Buğday	104
1	808	Tahıllar	70.18	0.15	80.71	4.6	Arpa	480
1	809	Meyveler	57.03	0.17	66.73	4.8	İncir	90
1	810	Baklagiller	82.12	0.09	89.51	3.1	Fasulye	210
1	811	Tahıllar	38.04	0.05	39.94	4	Mısır	15
1	812	Baklagiller	50.99	0.11	56.6	4.3	Fasulye	431
1	813	Sebzeler	37.54	0.16	43.55	4.7	Sarımsak	348
1	814	Tahıllar	40.15	0.08	43.36	4.2	Yulaf	434
1	815	Meyveler	63.23	0.05	66.39	4	Elma	271
1	816	Baklagiller	9.73	0.18	11.48	3.6	Barbunya	272
1	817	Sebzeler	74.49	0.1	81.94	3.6	Marul	456
1	818	Sebzeler	42.89	0.15	49.32	4.6	Marul	140
1	819	Sebzeler	67.9	0.14	77.41	4.3	Ispanak	295
1	820	Meyveler	53.46	0.14	60.94	3.5	Çilek	186
1	821	Meyveler	43.57	0.14	49.67	3.6	İncir	453
1	822	Tahıllar	40.31	0.09	43.94	3.4	Arpa	489
1	823	Meyveler	55.77	0.18	65.81	4.7	Elma	290
1	824	Baklagiller	27.97	0.13	31.61	4.5	Barbunya	453
1	825	Meyveler	8.56	0.19	10.19	4.1	Üzüm	144
1	826	Sebzeler	5	0.19	5.95	4.8	Patlıcan	447
1	827	Sebzeler	17.2	0.16	19.95	4.8	Marul	332
1	828	Baklagiller	59.3	0.06	62.86	3.1	Barbunya	491
1	829	Sebzeler	8.23	0.16	9.55	4.3	Ispanak	255
1	830	Baklagiller	5.19	0.13	5.86	3.1	Fasulye	372
1	831	Meyveler	33.08	0.16	38.37	4.1	Üzüm	110
1	832	Sebzeler	84.18	0.15	96.81	4.5	Domates	112
1	833	Meyveler	79.91	0.19	95.09	4.4	İncir	316
1	834	Sebzeler	88.87	0.09	96.87	4.7	Kabak	246
1	835	Tahıllar	96.95	0.06	102.77	4.2	Arpa	57
1	836	Sebzeler	17.41	0.1	19.15	3.3	Domates	207
1	837	Tahıllar	2.55	0.08	2.75	4.7	Çavdar	252
1	838	Baklagiller	23.21	0.05	24.37	3.6	Barbunya	221
1	839	Tahıllar	62.53	0.19	74.41	4.3	Buğday	209
1	840	Meyveler	4.24	0.07	4.54	3.2	Kiraz	234
1	841	Sebzeler	10.96	0.18	12.93	3.2	Ispanak	162
1	842	Meyveler	43.83	0.17	51.28	3.3	Kiraz	391
1	843	Meyveler	48.49	0.1	53.34	4.6	Kiraz	238
1	844	Sebzeler	40.01	0.19	47.61	3.2	Kabak	327
1	845	Tahıllar	28.96	0.07	30.99	4.4	Mısır	13
1	846	Sebzeler	96.94	0.17	113.42	3.3	Kabak	399
1	847	Meyveler	60.23	0.16	69.87	4.2	Çilek	26
1	848	Tahıllar	41.72	0.17	48.81	4.7	Çavdar	410
1	849	Tahıllar	28.17	0.09	30.71	4.8	Arpa	425
1	850	Meyveler	63.01	0.08	68.05	4.3	Karpuz	392
1	851	Baklagiller	78.89	0.18	93.09	3	Barbunya	140
1	852	Tahıllar	32.33	0.18	38.15	4.4	Buğday	373
1	853	Meyveler	64.83	0.06	68.72	3.5	Kavun	37
1	854	Baklagiller	88.21	0.11	97.91	4.7	Bakla	255
1	855	Sebzeler	25.71	0.08	27.77	3.4	Kabak	43
1	856	Tahıllar	5.51	0.11	6.12	3.2	Yulaf	267
1	857	Meyveler	40.44	0.16	46.91	3.2	İncir	109
1	858	Sebzeler	53	0.13	59.89	4.8	Soğan	127
1	859	Sebzeler	32.76	0.07	35.05	4	Patlıcan	138
1	860	Baklagiller	42.76	0.14	48.75	4.6	Bakla	416
1	861	Baklagiller	67.27	0.12	75.34	4.3	Bakla	339
1	862	Meyveler	20.43	0.2	24.52	4.7	Muz	485
1	863	Tahıllar	34.69	0.08	37.47	4.2	Arpa	234
1	864	Meyveler	42.63	0.16	49.45	4	Armut	344
1	865	Sebzeler	99.74	0.16	115.7	4.3	Sarımsak	96
1	866	Baklagiller	89.04	0.11	98.83	3.2	Nohut	438
1	867	Tahıllar	12.41	0.18	14.64	4.8	Arpa	235
1	868	Tahıllar	74.51	0.14	84.94	3.1	Yulaf	105
1	869	Sebzeler	71.7	0.15	82.45	4.7	Sarımsak	400
1	870	Baklagiller	22.86	0.1	25.15	3.8	Nohut	412
1	871	Baklagiller	59.29	0.06	62.85	3.6	Nohut	357
1	872	Baklagiller	58.29	0.12	65.28	4.4	Fasulye	394
1	873	Meyveler	62.03	0.15	71.33	3.6	Armut	303
1	874	Tahıllar	17.38	0.18	20.51	3.1	Yulaf	447
1	875	Tahıllar	4.12	0.17	4.82	3.8	Yulaf	344
1	876	Baklagiller	56.7	0.07	60.67	4	Barbunya	482
1	877	Baklagiller	10.77	0.16	12.49	3.4	Barbunya	166
1	878	Tahıllar	40.73	0.05	42.77	4.3	Buğday	428
1	879	Baklagiller	21.51	0.08	23.23	3.6	Fasulye	195
1	880	Baklagiller	33.6	0.14	38.3	4.6	Nohut	350
1	881	Baklagiller	28.89	0.06	30.62	4.3	Mercimek	422
1	882	Tahıllar	9.44	0.2	11.33	3.3	Çavdar	420
1	883	Meyveler	59.12	0.11	65.62	3.9	Kavun	426
1	884	Tahıllar	58.52	0.09	63.79	3.5	Arpa	472
1	885	Sebzeler	48.54	0.09	52.91	4.1	Domates	134
1	886	Tahıllar	57.72	0.06	61.18	4.1	Arpa	286
1	887	Baklagiller	18.11	0.08	19.56	3.4	Nohut	493
1	888	Meyveler	26.04	0.09	28.38	3.6	Portakal	110
1	889	Meyveler	34.26	0.1	37.69	3.1	İncir	275
1	890	Tahıllar	21.68	0.1	23.85	4.1	Arpa	188
1	891	Baklagiller	60.63	0.13	68.51	3.3	Fasulye	62
1	892	Meyveler	46.71	0.17	54.65	3.5	Muz	401
1	893	Sebzeler	54.23	0.13	61.28	3.5	Patlıcan	440
1	894	Meyveler	72.6	0.15	83.49	3.6	Muz	222
1	895	Tahıllar	11.51	0.09	12.55	3.8	Çavdar	321
1	896	Baklagiller	21.84	0.06	23.15	3.2	Nohut	81
1	897	Sebzeler	94.86	0.06	100.55	3.2	Havuç	371
1	898	Meyveler	83.61	0.09	91.13	3.6	Kiraz	238
1	899	Meyveler	97.67	0.06	103.53	4.5	Muz	196
1	900	Meyveler	27.08	0.16	31.41	5	Kiraz	193
1	901	Sebzeler	82.83	0.06	87.8	3.5	Havuç	171
1	902	Baklagiller	26.4	0.2	31.68	4.1	Nohut	426
1	903	Sebzeler	15.22	0.18	17.96	3.3	Ispanak	83
1	904	Sebzeler	29.13	0.17	34.08	3.9	Ispanak	167
1	905	Tahıllar	27.13	0.2	32.56	4.7	Mısır	301
1	906	Baklagiller	76.71	0.06	81.31	4.3	Nohut	301
1	907	Meyveler	96.12	0.07	102.85	3.1	Kiraz	86
1	908	Tahıllar	5.48	0.15	6.3	4.3	Çavdar	10
1	909	Meyveler	72.86	0.06	77.23	4.5	Armut	185
1	910	Sebzeler	59.35	0.14	67.66	4.5	Sarımsak	249
1	911	Tahıllar	46.57	0.15	53.56	5	Mısır	66
1	912	Sebzeler	32.81	0.18	38.72	3	Soğan	168
1	913	Meyveler	47.92	0.11	53.19	4.2	Karpuz	455
1	914	Meyveler	11.1	0.09	12.1	3.7	Portakal	115
1	915	Meyveler	23.28	0.1	25.61	3.3	Elma	378
1	916	Tahıllar	77.8	0.15	89.47	3.9	Yulaf	96
1	917	Sebzeler	43.95	0.12	49.22	4.3	Sarımsak	455
1	918	Meyveler	19.01	0.19	22.62	4.6	Armut	456
1	919	Tahıllar	80.33	0.11	89.17	3.8	Buğday	241
1	920	Meyveler	24.44	0.19	29.08	3.2	Kiraz	486
1	921	Meyveler	93.87	0.08	101.38	4	Elma	10
1	922	Meyveler	99.7	0.05	104.69	5	Portakal	427
1	923	Tahıllar	99.82	0.09	108.8	3.1	Arpa	387
1	924	Baklagiller	45.21	0.09	49.28	3.6	Bakla	360
1	925	Tahıllar	71.21	0.09	77.62	3.7	Buğday	319
1	926	Sebzeler	39.56	0.1	43.52	4.2	Domates	134
1	927	Baklagiller	58.71	0.1	64.58	3	Bakla	340
1	928	Meyveler	34.1	0.15	39.21	4.5	Muz	340
1	929	Baklagiller	55.9	0.11	62.05	4.3	Fasulye	330
1	930	Sebzeler	97.65	0.12	109.37	3.1	Ispanak	280
1	931	Sebzeler	1.89	0.18	2.23	3.2	Biber	118
1	932	Tahıllar	21.94	0.13	24.79	3.3	Yulaf	389
1	933	Tahıllar	51.88	0.14	59.14	4.9	Yulaf	142
1	934	Sebzeler	35.18	0.18	41.51	4.5	Domates	448
1	935	Tahıllar	23.76	0.1	26.14	3.4	Mısır	190
1	936	Tahıllar	16.15	0.1	17.77	4.1	Buğday	411
1	937	Baklagiller	89.83	0.07	96.12	3.7	Fasulye	52
1	938	Baklagiller	71.15	0.13	80.4	3.1	Fasulye	478
1	939	Baklagiller	20.23	0.07	21.65	3.9	Barbunya	286
1	940	Tahıllar	60.07	0.15	69.08	3.7	Çavdar	150
1	941	Meyveler	77.87	0.14	88.77	3.4	Elma	316
1	942	Tahıllar	45.39	0.06	48.11	3.1	Mısır	38
1	943	Sebzeler	48.47	0.07	51.86	4.2	Havuç	93
1	944	Meyveler	30.99	0.19	36.88	3.3	Kiraz	438
1	945	Sebzeler	39.05	0.09	42.56	3.5	Sarımsak	298
1	946	Tahıllar	58.23	0.15	66.96	4	Arpa	123
1	947	Sebzeler	52.99	0.17	62	4.7	Marul	496
1	948	Sebzeler	44.65	0.13	50.45	3.8	Havuç	284
1	949	Baklagiller	28.39	0.19	33.78	4	Fasulye	87
1	950	Baklagiller	79.53	0.08	85.89	4.7	Bakla	407
1	951	Sebzeler	93.12	0.06	98.71	4.7	Patlıcan	309
1	952	Baklagiller	75.89	0.09	82.72	4.3	Bakla	474
1	953	Baklagiller	32.6	0.14	37.16	4.7	Mercimek	251
1	954	Baklagiller	54.16	0.08	58.49	3.3	Bakla	408
1	955	Meyveler	19.12	0.11	21.22	4.3	Karpuz	160
1	956	Tahıllar	81.01	0.2	97.21	4.7	Yulaf	79
1	957	Sebzeler	53.34	0.16	61.87	3.5	Marul	67
1	958	Sebzeler	70.59	0.18	83.3	4.1	Ispanak	296
1	959	Baklagiller	96.8	0.17	113.26	4.5	Mercimek	394
1	960	Meyveler	53.37	0.08	57.64	4.6	Portakal	64
1	961	Sebzeler	63.62	0.18	75.07	3.6	Ispanak	437
1	962	Baklagiller	31.7	0.09	34.55	4	Fasulye	348
1	963	Meyveler	55.31	0.08	59.73	3.2	Muz	370
1	964	Sebzeler	56.74	0.14	64.68	3.3	Sarımsak	459
1	965	Meyveler	50.4	0.19	59.98	3.6	Muz	399
1	966	Sebzeler	59.19	0.17	69.25	3.8	Salatalık	486
1	967	Baklagiller	46.79	0.18	55.21	3.9	Bakla	306
1	968	Baklagiller	1.73	0.2	2.08	4.4	Mercimek	403
1	969	Tahıllar	12.8	0.12	14.34	3.6	Mısır	256
1	970	Sebzeler	29.12	0.19	34.65	3.3	Havuç	218
1	971	Sebzeler	47.24	0.18	55.74	3	Domates	173
1	972	Tahıllar	96.16	0.1	105.78	3.4	Çavdar	40
1	973	Baklagiller	63.48	0.19	75.54	4.2	Barbunya	366
1	974	Baklagiller	30.87	0.08	33.34	3.1	Bakla	190
1	975	Tahıllar	57.88	0.15	66.56	3.4	Arpa	250
1	976	Tahıllar	90.81	0.06	96.26	3.7	Mısır	41
1	977	Baklagiller	1.35	0.18	1.59	3.1	Barbunya	352
1	978	Tahıllar	81.29	0.14	92.67	4.9	Arpa	239
1	979	Sebzeler	73.78	0.14	84.11	4.5	Kabak	281
1	980	Meyveler	67.74	0.11	75.19	4.6	İncir	235
1	981	Baklagiller	86.13	0.2	103.36	4.3	Bakla	331
1	982	Meyveler	30.42	0.2	36.5	3.5	Kiraz	207
1	983	Baklagiller	56.7	0.2	68.04	4.1	Mercimek	147
1	984	Tahıllar	56.1	0.19	66.76	4.2	Mısır	323
1	985	Sebzeler	84.69	0.15	97.39	4.9	Havuç	332
1	986	Baklagiller	66.2	0.13	74.81	3.9	Bakla	189
1	987	Tahıllar	61.12	0.16	70.9	4	Mısır	399
1	988	Meyveler	93.44	0.07	99.98	4.9	Üzüm	497
1	989	Meyveler	11.64	0.1	12.8	3.5	Portakal	107
1	990	Baklagiller	62.89	0.13	71.07	4.2	Mercimek	230
1	991	Sebzeler	6.36	0.11	7.06	3.3	Kabak	321
1	992	Baklagiller	22.68	0.08	24.49	3.4	Barbunya	81
1	993	Meyveler	98.88	0.06	104.81	4.2	İncir	126
1	994	Meyveler	10.86	0.1	11.95	4.4	Armut	443
1	995	Baklagiller	54.4	0.09	59.3	4.1	Barbunya	159
1	996	Tahıllar	55.71	0.08	60.17	4.9	Mısır	303
1	997	Meyveler	12.12	0.17	14.18	3.4	Kiraz	115
1	998	Meyveler	97.05	0.06	102.87	4.8	Muz	428
1	999	Meyveler	71.44	0.08	77.16	4.8	Portakal	60
1	1000	Baklagiller	59.3	0.07	63.45	4.9	Nohut	84
1	1001	Baklagiller	82.88	0.09	90.34	4.4	Bakla	68
1	1002	Meyveler	96.05	0.18	113.34	3.9	Armut	490
1	1003	Tahıllar	84.51	0.14	96.34	4.4	Arpa	448
1	1004	Baklagiller	78.58	0.18	92.72	4.8	Fasulye	367
\.


--
-- TOC entry 4055 (class 0 OID 61856)
-- Dependencies: 321
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, product_name, product_katalog_name, image_url, created_at, updated_at, farmer_id, farmer_price, tarladan_commission, tarladan_price, stock_quantity) FROM stdin;
b81fae0a-d920-4155-9bc4-d0101d8ac6d1	ayva	ayva	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/b81fae0a-d920-4155-9bc4-d0101d8ac6d1.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy9iODFmYWUwYS1kOTIwLTQxNTUtOWJjNC1kMDEwMWQ4YWM2ZDEuanBnIiwiaWF0IjoxNzQ5MTE4NTk3LCJleHAiOjMzMjU5MTg1OTd9.fSGGkgNzuH3kNjBv0f6opAtMvJKwiFYXPeK9QkwOrtg	2025-06-05 10:16:37.319707	2025-06-16 15:26:16.847	46	37	6	38.85	1500
6e4e7882-70f5-4c13-b12e-1882e858606f	Ankara kirazı	fruit	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/6e4e7882-70f5-4c13-b12e-1882e858606f.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy82ZTRlNzg4Mi03MGY1LTRjMTMtYjEyZS0xODgyZTg1ODYwNmYuanBnIiwiaWF0IjoxNzQ4ODYyOTc1LCJleHAiOjMzMjU2NjI5NzV9.80JRpfvsQWIKSQ9T-XiPw-YqOrGFtEQOM5iFj726vYM	2025-06-02 11:16:15.603404	2025-06-02 11:16:15.603404	47	12	2	14	150
42067206-de49-4b97-8008-c2fedd8b5248	kavun	fruit	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/42067206-de49-4b97-8008-c2fedd8b5248.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy80MjA2NzIwNi1kZTQ5LTRiOTctODAwOC1jMmZlZGQ4YjUyNDguanBnIiwiaWF0IjoxNzQ4ODU5ODQ5LCJleHAiOjMzMjU2NTk4NDl9.RHxDxHVaPK9hm2AztzbVwpdBsR86jVqbf3wqk69BV5o	2025-06-02 10:24:08.353304	2025-06-02 10:24:08.353304	46	22	2	24	11
58b1f530-f7bb-4b6e-9e0d-c1730cec59bc	Vişne kan kırmızısı	vişne	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/58b1f530-f7bb-4b6e-9e0d-c1730cec59bc.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5Xzk4ODM5Mjg2LTFmMDgtNGJlNC1hNzY1LTdkZTBmNzI1NTlmNyJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy81OGIxZjUzMC1mN2JiLTRiNmUtOWUwZC1jMTczMGNlYzU5YmMuanBnIiwiaWF0IjoxNzQ4ODEyNTMwLCJleHAiOjMzMjU2MTI1MzB9.P0SkKJYr578YWae3RPDCfckSPkVWBSErPDiQPkgMQoc	2025-06-01 21:15:29.998775	2025-06-01 21:15:29.998775	49	14	2	16	180
a6871afe-b121-45fb-8969-38661cf1d9f2	 Taze Çilek	çilek	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product.images/Cilek.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5Xzk4ODM5Mjg2LTFmMDgtNGJlNC1hNzY1LTdkZTBmNzI1NTlmNyJ9.eyJ1cmwiOiJwcm9kdWN0LmltYWdlcy9DaWxlay5wbmciLCJpYXQiOjE3NDg2MjQ5NTEsImV4cCI6MzMyNTQyNDk1MX0.GjjsNu7h7VL9RMxa5KvlRTpPx4j8o3d0XLVA2ORGWVw	2025-05-30 17:08:12.475689	2025-05-30 17:08:12.475689	46	22	3	25	0
427a407a-5041-49fe-b05d-6df69f84e6ef	havuç	vegetable	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/427a407a-5041-49fe-b05d-6df69f84e6ef.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy80MjdhNDA3YS01MDQxLTQ5ZmUtYjA1ZC02ZGY2OWY4NGU2ZWYuanBnIiwiaWF0IjoxNzQ4ODYzMTIxLCJleHAiOjMzMjU2NjMxMjF9.WQ75aTRfdF8CakztSYBYvvb4gqXnWhy2YBpo7dZOJfg	2025-06-02 11:18:41.313962	2025-06-02 11:18:41.313962	47	18	4	22	30
cdf871e1-b6e3-4c17-8c7b-6c6457f5fb89	ayva	fruit	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/cdf871e1-b6e3-4c17-8c7b-6c6457f5fb89.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5Xzk4ODM5Mjg2LTFmMDgtNGJlNC1hNzY1LTdkZTBmNzI1NTlmNyJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy9jZGY4NzFlMS1iNmUzLTRjMTctOGM3Yi02YzY0NTdmNWZiODkuanBnIiwiaWF0IjoxNzQ4Nzk1MTc0LCJleHAiOjMzMjU1OTUxNzR9.c3_ehPgFZxHhcyuSGk1kVqZs5EDdkNSss-H47E04sgE	2025-06-01 15:34:25.248727	2025-06-01 15:34:25.248727	49	24	4	28	190
cdc0dc07-513f-4b51-8611-e474b33faf8f	ayva	ayva	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/cdc0dc07-513f-4b51-8611-e474b33faf8f.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy9jZGMwZGMwNy01MTNmLTRiNTEtODYxMS1lNDc0YjMzZmFmOGYuanBnIiwiaWF0IjoxNzQ5NTYyOTAxLCJleHAiOjMzMjYzNjI5MDF9.rmjVhHzMIy5t6btG_7AeLpPxkgijBBOx5lu7Hn9nLGs	2025-06-10 13:41:40.722544	2025-06-10 13:41:40.722544	47	10	2	12	160
bb12e629-5e60-48b6-853e-9fc18158be97	adana karpuz	karpuz	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/bb12e629-5e60-48b6-853e-9fc18158be97.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy9iYjEyZTYyOS01ZTYwLTQ4YjYtODUzZS05ZmMxODE1OGJlOTcuanBnIiwiaWF0IjoxNzQ5NTYyMzM4LCJleHAiOjMzMjYzNjIzMzh9.Rm68vVlD10Rz9JXmAmbhZazG21brmxJcBKhycSh3LVg	2025-06-10 13:32:18.365918	2025-06-10 13:32:18.365918	29	18	3	21	60
4910648f-8309-483d-8c33-515997c4e276	Tatlı Biber	grain	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/4910648f-8309-483d-8c33-515997c4e276.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy80OTEwNjQ4Zi04MzA5LTQ4M2QtOGMzMy01MTU5OTdjNGUyNzYuanBnIiwiaWF0IjoxNzQ4ODY0Njg3LCJleHAiOjMzMjU2NjQ2ODd9.PzPAtI1gsfRAL3314elD2bgCRcJF0qU3WoV4V59EmJM	2025-06-02 11:44:47.105901	2025-06-02 11:44:47.105901	49	25	4	29	110
46f1f768-db28-450d-9217-42073cc6b3d0	Karpuz	karpuz	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/46f1f768-db28-450d-9217-42073cc6b3d0.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5Xzk4ODM5Mjg2LTFmMDgtNGJlNC1hNzY1LTdkZTBmNzI1NTlmNyJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy80NmYxZjc2OC1kYjI4LTQ1MGQtOTIxNy00MjA3M2NjNmIzZDAuanBnIiwiaWF0IjoxNzQ4ODA3NDgxLCJleHAiOjMzMjU2MDc0ODF9.0ISq1w-SCljO4-Fp8vpciwASTV3sv8QAezR661QIlAw	2025-06-01 19:51:21.509209	2025-06-13 21:46:32.153	46	30	5	31.5	40
df99d0b3-962a-4b61-a4f7-6e5f104a2fb0	ayva	ayva	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/df99d0b3-962a-4b61-a4f7-6e5f104a2fb0.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy9kZjk5ZDBiMy05NjJhLTRiNjEtYTRmNy02ZTVmMTA0YTJmYjAuanBnIiwiaWF0IjoxNzQ4OTcyNjEzLCJleHAiOjMzMjU3NzI2MTN9.z5GwI4ZW5tUsrEnAyGTA0Dbc9-8DLRHpybrIuN0bupQ	2025-06-03 17:43:33.051632	2025-06-03 17:43:33.051632	47	27	4	31	15
9c450baa-e7b3-47fd-a562-08f755bd1c6d	ananas	ananas	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/9c450baa-e7b3-47fd-a562-08f755bd1c6d.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy85YzQ1MGJhYS1lN2IzLTQ3ZmQtYTU2Mi0wOGY3NTViZDFjNmQuanBnIiwiaWF0IjoxNzQ5ODUxNDI4LCJleHAiOjMzMjY2NTE0Mjh9.nwYr3AvpJccSRK8f5WihVPG0v8pQCTTsGtAzPRXYGiE	\N	\N	46	2	5	2.1	3232
99d078ce-9a24-43f5-a881-ed22a1457a0d	karnabahar	karnabahar	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/99d078ce-9a24-43f5-a881-ed22a1457a0d.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy85OWQwNzhjZS05YTI0LTQzZjUtYTg4MS1lZDIyYTE0NTdhMGQuanBnIiwiaWF0IjoxNzQ5ODUxODYyLCJleHAiOjMzMjY2NTE4NjJ9.8Copu676959h6LZ1ef0zwyCj7M7Dk9_VkzaZwhXs62k	\N	2025-06-14 13:36:20.797	47	20	5	21	24000
f29b7a63-df53-48e5-87e1-a9e4ea88bc4a	karpuz	karpuz	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/f29b7a63-df53-48e5-87e1-a9e4ea88bc4a.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy9mMjliN2E2My1kZjUzLTQ4ZTUtODdlMS1hOWU0ZWE4OGJjNGEuanBnIiwiaWF0IjoxNzUwMDgwNzY0LCJleHAiOjMzMjY4ODA3NjR9.Yrt_umRI3XvgVDoiRASovv42rO-LDlJwhpEg3fQxUEI	\N	\N	47	20	5	21	25000
7cbfec54-891d-4970-8979-407ea57f7e44	Taze Domates	domates	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/7cbfec54-891d-4970-8979-407ea57f7e44.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy83Y2JmZWM1NC04OTFkLTQ5NzAtODk3OS00MDdlYTU3ZjdlNDQuanBnIiwiaWF0IjoxNzUwMDgxNjk5LCJleHAiOjMzMjY4ODE2OTl9.1ikvruFZYohAP6-QqqscYOYESRJ8Gz2BJbztQaw0FtY	\N	2025-06-16 13:48:34.119	51	20	5	21	3000
5cce6e73-67c3-46c7-9544-6b60428e6055	ayva	ayva	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/5cce6e73-67c3-46c7-9544-6b60428e6055.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy81Y2NlNmU3My02N2MzLTQ2YzctOTU0NC02YjYwNDI4ZTYwNTUuanBnIiwiaWF0IjoxNzUwMDg3NDI5LCJleHAiOjMzMjY4ODc0Mjl9.2M36SgiqFRJyUJ21VYFNNn7F5ke-RlR5aK8bWfAXCXM	\N	\N	52	20	5	21	1500
78a96f2b-9f0e-4516-92c1-9f90cd7fe76c	brokoli	brokoli	https://lenywutixaktnyltvbnt.supabase.co/storage/v1/object/sign/product-images/78a96f2b-9f0e-4516-92c1-9f90cd7fe76c.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV85ODgzOTI4Ni0xZjA4LTRiZTQtYTc2NS03ZGUwZjcyNTU5ZjciLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm9kdWN0LWltYWdlcy83OGE5NmYyYi05ZjBlLTQ1MTYtOTJjMS05ZjkwY2Q3ZmU3NmMuanBnIiwiaWF0IjoxNzQ4ODY0NzkxLCJleHAiOjMzMjU2NjQ3OTF9.8Qd1PiTmZpPiPM46fK3zMnd84NZeC3ksm9ybGeOdO00	2025-06-02 11:46:30.604365	2025-06-02 11:46:30.604365	50	18	3	21	30
\.


--
-- TOC entry 4043 (class 0 OID 18412)
-- Dependencies: 309
-- Data for Name: user_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_table (user_id, user_mail, user_phone_number, user_password, user_name, user_surname, user_birthday_date) FROM stdin;
2	ahmet@gmail.com	5551234567	$2b$10$DttKNsrNVNFCQZNV3REBIexVgBse.mdTc51CvC5nFyJFj4TwRc.zO	Ahmet	Yılmaz	2000-01-01
3	Murat@gmail.com	5551234567	$2b$10$d9fDquuRPUOqdP76v6Z1C.ZByl2xbf9EszOPgao11PeCO7b4r49EC	Murat	Cemcir	2004-01-01
4	şefik@gmail.com	5551234567	$2b$10$IMWeRnDZ4CjVTDeI2TzDB.bg2VJIu/Yc6iK32EbSNv6wYMsRaLjvm	Murat	Cemcir	2004-01-01
5	ornek@mail.com	5551234567	$2b$10$MagW/y/hDmbEmx/PYKeP0ujr1ocKC5chjWKqRBJCZg5H3nCUWmga2	Ahmet	Yılmaz	2000-01-01
10	mertar24@gmail.com	+905308797388	$2b$10$nxH1h2Emn1Jqq/zZPEdOxewjbymWeKMSWgEKKfU9sS.i7a49XXgdu	Mert qw	Cakir	14/12/2001
11	hsngrbz7106@gmail.com	05383042540	$2b$10$Z/KFY92bmVWzYqQF3kqJKe0CR.fz42q9pXDtTVjzXjn6Q4e1RsyIW	Hasan	Gürbüz	10.11.2002
12	ar24@gmail.com	5555555555	$2b$10$zMCzuK5.LctaGxqQMvLJRODlA2HsbqijntIn.O2QWeuZ5PthEc9Ea	Mert	Ar	10/11/2002
\.


--
-- TOC entry 4032 (class 0 OID 17071)
-- Dependencies: 294
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-04-20 18:52:42
20211116045059	2025-04-20 18:52:42
20211116050929	2025-04-20 18:52:42
20211116051442	2025-04-20 18:52:42
20211116212300	2025-04-20 18:52:42
20211116213355	2025-04-20 18:52:43
20211116213934	2025-04-20 18:52:43
20211116214523	2025-04-20 18:52:43
20211122062447	2025-04-20 18:52:43
20211124070109	2025-04-20 18:52:43
20211202204204	2025-04-20 18:52:43
20211202204605	2025-04-20 18:52:43
20211210212804	2025-04-20 18:52:44
20211228014915	2025-04-20 18:52:44
20220107221237	2025-04-20 18:52:44
20220228202821	2025-04-20 18:52:44
20220312004840	2025-04-20 18:52:45
20220603231003	2025-04-20 18:52:45
20220603232444	2025-04-20 18:52:45
20220615214548	2025-04-20 18:52:45
20220712093339	2025-04-20 18:52:45
20220908172859	2025-04-20 18:52:45
20220916233421	2025-04-20 18:52:46
20230119133233	2025-04-20 18:52:46
20230128025114	2025-04-20 18:52:46
20230128025212	2025-04-20 18:52:46
20230227211149	2025-04-20 18:52:46
20230228184745	2025-04-20 18:52:46
20230308225145	2025-04-20 18:52:47
20230328144023	2025-04-20 18:52:47
20231018144023	2025-04-20 18:52:47
20231204144023	2025-04-20 18:52:47
20231204144024	2025-04-20 18:52:47
20231204144025	2025-04-20 18:52:47
20240108234812	2025-04-20 18:52:48
20240109165339	2025-04-20 18:52:48
20240227174441	2025-04-20 18:52:48
20240311171622	2025-04-20 18:52:48
20240321100241	2025-04-20 18:52:49
20240401105812	2025-04-20 18:52:49
20240418121054	2025-04-20 18:52:49
20240523004032	2025-04-20 18:52:50
20240618124746	2025-04-20 18:52:50
20240801235015	2025-04-20 18:52:50
20240805133720	2025-04-20 18:52:50
20240827160934	2025-04-20 18:52:50
20240919163303	2025-04-20 18:52:51
20240919163305	2025-04-20 18:52:51
20241019105805	2025-04-20 18:52:51
20241030150047	2025-04-20 18:52:52
20241108114728	2025-04-20 18:52:52
20241121104152	2025-04-20 18:52:52
20241130184212	2025-04-20 18:52:52
20241220035512	2025-04-20 18:52:52
20241220123912	2025-04-20 18:52:52
20241224161212	2025-04-20 18:52:53
20250107150512	2025-04-20 18:52:53
20250110162412	2025-04-20 18:52:53
20250123174212	2025-04-20 18:52:53
20250128220012	2025-04-20 18:52:53
20250506224012	2025-05-22 21:12:53
20250523164012	2025-05-28 10:40:48
\.


--
-- TOC entry 4034 (class 0 OID 17093)
-- Dependencies: 297
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- TOC entry 4016 (class 0 OID 16540)
-- Dependencies: 275
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
product.images	product.images	\N	2025-05-04 19:53:48.490023+00	2025-05-04 19:53:48.490023+00	f	f	\N	\N	\N
farmer-documents	farmer-documents	\N	2025-05-25 23:32:40.672424+00	2025-05-25 23:32:40.672424+00	f	f	\N	\N	\N
product-images	product-images	\N	2025-05-26 19:40:45.923389+00	2025-05-26 19:40:45.923389+00	f	f	\N	\N	\N
farmer-images	farmer-images	\N	2025-06-01 19:58:22.262532+00	2025-06-01 19:58:22.262532+00	f	f	\N	\N	\N
\.


--
-- TOC entry 4018 (class 0 OID 16582)
-- Dependencies: 277
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-04-20 18:48:34.91783
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-04-20 18:48:34.93109
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-04-20 18:48:34.938996
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-04-20 18:48:34.964622
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-04-20 18:48:34.996146
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-04-20 18:48:35.003598
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-04-20 18:48:35.011426
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-04-20 18:48:35.018416
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-04-20 18:48:35.024537
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-04-20 18:48:35.030505
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-04-20 18:48:35.037147
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-04-20 18:48:35.044588
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-04-20 18:48:35.054949
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-04-20 18:48:35.061329
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-04-20 18:48:35.070741
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-04-20 18:48:35.105622
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-04-20 18:48:35.111768
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-04-20 18:48:35.11777
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-04-20 18:48:35.12423
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-04-20 18:48:35.136033
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-04-20 18:48:35.144098
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-04-20 18:48:35.156321
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-04-20 18:48:35.187991
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-04-20 18:48:35.216237
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-04-20 18:48:35.225634
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-04-20 18:48:35.231691
\.


--
-- TOC entry 4017 (class 0 OID 16555)
-- Dependencies: 276
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
660a2c70-3a3b-4079-8ae0-1e0e547e5d70	product.images	Biber.png	\N	2025-05-04 19:57:19.54251+00	2025-05-04 19:57:19.54251+00	2025-05-04 19:57:19.54251+00	{"eTag": "\\"68a2dab2e757e24f1038cc8858d66aa2-1\\"", "size": 20585, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:57:20.000Z", "contentLength": 20585, "httpStatusCode": 200}	f9b19ee8-9eb6-4987-a9c9-fc2f52899b8e	\N	\N
9cca58e6-4ed3-4555-9c51-33459c0685fe	farmer-documents	46/sertifika-1748879004321-0.png	\N	2025-06-02 15:43:28.316813+00	2025-06-02 15:43:28.316813+00	2025-06-02 15:43:28.316813+00	{"eTag": "\\"342441112acaa46e79ce62c058c14796\\"", "size": 1177527, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-02T15:43:29.000Z", "contentLength": 1177527, "httpStatusCode": 200}	3c05bec2-7765-4a07-a565-ddade7b8b9c4	\N	{}
81534ff9-9fdf-4bf8-ad51-628be6aae6e2	product.images	Brokoli.png	\N	2025-05-04 19:57:38.039527+00	2025-05-04 19:57:38.039527+00	2025-05-04 19:57:38.039527+00	{"eTag": "\\"7f51c1f429307240a6501f7d1879c488-1\\"", "size": 19059, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:57:38.000Z", "contentLength": 19059, "httpStatusCode": 200}	877fa141-1222-44a2-90c5-ab5ece25053b	\N	\N
1df3e046-4854-4e31-8991-28d69198a0fb	product.images	Ananas.png	\N	2025-05-04 19:57:42.510397+00	2025-05-04 19:57:42.510397+00	2025-05-04 19:57:42.510397+00	{"eTag": "\\"668c7223bea36fbc1f703db900603025-1\\"", "size": 20724, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:57:43.000Z", "contentLength": 20724, "httpStatusCode": 200}	7a4380a2-3fe5-4bea-a553-d11f8f385748	\N	\N
f5f7b58b-2bcb-482e-aa3a-2a5ac9f06b9e	product-images	9c450baa-e7b3-47fd-a562-08f755bd1c6d.jpg	\N	2025-06-13 21:50:28.357064+00	2025-06-13 21:50:28.357064+00	2025-06-13 21:50:28.357064+00	{"eTag": "\\"502704a56e7aeafd5f23e3f3aad2a96c\\"", "size": 5365, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-13T21:50:29.000Z", "contentLength": 5365, "httpStatusCode": 200}	91d10acc-48fa-4602-81c7-20e1ac4b54fb	\N	{}
65d146dd-9581-40ed-961d-4b46879e4fe5	product.images	Ayva.png	\N	2025-05-04 19:57:52.477868+00	2025-05-04 19:57:52.477868+00	2025-05-04 19:57:52.477868+00	{"eTag": "\\"9c1dde9f1dc587cf19ec232245b5e229-1\\"", "size": 19189, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:57:53.000Z", "contentLength": 19189, "httpStatusCode": 200}	578964cc-34d8-41cf-84b2-ac1836e2795f	\N	\N
74767828-2e1c-48d6-882c-5949c89c82bb	product.images	Avakado.png	\N	2025-05-04 19:57:54.624996+00	2025-05-04 19:57:54.624996+00	2025-05-04 19:57:54.624996+00	{"eTag": "\\"c42f791780614a086c74b3cf05e2a00d-1\\"", "size": 16839, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:57:55.000Z", "contentLength": 16839, "httpStatusCode": 200}	34633248-4519-4763-a902-baea563cbecf	\N	\N
945d0d69-1109-4b5b-a58e-7ea416454d6b	product-images	7cbfec54-891d-4970-8979-407ea57f7e44.jpg	\N	2025-06-16 13:48:19.801079+00	2025-06-16 13:48:19.801079+00	2025-06-16 13:48:19.801079+00	{"eTag": "\\"8e7022b649d901b2311aeafe15ef21c0\\"", "size": 5422, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T13:48:20.000Z", "contentLength": 5422, "httpStatusCode": 200}	ec2a63e2-207b-4b48-b310-72fb7b5df748	\N	{}
6f98f3a4-a0c1-4326-801e-89f8dcfdaf81	product.images	Erik.png	\N	2025-05-04 19:58:06.851716+00	2025-05-04 19:58:06.851716+00	2025-05-04 19:58:06.851716+00	{"eTag": "\\"191db112d8bab4b4989ad8004667cad9-1\\"", "size": 20978, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:07.000Z", "contentLength": 20978, "httpStatusCode": 200}	c506d1cc-82e6-4e68-909b-2660b2d043a3	\N	\N
319aa1d0-39fd-4b4a-9cc3-493e2cbe4af9	product.images	Domates.png	\N	2025-05-04 19:58:06.911037+00	2025-05-04 19:58:06.911037+00	2025-05-04 19:58:06.911037+00	{"eTag": "\\"22838f443ba448989fea85cbbb637c3f-1\\"", "size": 19546, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:07.000Z", "contentLength": 19546, "httpStatusCode": 200}	33c7ff68-8e2a-4cb9-9766-f4fcc00f7cb6	\N	\N
57c65af0-8ffc-42ec-b443-82129d5ca39f	product.images	Kavun.png	\N	2025-05-04 19:58:29.13535+00	2025-05-04 19:58:29.13535+00	2025-05-04 19:58:29.13535+00	{"eTag": "\\"6374a02f08606f91ec0c216b53257bf7-1\\"", "size": 19365, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:29.000Z", "contentLength": 19365, "httpStatusCode": 200}	c5ebca4f-6af9-4fc2-8814-691e414239e7	\N	\N
90153362-e992-4e00-b2b6-9eea8306a964	product.images	Muz.png	\N	2025-05-04 19:58:29.237362+00	2025-05-04 19:58:29.237362+00	2025-05-04 19:58:29.237362+00	{"eTag": "\\"1659c7fe4bc0e384a13fc11287964c38-1\\"", "size": 18824, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:29.000Z", "contentLength": 18824, "httpStatusCode": 200}	139e82bf-50cf-4c24-8947-425ada954f96	\N	\N
50e696d7-20f5-4aa7-803b-3526eaaa4ef5	product.images	Limon.png	\N	2025-05-04 19:58:29.256768+00	2025-05-04 19:58:29.256768+00	2025-05-04 19:58:29.256768+00	{"eTag": "\\"47d6bd9fe4df807ab2bc31812a11f4f3-1\\"", "size": 18797, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:29.000Z", "contentLength": 18797, "httpStatusCode": 200}	69a4fe67-dda0-4df7-90ec-f02657d010fd	\N	\N
5d2b306b-bbc3-474b-918e-7f20a82ee40b	product.images	Kiraz.png	\N	2025-05-04 19:58:29.305805+00	2025-05-04 19:58:29.305805+00	2025-05-04 19:58:29.305805+00	{"eTag": "\\"87eda3d4f64d6d7259c04ad4722515b8-1\\"", "size": 19922, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:29.000Z", "contentLength": 19922, "httpStatusCode": 200}	ddf27b37-8920-47b4-bd9c-3ba10dda857d	\N	\N
eeede3fe-e47f-4919-ab2c-236555b965d6	product.images	Kivi.png	\N	2025-05-04 19:58:29.326097+00	2025-05-04 19:58:29.326097+00	2025-05-04 19:58:29.326097+00	{"eTag": "\\"dfeb7f148b80b60324ba84ebb69d4595-1\\"", "size": 18025, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:29.000Z", "contentLength": 18025, "httpStatusCode": 200}	4a7dd4f7-307b-464f-a297-826a6bb2e891	\N	\N
07faf792-77d3-465c-bed1-064b46b92824	product.images	Mantar.png	\N	2025-05-04 19:58:29.395608+00	2025-05-04 19:58:29.395608+00	2025-05-04 19:58:29.395608+00	{"eTag": "\\"b4254d4a8ece9100a58f9cdc793fced6-1\\"", "size": 16564, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:30.000Z", "contentLength": 16564, "httpStatusCode": 200}	23e61d80-cda7-4829-b356-bb9c14779401	\N	\N
4d0cd9c4-e415-4ac8-adc0-f85a09a75ada	product.images	Karpuz.png	\N	2025-05-04 19:58:29.41154+00	2025-05-04 19:58:29.41154+00	2025-05-04 19:58:29.41154+00	{"eTag": "\\"55e43a9e47ff976dde22b84fb9c1bd77-1\\"", "size": 19782, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:30.000Z", "contentLength": 19782, "httpStatusCode": 200}	634da514-6fcc-410b-9c45-20ead8fea7a3	\N	\N
28031fce-d147-4b87-aa15-76bedf35d904	product.images	Portakal.png	\N	2025-05-04 19:58:30.301036+00	2025-05-04 19:58:30.301036+00	2025-05-04 19:58:30.301036+00	{"eTag": "\\"a27e49b352f770b5a554e394ec17ab78-1\\"", "size": 19093, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:30.000Z", "contentLength": 19093, "httpStatusCode": 200}	1059b66f-6994-4986-b471-ef9ea77e919b	\N	\N
d9f58986-2cba-4a18-8f0a-e2d7d25e0819	product-images	df99d0b3-962a-4b61-a4f7-6e5f104a2fb0.jpg	\N	2025-06-03 17:43:33.480441+00	2025-06-03 17:43:33.480441+00	2025-06-03 17:43:33.480441+00	{"eTag": "\\"db463ebe65a24213c664453abc9f8aba\\"", "size": 5275, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-03T17:43:34.000Z", "contentLength": 5275, "httpStatusCode": 200}	1d4948bc-1b1e-4e16-8e9a-d9bae494b574	\N	{}
86190260-2295-4100-9376-a9c85e3e8a02	product-images	99d078ce-9a24-43f5-a881-ed22a1457a0d.jpg	\N	2025-06-13 21:57:42.509735+00	2025-06-13 21:57:42.509735+00	2025-06-13 21:57:42.509735+00	{"eTag": "\\"b73c7fb00e16ce41f1e328a4b4b9cfc2\\"", "size": 4808, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-13T21:57:43.000Z", "contentLength": 4808, "httpStatusCode": 200}	8970a230-710c-492b-9257-c4ec09c8960f	\N	{}
7313c9ab-9bc5-4d66-8d2c-2cd68ae6d796	farmer-documents	52/sertifika.pdf	\N	2025-06-16 15:22:25.448857+00	2025-06-16 15:22:25.448857+00	2025-06-16 15:22:25.448857+00	{"eTag": "\\"4d3bec61e4f7d4d19ea4d494c73e991b\\"", "size": 529819, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T15:22:26.000Z", "contentLength": 529819, "httpStatusCode": 200}	61d3044e-6539-4fb2-882d-b546d5a90e7a	\N	{}
386f590c-8a9b-46da-90a6-e2f00a6083dc	product-images	5cce6e73-67c3-46c7-9544-6b60428e6055.jpg	\N	2025-06-16 15:23:49.713734+00	2025-06-16 15:23:49.713734+00	2025-06-16 15:23:49.713734+00	{"eTag": "\\"db463ebe65a24213c664453abc9f8aba\\"", "size": 5275, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T15:23:50.000Z", "contentLength": 5275, "httpStatusCode": 200}	94db1271-d5af-46e0-a5e5-869fabeba08a	\N	{}
01a2f0ee-5415-4f56-a15c-f496662fe722	farmer-images	52/1750087491048-0.png	\N	2025-06-16 15:24:52.857948+00	2025-06-16 15:24:52.857948+00	2025-06-16 15:24:52.857948+00	{"eTag": "\\"df9d477487e01131e65b06354507bd5f\\"", "size": 912225, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T15:24:53.000Z", "contentLength": 912225, "httpStatusCode": 200}	4765a8e3-99d3-4817-9ed4-b36708ecd405	\N	{}
0aa28d25-5b48-4011-8694-156a1aaa12e8	farmer-images	52/1750087493137-1.jpg	\N	2025-06-16 15:24:53.819538+00	2025-06-16 15:24:53.819538+00	2025-06-16 15:24:53.819538+00	{"eTag": "\\"b3e4803a5800dbe1bb9df90301aecd03\\"", "size": 65858, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T15:24:54.000Z", "contentLength": 65858, "httpStatusCode": 200}	930d9d0a-821f-4cbd-9bfe-e2c24e1a861e	\N	{}
5c5bee4f-2441-4b4e-be8f-6d162bb65bc3	farmer-documents	52/sertifika-1750087494278-0.png	\N	2025-06-16 15:24:57.275154+00	2025-06-16 15:24:57.275154+00	2025-06-16 15:24:57.275154+00	{"eTag": "\\"342441112acaa46e79ce62c058c14796\\"", "size": 1177527, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T15:24:58.000Z", "contentLength": 1177527, "httpStatusCode": 200}	1e600c28-0ebe-427d-b1a9-273dc67be209	\N	{}
763ac62e-95ba-45f1-9e56-2251d14e4550	product-images	cdf871e1-b6e3-4c17-8c7b-6c6457f5fb89.jpg	\N	2025-06-01 15:34:25.4551+00	2025-06-01 16:26:14.716082+00	2025-06-01 15:34:25.4551+00	{"eTag": "\\"db463ebe65a24213c664453abc9f8aba\\"", "size": 5275, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-01T16:26:15.000Z", "contentLength": 5275, "httpStatusCode": 200}	404dfdf6-331f-4c8d-a23e-80ad0754df57	\N	{}
a5de6ae1-8b03-411b-958f-c77815cbcdeb	product-images	58b1f530-f7bb-4b6e-9e0d-c1730cec59bc.jpg	\N	2025-06-01 21:15:30.231993+00	2025-06-01 21:15:30.231993+00	2025-06-01 21:15:30.231993+00	{"eTag": "\\"565b8041b9157922a4fb8353c132261c\\"", "size": 5330, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-01T21:15:31.000Z", "contentLength": 5330, "httpStatusCode": 200}	2a41b3f7-509f-41e6-b1b8-417ba6f80f31	\N	{}
d6dc465e-7870-43fd-a6c5-995c52336a7b	farmer-images	46/1748812775843-0.jpg	\N	2025-06-01 21:19:36.271502+00	2025-06-01 21:19:36.271502+00	2025-06-01 21:19:36.271502+00	{"eTag": "\\"b3e4803a5800dbe1bb9df90301aecd03\\"", "size": 65858, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-01T21:19:37.000Z", "contentLength": 65858, "httpStatusCode": 200}	62974312-145d-4962-b8bd-dad8e5105edc	\N	{}
1bd61768-a624-4fb1-bf14-c92b777c8243	product-images	4910648f-8309-483d-8c33-515997c4e276.jpg	\N	2025-06-02 11:44:47.312988+00	2025-06-02 11:44:47.312988+00	2025-06-02 11:44:47.312988+00	{"eTag": "\\"03c579b95e3f733407a7676f21352b99\\"", "size": 6000, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-02T11:44:48.000Z", "contentLength": 6000, "httpStatusCode": 200}	fdf3d05d-da3c-44fe-bf70-08f2ad1ddcdc	\N	{}
8d549055-cf41-4f79-980d-3832819d7b06	product-images	78a96f2b-9f0e-4516-92c1-9f90cd7fe76c.jpg	\N	2025-06-02 11:46:30.852718+00	2025-06-02 11:46:30.852718+00	2025-06-02 11:46:30.852718+00	{"eTag": "\\"b73c7fb00e16ce41f1e328a4b4b9cfc2\\"", "size": 4808, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-02T11:46:31.000Z", "contentLength": 4808, "httpStatusCode": 200}	df9680be-7535-4914-8389-63799f5dabac	\N	{}
a7c5d1a9-8853-426c-9acb-8db7b9460795	product.images	Patates.png	\N	2025-05-04 19:58:30.39539+00	2025-05-04 19:58:30.39539+00	2025-05-04 19:58:30.39539+00	{"eTag": "\\"af7350942c593a5473d27887f3c4f69d-1\\"", "size": 18937, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:31.000Z", "contentLength": 18937, "httpStatusCode": 200}	61bf08e6-f85e-4fc2-8114-5626d1acf43e	\N	\N
e8f1e87c-ffe3-4365-bc66-3bf13e87d1bb	product.images	Greyfut.png	\N	2025-05-04 19:58:50.070029+00	2025-05-04 19:58:50.070029+00	2025-05-04 19:58:50.070029+00	{"eTag": "\\"d38525681a133212d925ad9987096cd2-1\\"", "size": 19202, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T19:58:50.000Z", "contentLength": 19202, "httpStatusCode": 200}	08111759-36bf-42e4-ad61-ff7871b08881	\N	\N
26ff4c6a-6743-4b25-b9aa-41612c8b8838	farmer-images	47/1748860160785-0.jpg	\N	2025-06-02 10:29:21.260557+00	2025-06-02 10:29:21.260557+00	2025-06-02 10:29:21.260557+00	{"eTag": "\\"b3e4803a5800dbe1bb9df90301aecd03\\"", "size": 65858, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-02T10:29:22.000Z", "contentLength": 65858, "httpStatusCode": 200}	8e1fbba5-ff1c-4144-a032-ce3390be1bcd	\N	{}
b65cd114-baa5-4d84-86fb-ca2de045042d	product.images	Portakalor.png	\N	2025-05-04 20:04:33.302015+00	2025-05-04 20:04:33.302015+00	2025-05-04 20:04:33.302015+00	{"eTag": "\\"ead1c32bd1512a64365502419d45a384-1\\"", "size": 18274, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:04:34.000Z", "contentLength": 18274, "httpStatusCode": 200}	9a68cf68-cd8e-4e5e-8d5f-da04cb743693	\N	\N
c11b80c9-c6d5-4b11-8a14-37db0a3268c9	product-images	42067206-de49-4b97-8008-c2fedd8b5248.jpg	\N	2025-06-02 10:24:08.852688+00	2025-06-02 10:24:08.852688+00	2025-06-02 10:24:08.852688+00	{"eTag": "\\"e334d9b423047961ee1ffc240c9ae8eb\\"", "size": 4857, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-02T10:24:09.000Z", "contentLength": 4857, "httpStatusCode": 200}	14fedb20-2558-42a1-9132-58ea08c0442f	\N	{}
3ce9de76-dff3-42bc-b0ff-3c7bca61f1f7	product.images	Salatalik.png	\N	2025-05-04 20:11:12.905279+00	2025-05-04 20:11:12.905279+00	2025-05-04 20:11:12.905279+00	{"eTag": "\\"12106c9f9d6a3741e3f7a5faa5f604f1-1\\"", "size": 19214, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:11:13.000Z", "contentLength": 19214, "httpStatusCode": 200}	d7222e2c-15ee-4b4c-be13-ba8fc7f9ef26	\N	\N
b0679e17-1aac-4594-9f70-9492ee62a2bd	farmer-images	47/1748860161382-1.jpg	\N	2025-06-02 10:29:21.793824+00	2025-06-02 10:29:21.793824+00	2025-06-02 10:29:21.793824+00	{"eTag": "\\"91627943099dc31ba3319662b991d05f\\"", "size": 62301, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-02T10:29:22.000Z", "contentLength": 62301, "httpStatusCode": 200}	0356e14a-11b8-45e1-9d5e-b0aae1b55a18	\N	{}
d4e44e71-cfde-4755-ae6a-7c861306a81d	product.images	Visne.png	\N	2025-05-04 20:11:55.37146+00	2025-05-04 20:11:55.37146+00	2025-05-04 20:11:55.37146+00	{"eTag": "\\"bfb7a8eb0424bfe35f49e0746156ec27-1\\"", "size": 19213, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:11:56.000Z", "contentLength": 19213, "httpStatusCode": 200}	d24d1aa3-703d-4644-ae50-54f3f5707752	\N	\N
9fba7706-0beb-4b9f-9970-7bcdeefebd44	product.images	Ceri Domates.png	\N	2025-05-04 20:12:19.941204+00	2025-05-04 20:12:19.941204+00	2025-05-04 20:12:19.941204+00	{"eTag": "\\"2117dfcc219c0ed37d73a4ece06360fa-1\\"", "size": 19959, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:12:20.000Z", "contentLength": 19959, "httpStatusCode": 200}	cf1eb792-0f0b-4699-bc14-b94136427643	\N	\N
c31cdbfa-028d-4d02-a2b7-63998b581649	product.images	Cilek.png	\N	2025-05-04 20:12:19.961875+00	2025-05-04 20:12:19.961875+00	2025-05-04 20:12:19.961875+00	{"eTag": "\\"dc17e672e02cf019713dca868dd852a4-1\\"", "size": 21346, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:12:20.000Z", "contentLength": 21346, "httpStatusCode": 200}	5b97ed0e-6def-4666-918c-7c0f925e0acd	\N	\N
4bb63898-92ce-4f4b-aba9-772b21593799	product.images	Havuc.png	\N	2025-05-04 20:12:34.255745+00	2025-05-04 20:12:34.255745+00	2025-05-04 20:12:34.255745+00	{"eTag": "\\"941040a803df80e2c45658d5916d4d63-1\\"", "size": 19871, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:12:34.000Z", "contentLength": 19871, "httpStatusCode": 200}	14fa25ec-fd55-42c2-8af8-679ee4ec04ba	\N	\N
1b667c0a-a6e3-4fb4-a26c-9b4e7fa54255	farmer-documents	47/sertifika-1748860162072-0.png	\N	2025-06-02 10:29:23.083696+00	2025-06-02 10:29:23.083696+00	2025-06-02 10:29:23.083696+00	{"eTag": "\\"9d27e8282cff1c1cd0f2a15b7c4a5059\\"", "size": 430830, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-02T10:29:23.000Z", "contentLength": 430830, "httpStatusCode": 200}	1808c31f-1d14-4933-9c47-3c6524024ee5	\N	{}
7530d483-c18e-4a5e-812e-79eb530439bf	product.images	Incir.png	\N	2025-05-04 20:12:46.803547+00	2025-05-04 20:12:46.803547+00	2025-05-04 20:12:46.803547+00	{"eTag": "\\"5b095447c537d5dfa9d77f8309dda261-1\\"", "size": 20102, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:12:47.000Z", "contentLength": 20102, "httpStatusCode": 200}	124da85a-e75b-4a92-b9c4-0be687be084f	\N	\N
debfd510-b985-45b4-86e7-6afa586cc4f3	product.images	Kirmizi Biber.png	\N	2025-05-04 20:13:00.868118+00	2025-05-04 20:13:00.868118+00	2025-05-04 20:13:00.868118+00	{"eTag": "\\"ff500e036481c936ba929c2d5b48a885-1\\"", "size": 20913, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:13:01.000Z", "contentLength": 20913, "httpStatusCode": 200}	ae821039-21ed-427d-8dab-295ca07932a1	\N	\N
4b1fbede-493a-485b-8dce-db21c618aa06	farmer-documents	47/sertifika-1748860163302-1.png	\N	2025-06-02 10:29:25.369532+00	2025-06-02 10:29:25.369532+00	2025-06-02 10:29:25.369532+00	{"eTag": "\\"342441112acaa46e79ce62c058c14796\\"", "size": 1177527, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-02T10:29:26.000Z", "contentLength": 1177527, "httpStatusCode": 200}	feb17868-b00f-48ac-a7bb-e827b32778b1	\N	{}
4e2880fa-e646-4d5a-bd00-33bffd321f64	product.images	Patlican.png	\N	2025-05-04 20:13:11.278936+00	2025-05-04 20:13:11.278936+00	2025-05-04 20:13:11.278936+00	{"eTag": "\\"fc655eb7575d6ac4dff970cc54f24a38-1\\"", "size": 11824, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:13:11.000Z", "contentLength": 11824, "httpStatusCode": 200}	35ccc1ba-0aac-4b4b-b407-d35c8567aecc	\N	\N
19e794ec-f9c1-410d-ad71-e42484620457	product.images	Dolmalik Biber.png	\N	2025-05-04 20:13:25.546788+00	2025-05-04 20:13:25.546788+00	2025-05-04 20:13:25.546788+00	{"eTag": "\\"ac2418163c60d84c488b2ea73ab7b51e-1\\"", "size": 19618, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:13:26.000Z", "contentLength": 19618, "httpStatusCode": 200}	3f27fd35-ac2c-45c3-8587-cefe34352aa2	\N	\N
4501fb4d-83e8-4888-9e69-6e728421000f	product-images	b81fae0a-d920-4155-9bc4-d0101d8ac6d1.jpg	\N	2025-06-05 10:16:37.681811+00	2025-06-05 10:16:37.681811+00	2025-06-05 10:16:37.681811+00	{"eTag": "\\"db463ebe65a24213c664453abc9f8aba\\"", "size": 5275, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-05T10:16:38.000Z", "contentLength": 5275, "httpStatusCode": 200}	5ab278e6-8d06-49b0-8671-367095915c4f	\N	{}
b5283c74-a65d-48f4-b32c-e4d83387523c	product-images	46f1f768-db28-450d-9217-42073cc6b3d0.jpg	\N	2025-06-01 19:51:21.710729+00	2025-06-01 19:51:21.710729+00	2025-06-01 19:51:21.710729+00	{"eTag": "\\"8353820716c5c77865e8c547508af200\\"", "size": 5329, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-01T19:51:22.000Z", "contentLength": 5329, "httpStatusCode": 200}	27946e58-b36b-4996-95b3-379b0a976dc7	\N	{}
0ded8e9a-89b9-4f49-897c-a2091c1837a8	product-images	f29b7a63-df53-48e5-87e1-a9e4ea88bc4a.jpg	\N	2025-06-16 13:32:44.544274+00	2025-06-16 13:32:44.544274+00	2025-06-16 13:32:44.544274+00	{"eTag": "\\"8353820716c5c77865e8c547508af200\\"", "size": 5329, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T13:32:45.000Z", "contentLength": 5329, "httpStatusCode": 200}	30f7be85-23a1-4852-bac6-9b50bfe898d5	\N	{}
c0fdfacc-243a-4988-9be7-9e697ae0fcf9	product.images	Seftali.png	\N	2025-05-04 20:11:55.331016+00	2025-05-04 20:11:55.331016+00	2025-05-04 20:11:55.331016+00	{"eTag": "\\"c1704a3b824f81c6c22e68f3bc0af60e-1\\"", "size": 19330, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:11:56.000Z", "contentLength": 19330, "httpStatusCode": 200}	1d34ddf9-13e0-4176-932b-7615c76a985f	\N	\N
e20c99ec-c291-458e-ae1f-5303e9ee5920	product.images	Sogan.png	\N	2025-05-04 20:11:55.338828+00	2025-05-04 20:11:55.338828+00	2025-05-04 20:11:55.338828+00	{"eTag": "\\"19c7f6b9645ad2874879cba1516c7538-1\\"", "size": 14447, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:11:56.000Z", "contentLength": 14447, "httpStatusCode": 200}	79da026d-def8-4e12-98a8-4bc9a57a98fd	\N	\N
7541ded9-0fd0-43c8-ac3b-b1847589dff1	product.images	Salatalik (1).png	\N	2025-05-04 20:38:51.301357+00	2025-05-04 20:38:51.301357+00	2025-05-04 20:38:51.301357+00	{"eTag": "\\"c2f04605d60cd635a0c7ac37a73ec356-1\\"", "size": 1057758, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-04T20:38:51.000Z", "contentLength": 1057758, "httpStatusCode": 200}	a0dd1824-50f4-4d07-b094-5f52a9f077e0	\N	\N
35f5d8fe-8118-48fb-ad5d-7e9c1c70e798	product-images	6e4e7882-70f5-4c13-b12e-1882e858606f.jpg	\N	2025-06-02 11:16:15.802613+00	2025-06-02 11:16:15.802613+00	2025-06-02 11:16:15.802613+00	{"eTag": "\\"3284af34046efe544ef738133b1c5a37\\"", "size": 5913, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-02T11:16:16.000Z", "contentLength": 5913, "httpStatusCode": 200}	bf6b2f14-333e-40d0-99e5-d1420ecbc031	\N	{}
40dd2653-e077-4101-8c61-2db65ab60207	farmer-documents	17/sertifika.png	\N	2025-05-25 23:48:19.290829+00	2025-05-25 23:48:19.290829+00	2025-05-25 23:48:19.290829+00	{"eTag": "\\"35529ac0c402c6334c0554f9c495c530\\"", "size": 11299, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-25T23:48:20.000Z", "contentLength": 11299, "httpStatusCode": 200}	9baa3e42-7ccf-4ece-91ac-cf9515575950	\N	{}
812aec6c-6599-4fe4-98d3-aec0af2c0a49	farmer-documents	18/sertifika.png	\N	2025-05-25 23:53:00.306588+00	2025-05-25 23:53:00.306588+00	2025-05-25 23:53:00.306588+00	{"eTag": "\\"35529ac0c402c6334c0554f9c495c530\\"", "size": 11299, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-25T23:53:01.000Z", "contentLength": 11299, "httpStatusCode": 200}	ed91dc5f-55f3-4388-8697-11d45d286e64	\N	{}
e2d33081-f69b-477d-9ea7-0d466ebd12a0	farmer-documents	19/sertifika.png	\N	2025-05-25 23:59:26.769101+00	2025-05-25 23:59:26.769101+00	2025-05-25 23:59:26.769101+00	{"eTag": "\\"35529ac0c402c6334c0554f9c495c530\\"", "size": 11299, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-25T23:59:27.000Z", "contentLength": 11299, "httpStatusCode": 200}	ee562945-0dd5-47cb-9cb1-15bf40ca715a	\N	{}
d3d27723-96c8-47cd-a310-993a8665dee9	farmer-documents	22/sertifika.png	\N	2025-05-26 01:09:47.073262+00	2025-05-26 01:09:47.073262+00	2025-05-26 01:09:47.073262+00	{"eTag": "\\"35529ac0c402c6334c0554f9c495c530\\"", "size": 11299, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-26T01:09:48.000Z", "contentLength": 11299, "httpStatusCode": 200}	1dab82a8-5f02-4767-9bd2-8629440ddb57	\N	{}
6fb3eb5e-820b-4f8e-b07a-c76d6e085375	farmer-documents	23/sertifika.png	\N	2025-05-26 01:32:46.995227+00	2025-05-26 01:32:46.995227+00	2025-05-26 01:32:46.995227+00	{"eTag": "\\"35529ac0c402c6334c0554f9c495c530\\"", "size": 11299, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-26T01:32:47.000Z", "contentLength": 11299, "httpStatusCode": 200}	ee11a72f-2453-4c13-957b-143205228723	\N	{}
9a737134-aa63-407b-aff6-b0f9312445d1	farmer-documents	24/sertifika.png	\N	2025-05-26 01:37:43.694517+00	2025-05-26 01:37:43.694517+00	2025-05-26 01:37:43.694517+00	{"eTag": "\\"35529ac0c402c6334c0554f9c495c530\\"", "size": 11299, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-26T01:37:44.000Z", "contentLength": 11299, "httpStatusCode": 200}	2f4d92ea-8352-48a4-9c79-9a19373b5902	\N	{}
23e3fc9f-bc4b-4805-a9b7-4867bffb48c8	farmer-documents	27/sertifika.png	\N	2025-05-26 01:44:55.83857+00	2025-05-26 01:44:55.83857+00	2025-05-26 01:44:55.83857+00	{"eTag": "\\"35529ac0c402c6334c0554f9c495c530\\"", "size": 11299, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-26T01:44:56.000Z", "contentLength": 11299, "httpStatusCode": 200}	7a6b331d-0dea-4c89-a42d-2b4f55b3538e	\N	{}
15f72f26-e9ca-4cb3-8a36-19a3f97d69d5	farmer-documents	28/sertifika.png	\N	2025-05-26 04:26:31.92111+00	2025-05-26 04:26:31.92111+00	2025-05-26 04:26:31.92111+00	{"eTag": "\\"35529ac0c402c6334c0554f9c495c530\\"", "size": 11299, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-26T04:26:32.000Z", "contentLength": 11299, "httpStatusCode": 200}	eff4e3d4-caea-450c-beca-82831d9b8055	\N	{}
c3611e89-025d-4c3b-b302-afffc4c8b70e	farmer-documents	29/sertifika.png	\N	2025-05-26 12:48:13.514859+00	2025-05-26 12:48:13.514859+00	2025-05-26 12:48:13.514859+00	{"eTag": "\\"35529ac0c402c6334c0554f9c495c530\\"", "size": 11299, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-26T12:48:14.000Z", "contentLength": 11299, "httpStatusCode": 200}	851134c1-f125-498b-b023-abd4fced5dd7	\N	{}
3cdf4332-10ed-48d9-a7c8-a512411db72d	farmer-documents	48/sertifika.png	\N	2025-05-30 16:22:36.874493+00	2025-05-30 16:22:36.874493+00	2025-05-30 16:22:36.874493+00	{"eTag": "\\"d41d8cd98f00b204e9800998ecf8427e\\"", "size": 0, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-05-30T16:22:37.000Z", "contentLength": 0, "httpStatusCode": 200}	c585437e-c979-4a3f-bad0-f0eadd4bdac1	\N	{}
a2ee872e-17a7-4ed4-9c63-8422a96c7f51	product-images	bb12e629-5e60-48b6-853e-9fc18158be97.jpg	\N	2025-06-10 13:32:18.615122+00	2025-06-10 13:32:18.615122+00	2025-06-10 13:32:18.615122+00	{"eTag": "\\"8353820716c5c77865e8c547508af200\\"", "size": 5329, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-10T13:32:19.000Z", "contentLength": 5329, "httpStatusCode": 200}	9ca4b2ee-046a-4e94-8909-2f9224d86b91	\N	{}
13fd3706-1117-4a09-b080-6fb63381382c	product-images	cdc0dc07-513f-4b51-8611-e474b33faf8f.jpg	\N	2025-06-10 13:41:40.969313+00	2025-06-10 13:41:40.969313+00	2025-06-10 13:41:40.969313+00	{"eTag": "\\"db463ebe65a24213c664453abc9f8aba\\"", "size": 5275, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-10T13:41:41.000Z", "contentLength": 5275, "httpStatusCode": 200}	1c51c865-14ca-4c2c-98f3-d39ad1e849b3	\N	{}
7977ffcf-387b-4231-8973-3017cf5b2f98	farmer-documents	51/sertifika.png	\N	2025-06-16 13:43:20.567958+00	2025-06-16 13:43:20.567958+00	2025-06-16 13:43:20.567958+00	{"eTag": "\\"35529ac0c402c6334c0554f9c495c530\\"", "size": 11299, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T13:43:21.000Z", "contentLength": 11299, "httpStatusCode": 200}	7c75c8a3-498d-458e-b78c-c9a42cf4a817	\N	{}
6d09e8ab-d04b-454a-bb68-dc51d6867450	farmer-images	51/1750081635881-0.png	\N	2025-06-16 13:47:16.902912+00	2025-06-16 13:47:16.902912+00	2025-06-16 13:47:16.902912+00	{"eTag": "\\"df9d477487e01131e65b06354507bd5f\\"", "size": 912225, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T13:47:17.000Z", "contentLength": 912225, "httpStatusCode": 200}	cee14d4f-e8de-49e5-a187-a56ae610dc8d	\N	{}
24e899ee-4b76-4f05-ae0f-2021ef9490fe	farmer-images	51/1750081637519-1.jpg	\N	2025-06-16 13:47:17.96653+00	2025-06-16 13:47:17.96653+00	2025-06-16 13:47:17.96653+00	{"eTag": "\\"91627943099dc31ba3319662b991d05f\\"", "size": 62301, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T13:47:18.000Z", "contentLength": 62301, "httpStatusCode": 200}	552b7226-31f7-488c-9a21-c6b52f64b173	\N	{}
48ea7d3b-f5f6-4291-a426-ec8d2ba14d0d	farmer-images	46/1748812297175-0.jpg	\N	2025-06-01 21:11:37.557432+00	2025-06-01 21:11:37.557432+00	2025-06-01 21:11:37.557432+00	{"eTag": "\\"91627943099dc31ba3319662b991d05f\\"", "size": 62301, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-01T21:11:38.000Z", "contentLength": 62301, "httpStatusCode": 200}	58676979-9a85-4cda-872b-29ac234f7816	\N	{}
85dac51e-cf58-4f38-9d40-a26f025781fd	farmer-documents	51/sertifika-1750081638382-0.png	\N	2025-06-16 13:47:19.07844+00	2025-06-16 13:47:19.07844+00	2025-06-16 13:47:19.07844+00	{"eTag": "\\"9d27e8282cff1c1cd0f2a15b7c4a5059\\"", "size": 430830, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T13:47:19.000Z", "contentLength": 430830, "httpStatusCode": 200}	ec2c17c2-3706-43c4-a702-3c3868a90476	\N	{}
8b80bfa3-9e73-47d1-9e18-6177d6f2a5e1	farmer-documents	46/sertifika-1748812301686-1.png	\N	2025-06-01 21:11:43.471581+00	2025-06-01 21:11:43.471581+00	2025-06-01 21:11:43.471581+00	{"eTag": "\\"9d27e8282cff1c1cd0f2a15b7c4a5059\\"", "size": 430830, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-01T21:11:44.000Z", "contentLength": 430830, "httpStatusCode": 200}	856d1d98-7400-4974-9692-11766dade3ea	\N	{}
888b7d1a-61a1-4402-b3cb-dc61111bf2a0	product-images	427a407a-5041-49fe-b05d-6df69f84e6ef.jpg	\N	2025-06-02 11:18:41.503477+00	2025-06-02 11:18:41.503477+00	2025-06-02 11:18:41.503477+00	{"eTag": "\\"01e22d6212f8f2a64f4d2865d80da7df\\"", "size": 5232, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-06-02T11:18:42.000Z", "contentLength": 5232, "httpStatusCode": 200}	0bc1848d-a3fa-43d1-a8ac-bd5db2d853a1	\N	{}
2b103513-a08f-43d8-ac23-fe0a0c4f75a2	farmer-documents	51/sertifika-1750081641420-0.png	\N	2025-06-16 13:47:21.897927+00	2025-06-16 13:47:21.897927+00	2025-06-16 13:47:21.897927+00	{"eTag": "\\"9d27e8282cff1c1cd0f2a15b7c4a5059\\"", "size": 430830, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-06-16T13:47:22.000Z", "contentLength": 430830, "httpStatusCode": 200}	58f63275-6158-4f93-a0eb-37441a46dccc	\N	{}
\.


--
-- TOC entry 4030 (class 0 OID 17014)
-- Dependencies: 292
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- TOC entry 4031 (class 0 OID 17028)
-- Dependencies: 293
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- TOC entry 3595 (class 0 OID 16650)
-- Dependencies: 278
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4246 (class 0 OID 0)
-- Dependencies: 270
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 237, true);


--
-- TOC entry 4247 (class 0 OID 0)
-- Dependencies: 313
-- Name: cards_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cards_card_id_seq', 2, true);


--
-- TOC entry 4248 (class 0 OID 0)
-- Dependencies: 311
-- Name: delivery_address_user_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.delivery_address_user_address_id_seq', 16, true);


--
-- TOC entry 4249 (class 0 OID 0)
-- Dependencies: 320
-- Name: farmer_certificate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.farmer_certificate_id_seq', 24, true);


--
-- TOC entry 4250 (class 0 OID 0)
-- Dependencies: 316
-- Name: farmer_farmer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.farmer_farmer_id_seq', 52, true);


--
-- TOC entry 4251 (class 0 OID 0)
-- Dependencies: 318
-- Name: farmer_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.farmer_images_id_seq', 16, true);


--
-- TOC entry 4252 (class 0 OID 0)
-- Dependencies: 323
-- Name: farmer_product_income_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.farmer_product_income_id_seq', 28, true);


--
-- TOC entry 4253 (class 0 OID 0)
-- Dependencies: 312
-- Name: order_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_order_id_seq', 11, true);


--
-- TOC entry 4254 (class 0 OID 0)
-- Dependencies: 314
-- Name: order_product_order_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_product_order_product_id_seq', 15, true);


--
-- TOC entry 4255 (class 0 OID 0)
-- Dependencies: 315
-- Name: product_table_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_table_product_id_seq', 1004, true);


--
-- TOC entry 4256 (class 0 OID 0)
-- Dependencies: 310
-- Name: user_table_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_table_user_id_seq', 12, true);


--
-- TOC entry 4257 (class 0 OID 0)
-- Dependencies: 296
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- TOC entry 3724 (class 2606 OID 16807)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 3682 (class 2606 OID 16525)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 3746 (class 2606 OID 16913)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 3703 (class 2606 OID 16931)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 3705 (class 2606 OID 16941)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 3680 (class 2606 OID 16518)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 3726 (class 2606 OID 16800)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 3722 (class 2606 OID 16788)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 3714 (class 2606 OID 16981)
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- TOC entry 3716 (class 2606 OID 16775)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 3750 (class 2606 OID 16966)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3674 (class 2606 OID 16508)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3677 (class 2606 OID 16717)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3735 (class 2606 OID 16847)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 3737 (class 2606 OID 16845)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3742 (class 2606 OID 16861)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 3685 (class 2606 OID 16531)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3709 (class 2606 OID 16738)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3732 (class 2606 OID 16828)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 3728 (class 2606 OID 16819)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3667 (class 2606 OID 16901)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 3669 (class 2606 OID 16495)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3768 (class 2606 OID 18418)
-- Name: coupon_usages cupon_usages_pkey; Type: CONSTRAINT; Schema: cupons; Owner: postgres
--

ALTER TABLE ONLY cupons.coupon_usages
    ADD CONSTRAINT cupon_usages_pkey PRIMARY KEY (coupon_usages_id);


--
-- TOC entry 3770 (class 2606 OID 18420)
-- Name: coupons cupons_pkey; Type: CONSTRAINT; Schema: cupons; Owner: postgres
--

ALTER TABLE ONLY cupons.coupons
    ADD CONSTRAINT cupons_pkey PRIMARY KEY (coupon_id);


--
-- TOC entry 3792 (class 2606 OID 61865)
-- Name: products PK_0806c755e0aca124e67c0cf6d7d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "PK_0806c755e0aca124e67c0cf6d7d" PRIMARY KEY (id);


--
-- TOC entry 3784 (class 2606 OID 20703)
-- Name: user_table UQ_42b7e8327e8e9e59a8e94324cbb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_table
    ADD CONSTRAINT "UQ_42b7e8327e8e9e59a8e94324cbb" UNIQUE (user_mail);


--
-- TOC entry 3786 (class 2606 OID 18422)
-- Name: user_table User_Table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_table
    ADD CONSTRAINT "User_Table_pkey" PRIMARY KEY (user_id);


--
-- TOC entry 3772 (class 2606 OID 25137)
-- Name: cards cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (card_id);


--
-- TOC entry 3774 (class 2606 OID 18428)
-- Name: delivery_address delivery_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_address
    ADD CONSTRAINT delivery_address_pkey PRIMARY KEY (user_address_id);


--
-- TOC entry 3790 (class 2606 OID 57037)
-- Name: farmer_certificate farmer_certificate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farmer_certificate
    ADD CONSTRAINT farmer_certificate_pkey PRIMARY KEY (id);


--
-- TOC entry 3788 (class 2606 OID 57026)
-- Name: farmer_images farmer_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farmer_images
    ADD CONSTRAINT farmer_images_pkey PRIMARY KEY (id);


--
-- TOC entry 3776 (class 2606 OID 18430)
-- Name: farmer farmer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farmer
    ADD CONSTRAINT farmer_pkey PRIMARY KEY (farmer_id);


--
-- TOC entry 3794 (class 2606 OID 67640)
-- Name: farmer_product_income farmer_product_income_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farmer_product_income
    ADD CONSTRAINT farmer_product_income_pkey PRIMARY KEY (id);


--
-- TOC entry 3778 (class 2606 OID 18432)
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3780 (class 2606 OID 18434)
-- Name: order_product order_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_product_pkey PRIMARY KEY (order_product_id);


--
-- TOC entry 3782 (class 2606 OID 18436)
-- Name: product_table product_table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_table
    ADD CONSTRAINT product_table_pkey PRIMARY KEY (product_id);


--
-- TOC entry 3766 (class 2606 OID 17246)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3763 (class 2606 OID 17101)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 3760 (class 2606 OID 17075)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3688 (class 2606 OID 16548)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 3695 (class 2606 OID 16589)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 3697 (class 2606 OID 16587)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3693 (class 2606 OID 16565)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 3758 (class 2606 OID 17037)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 3756 (class 2606 OID 17022)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 3683 (class 1259 OID 16526)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 3657 (class 1259 OID 16727)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3658 (class 1259 OID 16729)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3659 (class 1259 OID 16730)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3712 (class 1259 OID 16809)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 3744 (class 1259 OID 16917)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 3701 (class 1259 OID 16897)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 4258 (class 0 OID 0)
-- Dependencies: 3701
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 3706 (class 1259 OID 16724)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 3747 (class 1259 OID 16914)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 3748 (class 1259 OID 16915)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 3720 (class 1259 OID 16920)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 3717 (class 1259 OID 16781)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 3718 (class 1259 OID 16926)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 3751 (class 1259 OID 16973)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 3752 (class 1259 OID 16972)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 3753 (class 1259 OID 16974)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 3660 (class 1259 OID 16731)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3661 (class 1259 OID 16728)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3670 (class 1259 OID 16509)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 3671 (class 1259 OID 16510)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 3672 (class 1259 OID 16723)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 3675 (class 1259 OID 16811)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 3678 (class 1259 OID 16916)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 3738 (class 1259 OID 16853)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 3739 (class 1259 OID 16918)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 3740 (class 1259 OID 16868)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 3743 (class 1259 OID 16867)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 3707 (class 1259 OID 16919)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 3710 (class 1259 OID 16810)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 3730 (class 1259 OID 16835)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 3733 (class 1259 OID 16834)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 3729 (class 1259 OID 16820)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 3719 (class 1259 OID 16979)
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- TOC entry 3711 (class 1259 OID 16808)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 3662 (class 1259 OID 16888)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 4259 (class 0 OID 0)
-- Dependencies: 3662
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 3663 (class 1259 OID 16725)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 3664 (class 1259 OID 16499)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 3665 (class 1259 OID 16943)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 3761 (class 1259 OID 17247)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- TOC entry 3764 (class 1259 OID 17150)
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- TOC entry 3686 (class 1259 OID 16554)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 3689 (class 1259 OID 16576)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 3754 (class 1259 OID 17048)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 3690 (class 1259 OID 17013)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 3691 (class 1259 OID 16577)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 3825 (class 2620 OID 67688)
-- Name: order_product trg_check_and_reduce_stock; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_check_and_reduce_stock BEFORE INSERT ON public.order_product FOR EACH ROW EXECUTE FUNCTION public.check_and_reduce_stock();


--
-- TOC entry 3824 (class 2620 OID 17106)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 3823 (class 2620 OID 17001)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 3797 (class 2606 OID 16711)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 3801 (class 2606 OID 16801)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 3800 (class 2606 OID 16789)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 3799 (class 2606 OID 16776)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 3806 (class 2606 OID 16967)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 3795 (class 2606 OID 16744)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 3803 (class 2606 OID 16848)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 3804 (class 2606 OID 16921)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 3805 (class 2606 OID 16862)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 3798 (class 2606 OID 16739)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 3802 (class 2606 OID 16829)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 3810 (class 2606 OID 18437)
-- Name: coupon_usages coupons_to_coupons_usages; Type: FK CONSTRAINT; Schema: cupons; Owner: postgres
--

ALTER TABLE ONLY cupons.coupon_usages
    ADD CONSTRAINT coupons_to_coupons_usages FOREIGN KEY (coupons_id) REFERENCES cupons.coupons(coupon_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3811 (class 2606 OID 18442)
-- Name: coupon_usages order_to_coupon_usages; Type: FK CONSTRAINT; Schema: cupons; Owner: postgres
--

ALTER TABLE ONLY cupons.coupon_usages
    ADD CONSTRAINT order_to_coupon_usages FOREIGN KEY (order_id) REFERENCES public."order"(order_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3812 (class 2606 OID 18447)
-- Name: coupon_usages user_to_coupons_usages; Type: FK CONSTRAINT; Schema: cupons; Owner: postgres
--

ALTER TABLE ONLY cupons.coupon_usages
    ADD CONSTRAINT user_to_coupons_usages FOREIGN KEY (user_id) REFERENCES public.user_table(user_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3814 (class 2606 OID 27635)
-- Name: order FK_199e32a02ddc0f47cd93181d8fd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_199e32a02ddc0f47cd93181d8fd" FOREIGN KEY (user_id) REFERENCES public.user_table(user_id);


--
-- TOC entry 3819 (class 2606 OID 79649)
-- Name: products FK_454a7270a39dad2692817abcd64; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "FK_454a7270a39dad2692817abcd64" FOREIGN KEY (farmer_id) REFERENCES public.farmer(farmer_id);


--
-- TOC entry 3813 (class 2606 OID 34527)
-- Name: delivery_address FK_bcded07fe5d2c22b8b7bb840c5e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_address
    ADD CONSTRAINT "FK_bcded07fe5d2c22b8b7bb840c5e" FOREIGN KEY ("userUserId") REFERENCES public.user_table(user_id);


--
-- TOC entry 3815 (class 2606 OID 27630)
-- Name: order_product FK_ea143999ecfa6a152f2202895e2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT "FK_ea143999ecfa6a152f2202895e2" FOREIGN KEY (order_id) REFERENCES public."order"(order_id);


--
-- TOC entry 3816 (class 2606 OID 87576)
-- Name: order_product farmer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT farmer FOREIGN KEY (farmer_id) REFERENCES public.farmer(farmer_id) NOT VALID;


--
-- TOC entry 3818 (class 2606 OID 57038)
-- Name: farmer_certificate farmer_certificate_farmer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farmer_certificate
    ADD CONSTRAINT farmer_certificate_farmer_id_fkey FOREIGN KEY (farmer_id) REFERENCES public.farmer(farmer_id);


--
-- TOC entry 3817 (class 2606 OID 57043)
-- Name: farmer_images farmer_images_farmer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farmer_images
    ADD CONSTRAINT farmer_images_farmer_id_fkey FOREIGN KEY (farmer_id) REFERENCES public.farmer(farmer_id);


--
-- TOC entry 3820 (class 2606 OID 67646)
-- Name: farmer_product_income farmer_product_income_farmer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farmer_product_income
    ADD CONSTRAINT farmer_product_income_farmer_id_fkey FOREIGN KEY (farmer_id) REFERENCES public.farmer(farmer_id);


--
-- TOC entry 3821 (class 2606 OID 67641)
-- Name: farmer_product_income farmer_product_income_order_prduct_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farmer_product_income
    ADD CONSTRAINT farmer_product_income_order_prduct_id_fkey FOREIGN KEY (order_prduct_id) REFERENCES public.order_product(order_product_id);


--
-- TOC entry 3822 (class 2606 OID 67651)
-- Name: farmer_product_income farmer_product_income_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.farmer_product_income
    ADD CONSTRAINT farmer_product_income_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 3796 (class 2606 OID 16566)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 3807 (class 2606 OID 17023)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 3808 (class 2606 OID 17043)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 3809 (class 2606 OID 17038)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 3974 (class 0 OID 16519)
-- Dependencies: 273
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3988 (class 0 OID 16907)
-- Dependencies: 290
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3979 (class 0 OID 16704)
-- Dependencies: 281
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3973 (class 0 OID 16512)
-- Dependencies: 272
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3983 (class 0 OID 16794)
-- Dependencies: 285
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3982 (class 0 OID 16782)
-- Dependencies: 284
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3981 (class 0 OID 16769)
-- Dependencies: 283
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3989 (class 0 OID 16957)
-- Dependencies: 291
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3972 (class 0 OID 16501)
-- Dependencies: 271
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3986 (class 0 OID 16836)
-- Dependencies: 288
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3987 (class 0 OID 16854)
-- Dependencies: 289
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3975 (class 0 OID 16527)
-- Dependencies: 274
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3980 (class 0 OID 16734)
-- Dependencies: 282
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3985 (class 0 OID 16821)
-- Dependencies: 287
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3984 (class 0 OID 16812)
-- Dependencies: 286
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3971 (class 0 OID 16489)
-- Dependencies: 269
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4004 (class 3256 OID 56904)
-- Name: farmer Enable insert for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for all users" ON public.farmer FOR INSERT TO authenticated, anon WITH CHECK (true);


--
-- TOC entry 4005 (class 3256 OID 56905)
-- Name: farmer Enable select for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable select for all users" ON public.farmer FOR SELECT TO authenticated, anon USING (true);


--
-- TOC entry 4007 (class 3256 OID 56994)
-- Name: farmer Service role farmer tablosuna erişebilir; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service role farmer tablosuna erişebilir" ON public.farmer USING (true);


--
-- TOC entry 3993 (class 0 OID 18384)
-- Dependencies: 303
-- Name: cards; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.cards ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3994 (class 0 OID 18389)
-- Dependencies: 304
-- Name: delivery_address; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.delivery_address ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3995 (class 0 OID 18394)
-- Dependencies: 305
-- Name: farmer; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.farmer ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4001 (class 0 OID 57027)
-- Dependencies: 319
-- Name: farmer_certificate; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.farmer_certificate ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4000 (class 0 OID 57016)
-- Dependencies: 317
-- Name: farmer_images; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.farmer_images ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4003 (class 0 OID 67626)
-- Dependencies: 322
-- Name: farmer_product_income; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.farmer_product_income ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3996 (class 0 OID 18399)
-- Dependencies: 306
-- Name: order; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public."order" ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3997 (class 0 OID 18404)
-- Dependencies: 307
-- Name: order_product; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.order_product ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3998 (class 0 OID 18407)
-- Dependencies: 308
-- Name: product_table; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.product_table ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4002 (class 0 OID 61856)
-- Dependencies: 321
-- Name: products; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3999 (class 0 OID 18412)
-- Dependencies: 309
-- Name: user_table; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_table ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3992 (class 0 OID 17232)
-- Dependencies: 300
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4008 (class 3256 OID 61947)
-- Name: objects Service role can do everything; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Service role can do everything" ON storage.objects TO service_role USING ((bucket_id = 'farmer-documents'::text)) WITH CHECK ((bucket_id = 'farmer-documents'::text));


--
-- TOC entry 4006 (class 3256 OID 56972)
-- Name: objects Service role tüm işlemlere erişebilir; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Service role tüm işlemlere erişebilir" ON storage.objects USING ((bucket_id = 'farmer-documents'::text));


--
-- TOC entry 3976 (class 0 OID 16540)
-- Dependencies: 275
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3978 (class 0 OID 16582)
-- Dependencies: 277
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3977 (class 0 OID 16555)
-- Dependencies: 276
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3990 (class 0 OID 17014)
-- Dependencies: 292
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3991 (class 0 OID 17028)
-- Dependencies: 293
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4009 (class 6104 OID 16420)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 4063 (class 0 OID 0)
-- Dependencies: 17
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- TOC entry 4065 (class 0 OID 0)
-- Dependencies: 15
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 4066 (class 0 OID 0)
-- Dependencies: 14
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 4067 (class 0 OID 0)
-- Dependencies: 23
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 4068 (class 0 OID 0)
-- Dependencies: 16
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 4069 (class 0 OID 0)
-- Dependencies: 18
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;


--
-- TOC entry 4077 (class 0 OID 0)
-- Dependencies: 342
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- TOC entry 4078 (class 0 OID 0)
-- Dependencies: 413
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 4080 (class 0 OID 0)
-- Dependencies: 341
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- TOC entry 4082 (class 0 OID 0)
-- Dependencies: 340
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- TOC entry 4083 (class 0 OID 0)
-- Dependencies: 380
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 4084 (class 0 OID 0)
-- Dependencies: 375
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- TOC entry 4085 (class 0 OID 0)
-- Dependencies: 376
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- TOC entry 4086 (class 0 OID 0)
-- Dependencies: 390
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- TOC entry 4087 (class 0 OID 0)
-- Dependencies: 377
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- TOC entry 4088 (class 0 OID 0)
-- Dependencies: 394
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4089 (class 0 OID 0)
-- Dependencies: 396
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4090 (class 0 OID 0)
-- Dependencies: 387
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- TOC entry 4091 (class 0 OID 0)
-- Dependencies: 386
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- TOC entry 4092 (class 0 OID 0)
-- Dependencies: 393
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4093 (class 0 OID 0)
-- Dependencies: 395
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4094 (class 0 OID 0)
-- Dependencies: 364
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- TOC entry 4095 (class 0 OID 0)
-- Dependencies: 365
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- TOC entry 4096 (class 0 OID 0)
-- Dependencies: 391
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- TOC entry 4097 (class 0 OID 0)
-- Dependencies: 392
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- TOC entry 4099 (class 0 OID 0)
-- Dependencies: 397
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- TOC entry 4101 (class 0 OID 0)
-- Dependencies: 405
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4103 (class 0 OID 0)
-- Dependencies: 403
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- TOC entry 4104 (class 0 OID 0)
-- Dependencies: 389
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4105 (class 0 OID 0)
-- Dependencies: 388
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- TOC entry 4106 (class 0 OID 0)
-- Dependencies: 398
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- TOC entry 4107 (class 0 OID 0)
-- Dependencies: 363
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4108 (class 0 OID 0)
-- Dependencies: 359
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- TOC entry 4109 (class 0 OID 0)
-- Dependencies: 378
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- TOC entry 4110 (class 0 OID 0)
-- Dependencies: 374
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- TOC entry 4111 (class 0 OID 0)
-- Dependencies: 348
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4112 (class 0 OID 0)
-- Dependencies: 370
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4113 (class 0 OID 0)
-- Dependencies: 372
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4114 (class 0 OID 0)
-- Dependencies: 369
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4115 (class 0 OID 0)
-- Dependencies: 371
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4116 (class 0 OID 0)
-- Dependencies: 373
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4117 (class 0 OID 0)
-- Dependencies: 336
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- TOC entry 4118 (class 0 OID 0)
-- Dependencies: 338
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- TOC entry 4119 (class 0 OID 0)
-- Dependencies: 337
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4120 (class 0 OID 0)
-- Dependencies: 368
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4121 (class 0 OID 0)
-- Dependencies: 351
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- TOC entry 4122 (class 0 OID 0)
-- Dependencies: 353
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4123 (class 0 OID 0)
-- Dependencies: 352
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4124 (class 0 OID 0)
-- Dependencies: 354
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4125 (class 0 OID 0)
-- Dependencies: 366
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- TOC entry 4126 (class 0 OID 0)
-- Dependencies: 349
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- TOC entry 4127 (class 0 OID 0)
-- Dependencies: 367
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4128 (class 0 OID 0)
-- Dependencies: 350
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4129 (class 0 OID 0)
-- Dependencies: 402
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4130 (class 0 OID 0)
-- Dependencies: 360
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4132 (class 0 OID 0)
-- Dependencies: 404
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4133 (class 0 OID 0)
-- Dependencies: 399
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 4134 (class 0 OID 0)
-- Dependencies: 400
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.try_cast_double(inp text) FROM postgres;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- TOC entry 4135 (class 0 OID 0)
-- Dependencies: 358
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.url_decode(data text) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- TOC entry 4136 (class 0 OID 0)
-- Dependencies: 379
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.url_encode(data bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- TOC entry 4137 (class 0 OID 0)
-- Dependencies: 355
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- TOC entry 4138 (class 0 OID 0)
-- Dependencies: 356
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- TOC entry 4139 (class 0 OID 0)
-- Dependencies: 357
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4140 (class 0 OID 0)
-- Dependencies: 384
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- TOC entry 4141 (class 0 OID 0)
-- Dependencies: 385
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4142 (class 0 OID 0)
-- Dependencies: 343
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- TOC entry 4143 (class 0 OID 0)
-- Dependencies: 344
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- TOC entry 4144 (class 0 OID 0)
-- Dependencies: 346
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- TOC entry 4145 (class 0 OID 0)
-- Dependencies: 345
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- TOC entry 4146 (class 0 OID 0)
-- Dependencies: 347
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- TOC entry 4147 (class 0 OID 0)
-- Dependencies: 401
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 4148 (class 0 OID 0)
-- Dependencies: 407
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 4149 (class 0 OID 0)
-- Dependencies: 324
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- TOC entry 4150 (class 0 OID 0)
-- Dependencies: 339
-- Name: FUNCTION check_and_reduce_stock(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_and_reduce_stock() TO anon;
GRANT ALL ON FUNCTION public.check_and_reduce_stock() TO authenticated;
GRANT ALL ON FUNCTION public.check_and_reduce_stock() TO service_role;


--
-- TOC entry 4151 (class 0 OID 0)
-- Dependencies: 429
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4152 (class 0 OID 0)
-- Dependencies: 435
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- TOC entry 4153 (class 0 OID 0)
-- Dependencies: 428
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 4154 (class 0 OID 0)
-- Dependencies: 425
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 4155 (class 0 OID 0)
-- Dependencies: 426
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 4156 (class 0 OID 0)
-- Dependencies: 430
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 4157 (class 0 OID 0)
-- Dependencies: 431
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4158 (class 0 OID 0)
-- Dependencies: 424
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 4159 (class 0 OID 0)
-- Dependencies: 434
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- TOC entry 4160 (class 0 OID 0)
-- Dependencies: 432
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 4161 (class 0 OID 0)
-- Dependencies: 427
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 4162 (class 0 OID 0)
-- Dependencies: 433
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- TOC entry 4163 (class 0 OID 0)
-- Dependencies: 383
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4164 (class 0 OID 0)
-- Dependencies: 361
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4165 (class 0 OID 0)
-- Dependencies: 362
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4167 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- TOC entry 4169 (class 0 OID 0)
-- Dependencies: 290
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 4172 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 4174 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 285
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 284
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 283
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 291
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 4183 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 270
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 4187 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO postgres;
GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 287
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 4202 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- TOC entry 4203 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- TOC entry 4204 (class 0 OID 0)
-- Dependencies: 267
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- TOC entry 4205 (class 0 OID 0)
-- Dependencies: 303
-- Name: TABLE cards; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.cards TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.cards TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.cards TO service_role;


--
-- TOC entry 4207 (class 0 OID 0)
-- Dependencies: 313
-- Name: SEQUENCE cards_card_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.cards_card_id_seq TO anon;
GRANT ALL ON SEQUENCE public.cards_card_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.cards_card_id_seq TO service_role;


--
-- TOC entry 4208 (class 0 OID 0)
-- Dependencies: 304
-- Name: TABLE delivery_address; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.delivery_address TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.delivery_address TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.delivery_address TO service_role;


--
-- TOC entry 4210 (class 0 OID 0)
-- Dependencies: 311
-- Name: SEQUENCE delivery_address_user_address_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.delivery_address_user_address_id_seq TO anon;
GRANT ALL ON SEQUENCE public.delivery_address_user_address_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.delivery_address_user_address_id_seq TO service_role;


--
-- TOC entry 4211 (class 0 OID 0)
-- Dependencies: 305
-- Name: TABLE farmer; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer TO service_role;


--
-- TOC entry 4212 (class 0 OID 0)
-- Dependencies: 319
-- Name: TABLE farmer_certificate; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer_certificate TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer_certificate TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer_certificate TO service_role;


--
-- TOC entry 4213 (class 0 OID 0)
-- Dependencies: 320
-- Name: SEQUENCE farmer_certificate_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.farmer_certificate_id_seq TO anon;
GRANT ALL ON SEQUENCE public.farmer_certificate_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.farmer_certificate_id_seq TO service_role;


--
-- TOC entry 4214 (class 0 OID 0)
-- Dependencies: 316
-- Name: SEQUENCE farmer_farmer_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.farmer_farmer_id_seq TO anon;
GRANT ALL ON SEQUENCE public.farmer_farmer_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.farmer_farmer_id_seq TO service_role;


--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 317
-- Name: TABLE farmer_images; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer_images TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer_images TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer_images TO service_role;


--
-- TOC entry 4217 (class 0 OID 0)
-- Dependencies: 318
-- Name: SEQUENCE farmer_images_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.farmer_images_id_seq TO anon;
GRANT ALL ON SEQUENCE public.farmer_images_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.farmer_images_id_seq TO service_role;


--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 322
-- Name: TABLE farmer_product_income; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer_product_income TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer_product_income TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.farmer_product_income TO service_role;


--
-- TOC entry 4219 (class 0 OID 0)
-- Dependencies: 323
-- Name: SEQUENCE farmer_product_income_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.farmer_product_income_id_seq TO anon;
GRANT ALL ON SEQUENCE public.farmer_product_income_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.farmer_product_income_id_seq TO service_role;


--
-- TOC entry 4220 (class 0 OID 0)
-- Dependencies: 306
-- Name: TABLE "order"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."order" TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."order" TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public."order" TO service_role;


--
-- TOC entry 4222 (class 0 OID 0)
-- Dependencies: 312
-- Name: SEQUENCE order_order_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.order_order_id_seq TO anon;
GRANT ALL ON SEQUENCE public.order_order_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.order_order_id_seq TO service_role;


--
-- TOC entry 4223 (class 0 OID 0)
-- Dependencies: 307
-- Name: TABLE order_product; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.order_product TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.order_product TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.order_product TO service_role;


--
-- TOC entry 4225 (class 0 OID 0)
-- Dependencies: 314
-- Name: SEQUENCE order_product_order_product_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.order_product_order_product_id_seq TO anon;
GRANT ALL ON SEQUENCE public.order_product_order_product_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.order_product_order_product_id_seq TO service_role;


--
-- TOC entry 4226 (class 0 OID 0)
-- Dependencies: 308
-- Name: TABLE product_table; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.product_table TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.product_table TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.product_table TO service_role;


--
-- TOC entry 4228 (class 0 OID 0)
-- Dependencies: 315
-- Name: SEQUENCE product_table_product_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.product_table_product_id_seq TO anon;
GRANT ALL ON SEQUENCE public.product_table_product_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.product_table_product_id_seq TO service_role;


--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 321
-- Name: TABLE products; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.products TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.products TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.products TO service_role;


--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 309
-- Name: TABLE user_table; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.user_table TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.user_table TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.user_table TO service_role;


--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 310
-- Name: SEQUENCE user_table_user_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.user_table_user_id_seq TO anon;
GRANT ALL ON SEQUENCE public.user_table_user_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.user_table_user_id_seq TO service_role;


--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 300
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- TOC entry 4234 (class 0 OID 0)
-- Dependencies: 294
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 4235 (class 0 OID 0)
-- Dependencies: 297
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 4236 (class 0 OID 0)
-- Dependencies: 296
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 4238 (class 0 OID 0)
-- Dependencies: 275
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO postgres;


--
-- TOC entry 4239 (class 0 OID 0)
-- Dependencies: 277
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO postgres;


--
-- TOC entry 4241 (class 0 OID 0)
-- Dependencies: 276
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO postgres;


--
-- TOC entry 4242 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- TOC entry 4243 (class 0 OID 0)
-- Dependencies: 293
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- TOC entry 4244 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,DELETE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;


--
-- TOC entry 4245 (class 0 OID 0)
-- Dependencies: 279
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;


--
-- TOC entry 2410 (class 826 OID 16597)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2411 (class 826 OID 16598)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2409 (class 826 OID 16596)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- TOC entry 2420 (class 826 OID 16671)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2419 (class 826 OID 16670)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 2418 (class 826 OID 16669)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2423 (class 826 OID 16631)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2422 (class 826 OID 16630)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2421 (class 826 OID 16629)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- TOC entry 2415 (class 826 OID 16611)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2417 (class 826 OID 16610)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2416 (class 826 OID 16609)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- TOC entry 2402 (class 826 OID 16484)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2403 (class 826 OID 16485)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2401 (class 826 OID 16483)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2405 (class 826 OID 16487)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2400 (class 826 OID 16482)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- TOC entry 2404 (class 826 OID 16486)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- TOC entry 2413 (class 826 OID 16601)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2414 (class 826 OID 16602)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2412 (class 826 OID 16600)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- TOC entry 2408 (class 826 OID 16539)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2407 (class 826 OID 16538)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2406 (class 826 OID 16537)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- TOC entry 3589 (class 3466 OID 16615)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- TOC entry 3594 (class 3466 OID 16684)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- TOC entry 3588 (class 3466 OID 16613)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- TOC entry 3587 (class 3466 OID 16594)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- TOC entry 3590 (class 3466 OID 16616)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- TOC entry 3591 (class 3466 OID 16617)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

-- Completed on 2025-06-19 15:19:20 +03

--
-- PostgreSQL database dump complete
--

-- Completed on 2025-06-19 15:19:20 +03

--
-- PostgreSQL database cluster dump complete
--

