# Easily switch between chef servers.

	$ kcm list 
	$ >> server1
	$ >> server2
	$ kcm use server1
	$ knife client list
	$ >> client1.domain.com
	$ >> client2.domain.com
	$ >> client3.domain.com
	$ kcm use server2
	$ knife client list
	$ >> client4.domain.com
	$ >> client5.domain.com
	$ >> client6.domain.com
