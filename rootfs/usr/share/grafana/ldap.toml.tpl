[[servers]]
# Ldap server host (specify multiple hosts space separated)
host = "{{ .LDAP_HOST }}"
# Default port is 389 or 636 if use_ssl = true
port = {{ .LDAP_PORT }}
# Set to true if LDAP server supports TLS
use_ssl = {{ .LDAP_USE_SSL }}
# Set to true if connect LDAP server with STARTTLS pattern (create connection in insecure, then upgrade to secure connection with TLS)
start_tls = true
# set to true if you want to skip SSL cert validation
ssl_skip_verify = true

# Search user bind dn
bind_dn = "{{ .LDAP_BIND_DN }}"
# Search user bind password
# If the password contains # or ; you have to wrap it with triple quotes. Ex """#password;"""
bind_password = "{{ .LDAP_BIND_PASSWORD }}"

# User search filter, for example "(cn=%s)" or "(sAMAccountName=%s)" or "(uid=%s)"
# Allow login from email or username, example "(|(sAMAccountName=%s)(userPrincipalName=%s))"
search_filter = "{{ .LDAP_USER_FILTER }}"

# An array of base dns to search through
search_base_dns = ["{{ .LDAP_USER_BASEDN }}"]

# Specify names of the LDAP attributes your LDAP uses
[servers.attributes]
name = "givenName"
surname = "sn"
username = "cn"
member_of = "memberOf"
email =  "mail"

[[servers.group_mappings]]
group_dn = "{{ .LDAP_ADMIN_GROUP }}"
org_role = "Admin"
grafana_admin = true # Available in Grafana v5.3 and above

[[servers.group_mappings]]
group_dn = "{{ .LDAP_EDITOR_GROUP }}"
org_role = "Editor"

[[servers.group_mappings]]
group_dn = "{{ .LDAP_VIEWER_GROUP }}"
org_role = "Viewer"
