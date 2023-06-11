# Dissecting a TLS Connection
<!-- :created: 2023-04-11 20:55 -->

I am NOT a cryptography expert.  I'm pretty good at prying information out
of programs.  Take this with a grain of salt.

To start debugging a TLS connection, I usually use this first:

    `echo | openssl s_client -connect example.com:443 2>/dev/null`
    
The weird construction with the `echo` at the front is because `s_client`
really is a client and will remain open waiting for content unless you
tell it otherwise.  We also junk any warning messages (usually fine,
but if you have problems remove the `2>/dev/null` part).  The output
includes both the certificate and a lot of information about the
connection.  To drag the details out of the certificate itself:

    `echo | openssl s_client -connect example.com:443 2>/dev/null | openssl x509 -noout -text`
    
This dumps a lot of information about the certificate itself, including
things like the start and end dates and the associated DNS entries.

The man pages are arranged very differently between OpenSSL and LibreSSL.
On Linux to see information about `s_client`, use `man s_client`.  On Mac
to see information about it, use `man openssl` and then search within the
man page for `s_client`.
