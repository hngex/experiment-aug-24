$TTL 3600
@    IN    SOA   ns1.mail2.example.com. admin.mail2.example.com. (
                  2024081201 ; Serial (YYYYMMDDNN)
                  3600       ; Refresh
                  1800       ; Retry
                  1209600    ; Expire
                  3600 )     ; Minimum TTL

     IN    NS    ns1.mail2.example.com.

mail2.example.com.     IN    A     172.17.0.1
mail2.example.com.     IN    MX    10 mail2.example.com.

ns1                    IN    A     127.0.0.1
