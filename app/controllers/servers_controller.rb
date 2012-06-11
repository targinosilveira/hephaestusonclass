# -*- coding: utf-8 -*-

require 'net/ssh'

class ServersController < ApplicationController
  # GET /servers
  # GET /servers.json
  def index
    @version = ApplicationController::HEPHAESTUS_VERSION
    @servers = Server.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @servers }
    end
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    @version = ApplicationController::HEPHAESTUS_VERSION
    @server = Server.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server }
    end
  end

  # GET /servers/new
  # GET /servers/new.json
  def new
    @version = ApplicationController::HEPHAESTUS_VERSION
    @server = Server.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server }
    end
  end

  # GET /servers/1/edit
  def edit
    @version = ApplicationController::HEPHAESTUS_VERSION
    @server = Server.find(params[:id])
  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(params[:server])

    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
        format.json { render json: @server, status: :created, location: @server }
      else
        format.html { render action: "new" }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /servers/1
  # PUT /servers/1.json
  def update
    @server = Server.find(params[:id])

    respond_to do |format|
      if @server.update_attributes(params[:server])
        format.html { redirect_to @server, notice: 'O servidor foi atualizado.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server = Server.find(params[:id])
    @server.destroy

    respond_to do |format|
      format.html { redirect_to servers_url }
      format.json { head :no_content }
    end
  end

  # Method for shutdown a server, for test it's implement reboot
  def shutdown
    @server = Server.find(params[:id])
    host = @server.ip
    user = 'hephaestus'
    password = 'hephaestus'
    Net::SSH.start( host, user, :password => password ) do |ssh|
      result = ssh.exec!("echo 'Eu desliguei o seu computador.....!!!!' > ~/arquivo.txt; sudo halt &")
      @result = result
    end
    #@result
    redirect_to servers_url, notice: 'O servidor foi atualizado.'
  end

  # Method to kill top process
  def killtop
    @server = Server.find(params[:id])
    host = @server.ip
    user = 'hephaestus'
    password = 'hephaestus'
    Net::SSH.start( host, user, :password => password ) do |ssh|
      result = ssh.exec!("sudo killall top; echo 'Eu matei o top.... kkkkkk....' > ~/arquivo.txt")
      @result = result
    end
    #@result
    redirect_to servers_url, notice: 'Processo finalizado com sucesso.'
  end

  # Method to install a HTOP software
  def installhtop
    @server = Server.find(params[:id])
    host = @server.ip
    user = 'hephaestus'
    password = 'hephaestus'
    Net::SSH.start( host, user, :password => password ) do |ssh|
      result = ssh.exec!("sudo apt-get install htop --yes")
      @result = result
    end
    #@result
    redirect_to servers_url, notice: 'HTOP Instalado com sucesso.'
  end

  # Method to remove a HTOP software
  def removehtop
    @server = Server.find(params[:id])
    host = @server.ip
    user = 'hephaestus'
    password = 'hephaestus'
    Net::SSH.start( host, user, :password => password ) do |ssh|
      result = ssh.exec!("sudo apt-get remove htop --yes")
      @result = result
    end
    #@result
    redirect_to servers_url, notice: 'HTOP Removido com sucesso.'
  end

  def reboot
    @server = Server.find(params[:id])
    host = @server.ip
    user = 'hephaestus'
    password = 'hephaestus'
    Net::SSH.start( host, user, :password => password ) do |ssh|
      result = ssh.exec!("sudo reboot &")
      @result = result
    end
    #@result
    redirect_to servers_url, notice: 'Servidor reiniciado com sucesso.'
  end

end
