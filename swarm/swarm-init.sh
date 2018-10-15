#!/bin/bash

case $(hostname -s) in
	manager*) 
		docker swarm init --force-new-cluster --advertise-addr $(hostname -I | awk '{print $2}') | tee /vagrant/.swarm_token
		# docker swarm join-token worker -q > /vagrant/.swarm_token
			;;
	worker*)
		grep 'docker swarm join --token' /vagrant/.swarm_token | bash
		# docker swarm join --token SWMTKN-1-0jx8r0gj91oqve4ov45eirqbx7aqeqigmx7p0viy4z6pqhrbdr-az2zw5ezzdps9my66hkl3diq6 192.168.56.16:2377
		;;
esac