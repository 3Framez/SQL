# unlocking a locked oracle sql dev account

Enter username: sys / as sysdba
Enter passowrd: *empty*

# shows your connection name
SQL> SHOW con_name;

# list all usernames and their staus
SQL> select username, account_status from dba_users order by username;

SQL> alter user <usename> identified by <"password">;

# unlocks slected usernames account
SQL> alter user <username> account unlock;
