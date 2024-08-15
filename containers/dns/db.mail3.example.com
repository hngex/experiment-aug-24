$TTL 3600
@    IN    SOA   ns1.mail3.example.com. admin.mail3.example.com. (
                  2024081201 ; Serial (YYYYMMDDNN)
                  3600       ; Refresh
                  1800       ; Retry
                  1209600    ; Expire
                  3600 )     ; Minimum TTL

     IN    NS    ns1.mail3.example.com.

mail3.example.com.     IN    A     172.18.0.1
mail3.example.com.     IN    MX    10 mail3.example.com.

ns1                    IN    A     127.0.0.1
