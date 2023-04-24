# Fetching Test Certificate Output
<!-- :created: 2023-04-24 11:03 -->

for url in $(grep -v "^ *#" ../urls.txt ); do echo "Retrieving sclient_out for ${url}: " ; echo | /opt/homebrew/opt/openssl@1.1/bin/openssl s_client -connect "${url}:443" -servername "${url}" 2>/dev/null > "${url}.sclient_out" ; done

LibreSSL:

$ for file in *.sclient_out; do cat $file | openssl x509 -noout -issuer; done
issuer= /C=US/O=Let's Encrypt/CN=R3
issuer= /C=BE/O=GlobalSign nv-sa/CN=GlobalSign Extended Validation CA - SHA256 - G3
issuer= /C=US/O=Let's Encrypt/CN=R3
issuer= /C=US/O=Let's Encrypt/CN=R3
issuer= /C=GB/ST=Greater Manchester/L=Salford/O=Sectigo Limited/CN=Sectigo RSA Extended Validation Secure Server CA
issuer= /C=US/O=DigiCert Inc/CN=DigiCert TLS RSA SHA256 2020 CA1
issuer= /C=US/ST=Texas/L=Houston/O=SSL Corp/CN=SSL.com EV SSL Intermediate CA ECC R2
issuer= /C=US/O=Let's Encrypt/CN=R3
issuer= /C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert SHA2 Extended Validation Server CA
issuer= /C=US/O=Entrust, Inc./OU=See www.entrust.net/legal-terms/OU=(c) 2014 Entrust, Inc. - for authorized use only/CN=Entrust Certification Authority - L1M
issuer= /C=US/ST=Arizona/L=Scottsdale/O=GoDaddy.com, Inc./OU=http://certs.godaddy.com/repository//CN=Go Daddy Secure Certificate Authority - G2
issuer= /C=US/O=Google Trust Services LLC/CN=GTS CA 1C3

OpenSSL 1.1:

for file in *.sclient_out; do cat $file | /opt/homebrew/opt/openssl@1.1/bin/openssl x509 -noout -issuer; done
issuer=C = US, O = Let's Encrypt, CN = R3
issuer=C = BE, O = GlobalSign nv-sa, CN = GlobalSign Extended Validation CA - SHA256 - G3
issuer=C = US, O = Let's Encrypt, CN = R3
issuer=C = US, O = Let's Encrypt, CN = R3
issuer=C = GB, ST = Greater Manchester, L = Salford, O = Sectigo Limited, CN = Sectigo RSA Extended Validation Secure Server CA
issuer=C = US, O = DigiCert Inc, CN = DigiCert TLS RSA SHA256 2020 CA1
issuer=C = US, ST = Texas, L = Houston, O = SSL Corp, CN = SSL.com EV SSL Intermediate CA ECC R2
issuer=C = US, O = Let's Encrypt, CN = R3
issuer=C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert SHA2 Extended Validation Server CA
issuer=C = US, O = "Entrust, Inc.", OU = See www.entrust.net/legal-terms, OU = "(c) 2014 Entrust, Inc. - for authorized use only", CN = Entrust Certification Authority - L1M
issuer=C = US, ST = Arizona, L = Scottsdale, O = "GoDaddy.com, Inc.", OU = http://certs.godaddy.com/repository/, CN = Go Daddy Secure Certificate Authority - G2
issuer=C = US, O = Google Trust Services LLC, CN = GTS CA 1C3
