CREATE OR REPLACE FUNCTION reset() RETURNS void AS $$
DECLARE 
    table_name text;
BEGIN
    FOR table_name IN
        SELECT tablename
        FROM pg_tables
        WHERE schemaname= 'public'
        AND tablename <> 'admin'
    LOOP
        EXECUTE format('DELETE FROM %I',table_name);
    END LOOP;
END;
$$ LANGUAGE plpgsql;