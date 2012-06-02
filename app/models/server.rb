require 'net/ssh'

class Server < ActiveRecord::Base
  attr_accessible :ip, :name, :ssh_port


  def load_average
	host = self.ip
	user = 'hephaestus'
	password = 'hepahestus'
    Net::SSH.start( host, user, :password => password ) do |ssh|
		result = ssh.exec!('w | grep "load average" | cut -d: -f5')
		@result = result
    end
    @result
  end


end
