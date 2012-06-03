require 'net/ssh'

class Server < ActiveRecord::Base
  attr_accessible :ip, :name, :ssh_port


  def load_average
	host = self.ip
	user = 'hephaestus'
	password = 'hephaestus'
    Net::SSH.start( host, user, :password => password ) do |ssh|
		result = ssh.exec!("uptime | awk -F 'load average:' '{ print $2 }'")
		@result = result
    end
    @result
  end


end
