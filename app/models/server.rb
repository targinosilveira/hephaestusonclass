require 'net/ssh'

class Server < ActiveRecord::Base
  attr_accessible :ip, :name, :ssh_port


  def load_average
	host = self.ip
	user = 'targino'
	password = 'stargino'
    Net::SSH.start( host, user, :password => password ) do |ssh|
		result = ssh.exec!('w | grep "load average" | cut -d: -f4')
		@result = result
    end
    @result
  end


end
