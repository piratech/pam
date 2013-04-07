class Department < ActiveLdap::Base
  ldap_mapping dn_attribute: "cn",
               prefix: "ou=Departments",
               classes: ["inetOrgPerson"]
end
