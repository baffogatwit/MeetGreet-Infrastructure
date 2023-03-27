# MeetGreet-Infrastructure

This package hold the code for MeetGreet's Infrastructure - See Entry Point to begin.

STEPS TO LOCALLY RUN MEETGREET BACKEND:

1) Install MySQL locally (Please store the "root" user password that you choose. Follow the directions at the corresponding link.)

    MACOS: https://dev.mysql.com/doc/refman/8.0/en/macos-installation-pkg.html
    Windows: https://dev.mysql.com/doc/refman/8.0/en/mysql-installer.html

2) Once installed, open your terminal/command prompt and run the command:

    mysql -u root -p

    This will prompt you for the root user password. Once you enter it, you should have access to MySQL on your device.

3) After installation, navigate to the MYSQL/starting_init.sql file present in this project. Copy the code, paste it into your terminal running MySQL and press enter. You should receive a message stating the Query/Operation was OK. This concludes the setup of the MYSQL server. If you wish to "reset" the MeetGreet database back to its orginal state after any changes are made, repeat this step using the MYSQL/existing_init.sql instead. 

4) You will need to make changes to the MeetGreet package in order to connect the local backend to the program.

STEPS TO RECREATE THE MEETGREET BACKEND USING AWS:

[In Progress]