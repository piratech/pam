class Group < ActiveLdap::Base
  ldap_mapping dn_attribute: "cn",
               prefix: "ou=Groups",
               classes: ["posixGroup", "top"]
end
