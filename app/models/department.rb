class Department < ActiveLdap::Base
  ldap_mapping dn_attribute: "cn",
               prefix: "ou=Departments",
               classes: ["inetOrgPerson"]
  belongs_to :persons, :many => 'o'

  alias groups_mapping persons
  def persons(return_objects=true)
    return groups_mapping if return_objects
    attr = 'cn'
    Person.search(:attribute => 'o',
    :value => id,
    :attributes => [attr]).map {|dn, attrs| attrs[attr]}.flatten
  end
end
