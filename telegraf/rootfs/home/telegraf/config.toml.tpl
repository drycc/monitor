# Set Tag Configuration
[tags]

{{- if .GLOBAL_TAGS }}
[global_tags]
  {{ range $index, $item := split "," .GLOBAL_TAGS }}
    {{ $value := split ":" $item }}{{ $value._0 }}={{ $value._1 | quote }}
  {{ end }}
{{ end }}

# Set Agent Configuration
[agent]
  interval = {{ default "60s" .AGENT_INTERVAL | quote }}
  round_interval = {{ default true .AGENT_ROUND_INTERVAL }}
  metric_batch_size = {{ default "3000" .AGENT_BATCH_SIZE }}
  metric_buffer_limit = {{ default "30000" .AGENT_BUFFER_LIMIT }}
  collection_jitter = {{ default "60s" .AGENT_COLLECTION_JITTER | quote }}
  flush_interval = {{ default "60s" .AGENT_FLUSH_INTERVAL | quote }}
  flush_jitter = {{ default "60s" .AGENT_FLUSH_JITTER | quote }}
  debug = {{ default false .AGENT_DEBUG }}
  quiet = {{ default false .AGENT_QUIET }}
  flush_buffer_when_full = {{ default true .AGENT_FLUSH_BUFFER }}
  {{ if .AGENT_HOSTNAME }}hostname = {{ .AGENT_HOSTNAME | quote }} {{ end }}

# Set output configuration
{{- if .AMON_INSTANCE }}
[[outputs.amon]]
  server_key = {{ .AMON_SERVER_KEY | quote }}
  amon_instance = {{ .AMON_INSTANCE | quote }}
  timeout = {{ default "5s" .AMON_TIMEOUT | quote }}
{{ end }}

{{- if .AMQP_URL }}
[[outputs.amqp]]
  url = {{ .AMQP_URL | quote }}
  exchange = {{ default "telegraf" .AMQP_EXCHANGE | quote }}
  routing_tag = {{ default "host" .AMQP_ROUTING_TAG | quote }}
  {{- if .AMQP_SSL_CA }} ssl_ca = {{ .AMQP_SSL_CA | quote }} {{ end }}
  {{- if .AMQP_SSL_CERT }} ssl_cert = {{ .AMQP_SSL_CERT | quote }} {{ end }}
  {{- if .AMQP_SSL_KEY }} ssl_key = {{ .AMQP_SSL_KEY | quote }} {{ end }}
  retention_policy = {{ default "default" .AMQP_RETENTION_POLICY | quote }}
  database = = {{ default "telegraf" .AMQP_DATABASE | quote }}
  precision = {{ default "s" .AMQP_PRECISION | quote }}
{{ end }}

{{- if .DATADOG_API_KEY }}
[[outputs.datadog]]
  apikey = {{ .DATADOG_API_KEY | quote }}
{{ end }}

{{- if .GRAPHITE_SERVERS }}
[[outputs.graphite]]
  servers = [{{ .GRAPHITE_SERVERS }}]
  prefix = {{ default "" .GRAPHITE_PREFIX | quote }}
  timeout = {{ default 2 .GRAPHITE_TIMEOUT }}
{{ end }}

{{- if .POSTGRESQL_CONNECTION}}
[[outputs.postgresql]]
  connection = "{{ .POSTGRESQL_CONNECTION }}"
  tags_as_foreign_keys = true
  create_templates = [
    '''{{`CREATE TABLE {{ .table }} ({{ .columns }})`}}''',
    '''{{`SELECT create_hypertable({{ .table|quoteLiteral }}, 'time', chunk_time_interval => INTERVAL '7 days')`}}''',
    '''{{`ALTER TABLE {{ .table }} SET (timescaledb.compress, timescaledb.compress_segmentby = 'tag_id')`}}''',
    '''{{`SELECT add_retention_policy({{ .table|quoteLiteral }}, INTERVAL '1 months')`}}''',
    '''{{`SELECT add_compression_policy({{ .table|quoteLiteral }}, INTERVAL '2 hours')`}}''',
  ]
{{ end }}

{{- if .KAFKA_BROKERS}}
[[outputs.kafka]]
  brokers = [{{ .KAFKA_BROKERS }}]
  topic = {{ default "telegraf" .KAFKA_TOPIC | quote }}
  routing_tag = {{ .KAFKA_ROUTING_TAG | quote }}
  {{- if .KAFKA_CERTIFICATE }} certificate = {{ .KAFKA_CERTIFICATE | quote }} {{ end }}
  {{- if .KAFKA_KEY }} key = {{ .KAFKA_KEY | quote }} {{ end }}
  {{- if .KAFKA_CA }} ca = {{ .KAFKA_CA | quote }} {{ end }}
  {{- if .KAFKA_VERIFY_SSL }} verify_ssl = {{ .KAFKA_VERIFY_SSL }} {{ end }}
{{ end }}

{{- if .LIBRATO_API_TOKEN }}
[[outputs.librato]]
  api_user = {{ .LIBRATO_API_USER | quote }}
  api_token = {{ .LIBRATO_API_TOKEN | quote }}
  source_tag = {{ .LIBRATO_SOURCE_TAG | quote }}
{{ end }}

{{- if .OPEN_TSDB_HOST }}
  prefix = {{ .OPEN_TSDB_PREFIX | quote }}
  host = {{ .OPEN_TSDB_HOST | quote }}
  port = {{ .OPEN_TSDB_PORT }}
  debug = {{ .OPEN_TSDB_DEUBG }}
{{ end }}

{{- if .RIEMANN_URL }}
[[outputs.riemann]]
  url = {{ .RIEMANN_URL | quote }}
  transport = {{ .RIEMANN_TRANSPORT | quote }}
{{ end }}

# Set Input Configuration

{{- if and .KUBERNETES_URL .ENABLE_KUBERNETES }}
[[inputs.kubernetes]]
  url = {{ .KUBERNETES_URL | quote }}
  bearer_token = {{ .KUBERNETES_BEARER_TOKEN_PATH | quote }}
  {{- if .KUBERNETES_SSL_CA }}tls_ca = {{ .KUBERNETES_SSL_CA | quote }} {{ end }}
  {{- if .KUBERNETES_SSL_CERT }}tls_cert = {{ .KUBERNETES_SSL_CERT | quote }} {{ end }}
  {{- if .KUBERNETES_SSL_KEY }}tls_key = {{ .KUBERNETES_SSL_KEY | quote }} {{ end }}
  insecure_skip_verify = {{ default true .KUBERNETES_INSECURE_SKIP_VERIFY }}
{{ end }}
