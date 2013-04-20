class Person < ActiveLdap::Base
  ldap_mapping dn_attribute: "uid",
               prefix: "ou=People",
               classes: ["inetOrgPerson", "PosixAccount","top"]

  belongs_to :primary_group, :class_name => "Group",
             :foreign_key => "gidNumber", :primary_key => "gidNumber"
  belongs_to :groups, :many => 'memberUid'
  has_many   :departments, :class_name => "Departments", :wrap => "o"

  alias groups_mapping groups
  def groups(return_objects=true)
    return groups_mapping if return_objects
    attr = 'cn'
    Group.search(:attribute => 'memberUid',
    :value => id,
    :attributes => [attr]).map {|dn, attrs| attrs[attr]}.flatten
  end

  def auth password
    begin
      bind(:bind_dn => "uid=#{uid},ou=People,#{configurations[Rails.env]["base"]}", :host => configurations[Rails.env]["host"], :password => password)
      return true
    rescue ActiveLdap::AuthenticationError
    return false
    end
  end

end