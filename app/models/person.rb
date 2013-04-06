class Person < ActiveLdap::Base
  ldap_mapping dn_attribute: "cn",
               prefix: "ou=People",
               classes: ["inetOrgPerson", "PosixAccount","top"]
end
