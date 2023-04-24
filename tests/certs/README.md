# Fetching Test Certificate Output
<!-- :created: 2023-04-24 11:03 -->

for url in $(grep -v "^ *#" ../urls.txt ); do echo "Retrieving sclient_out for ${url}: " ; echo | /opt/homebrew/opt/openssl@1.1/bin/openssl s_client -connect "${url}:443" -servername "${url}" 2>/dev/null > "${url}.sclient_out" ; done

