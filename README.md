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

4) Next, open a terminal and cd/navigate into the MeetGreet-Infrastructure/NodeJS folder.

    In the command below, replace "{YOUR ROOT PASSWORD}" with the root password for your MYSQL server. Once done, run it.

    sed -i -e 's/replace_password/{YOUR ROOT PASSWORD}/g' index.js

5) In the same terminal window, run the command "node index.js". The NodeJS Express Service will start and can be accessed with the URL:  http://localhost:5500.

    The endpoints current working include: 

    Sign In User:

    http://localhost:5500/sign-in-user/:email/:password

    Example Usage:

    http://localhost:5500/sign-in-user/baffog@wit.edu/test123




    Register User:

    http://localhost:5500/register-user/:email/:password

    Example Usage:

    http://localhost:5500/register-user/baffog@wit.edu/test123

    You can test these URL's in your browser to get a sense of what responses can be expected.

    NOTE: Please do not push changes to Infrastructure package that contain an index.js.e file or an index.js file that contains your root password. Please change the "password: ..." value within the "const connection" variable present in the index.js file to "replace_password" before pushing if changes need to be made.
