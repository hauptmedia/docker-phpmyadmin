# docker-phpmyadmin

Use the following environment variables to configure phpMyAdmin:

`BLOWFISH_SECRET` The cookie auth_type uses AES algorithm to encrypt the password. If you are using the cookie auth_type, enter here a random passphrase of your choice. It will be used internally by the AES algorithm: you won't be prompted for this passphrase. There is no maximum length for this secret.

`PMA_ABSOLUTE_URI` Sets here the complete URL (with full path) to your phpMyAdmin installation's directory

`SERVER_$i_HOST` The hostname or IP address of your $i-th MySQL-server

`SERVER_$i_PORT` The port-number of your $i-th MySQL-server. Default is 3306

`SERVER_$i_PMADB` The name of the database containing the phpMyAdmin configuration storage.

`SERVER_$i_CONTROLHOST` Permits to use an alternate host to hold the configuration storage data.

`SERVER_$i_CONTROLPORT` Permits to use an alternate port to connect to the host that holds the configuration storage.

`SERVER_$i_CONTROLUSER` Control User for the configuration storage

`SERVER_$i_CONTROLPASS` Password for Control User 


## Example

```bash
docker run \
    -d \
    -e BLOWFISH_SECRET=changeThisToASecretString \
    -e PMA_ABSOLUTE_URI=https://pma.yourdomain.com \
    -e SERVER_1_HOST=mysql-server1.yourdomain.com \
    -e SERVER_1_PMADB=phpmyadmin \
    -e SERVER_1_CONTROLUSER=pma \
    -e SERVER_1_CONTROLPASS=verySecretPassword \
    -e SERVER_2_HOST=mysql-server2.yourdomain.com \
    -e SERVER_3_HOST=mysql-server3.otherdomain.com \
    -e SERVER_3_PORT=3307 \
    -p 127.0.0.1:999:80 \
    hauptmedia/phpmyadmin
```

