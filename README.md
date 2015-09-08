# docker-phpmyadmin

Use the following environment variables to configure phpMyAdmin:

`BLOWFISH_SECRET` The cookie auth_type uses AES algorithm to encrypt the password. If you are using the cookie auth_type, enter here a random passphrase of your choice. It will be used internally by the AES algorithm: you won't be prompted for this passphrase. There is no maximum length for this secret.

`SERVER_$i_HOST` The hostname or IP address of your $i-th MySQL-server

`SERVER_$i_PORT` The port-number of your $i-th MySQL-server. Default is 3306

`SERVER_$i_PMADB` The name of the database containing the phpMyAdmin configuration storage.

`SERVER_$i_CONTROLHOST` Permits to use an alternate host to hold the configuration storage data.

`SERVER_$i_CONTROLPORT` Permits to use an alternate port to connect to the host that holds the configuration storage.

`SERVER_$i_CONTROLUSER` Control User for the configuration storage

`SERVER_$i_CONTROLPASS` Password for Control User 



