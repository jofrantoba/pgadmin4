{% import 'catalog/pg/macros/catalogs.sql' as CATALOGS %}
SELECT
    nsp.oid,
    nsp.nspname as name,
    has_schema_privilege(nsp.oid, 'CREATE') as can_create,
    has_schema_privilege(nsp.oid, 'USAGE') as has_usage
FROM
    pg_namespace nsp
WHERE
    {% if scid %}
    nsp.oid={{scid}}::oid AND
    {% else %}
    {% if not show_sysobj %}
    nspname NOT LIKE 'pg!_%' escape '!' AND
    {% endif %}
    {% endif %}
    NOT (
{{ CATALOGS.LIST('nsp') }}
    )
ORDER BY nspname;
