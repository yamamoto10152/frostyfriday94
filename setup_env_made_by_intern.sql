{% if DEPLOYMENT_TYPE | upper == 'PROD' %}
  {% set environments = ['prod1', 'prod2'] %}
  {% set schemas = ['finance', 'sales', 'hr'] %}
{% else %}
  {% set environments = ['dev', 'qa', 'staging'] %}
  {% set schemas = ['development', 'testing', 'support'] %}
{% endif %}


{% for env in environments %}
  CREATE DATABASE IF NOT EXISTS {{ env }}_db;
  {% for sch in schemas %}
    CREATE SCHEMA IF NOT EXISTS {{ env }}_db.{{ sch }};

    CREATE TABLE IF NOT EXISTS {{ env }}_db.{{ sch }}.{{ env }}_{{ sch }}_orders (
      id INT,
      item VARCHAR,
      quantity INT,
      order_date DATE
    );

    CREATE TABLE IF NOT EXISTS {{ env }}_db.{{ sch }}.{{ env }}_{{ sch }}_customers (
      id INT,
      name VARCHAR,
      email VARCHAR
    );

    CREATE TABLE IF NOT EXISTS {{ env }}_db.{{ sch }}.{{ env }}_{{ sch }}_products (
      product_id INT,
      product_name VARCHAR,
      price NUMBER(18, 2)
    );

    CREATE TABLE IF NOT EXISTS {{ env }}_db.{{ sch }}.{{ env }}_{{ sch }}_employees (
      employee_id INT,
      employee_name VARCHAR,
      position VARCHAR
    );
  {% endfor %}


  {% if DEPLOYMENT_TYPE | upper == 'PROD' %}
    CREATE DATABASE IF NOT EXISTS prod_analytics_db;
    CREATE SCHEMA IF NOT EXISTS prod_analytics_db.public;

    CREATE TABLE IF NOT EXISTS prod_analytics_db.public.analytics_reports (
      report_id INT,
      report_name VARCHAR,
      created_date DATE
    );
  {% endif %}


{% endfor %}
