# robotface-utils - `<|°_°|>` - Test Suite
<!-- :created: 2023-04-27 09:21 -->

These should be run both on Linux (usually Debian stable in my case) and macOS (Ventura at the moment).

| `chkcertexpiry` Test                       | Expected Result                                                                              |
| -----                                      | --------                                                                                     |
| `./chkcertexpiry`                          | Help output                                                                                  |
| `./chkcertexpiry -h`                       | Help output                                                                                  |
| `./chkcertexpiry -v`                       | version information                                                                          |
| `./chkcertexpiry -i`                       | info about certificates for URLs listed in the script                                        |
| `./chkcertexpiry -i -s`                    | info about certificates for URLs listed in the script (as previous but no OpenSSL/Curl info) |
| `./chkcertexpiry -t tests/urls.txt`        | info about certificates at listed URLs                                                       |
| `./chkcertexpiry -s -t tests/urls.txt`     | info about certificates at listed URLs (as above but no OpenSSL/Curl info)                   |
| `./chkcertexpiry -t tests/urls.txt -n 120` | info about certificates, more colour-highlighted to show expiry                              |
| `./chkcertexpiry -i -s -t tests/urls.txt`  | info about certificates, internal and external URL lists                                     |

| `tlsdetails` Test               | Expected Result                                                                    |
| -----                           | --------                                                                           |
| `./tlsdetails`                  | Help output                                                                        |
| `./tlsdetails -h`               | Help output                                                                        |
| `./tlsdetails -v`               | version information                                                                |
| `./tlsdetails www.google.ca`    | info about www.google.ca connection and certificate                                |
| `./tlsdetails -s www.google.ca` | info about www.google.ca connection and certificate (as above but no OpenSSL info) |

