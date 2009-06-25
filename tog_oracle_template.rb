gem "rufus-scheduler"
rake "gems:install"

plugin 'only_owner', :git => "git://github.com/balinterdi/only_owner.git"

plugin 'tog_oracle', :git => "git://github.com/tog/tog_oracle.git"

route "map.routes_from_plugin 'tog_oracle'"

file "db/migrate/" + Time.now.strftime("%Y%m%d%H%M%S") + "_install_tog_oracle.rb",
%q{class InstallTogOracle < ActiveRecord::Migration
  def self.up
    migrate_plugin "tog_oracle", 5 
  end

  def self.down
    migrate_plugin "tog_oracle", 0
  end
end
}

rake "db:migrate"
