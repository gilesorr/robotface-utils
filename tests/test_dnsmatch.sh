#!/usr/bin/env bash
#
# Use 'shunit2' to test the dnsmatch() function from robotface_utils.
#
# This tests a variety of "DNS:" listings from certificates harvested from
# the Internet 2023-04, which should cover all possible combination types
# the script would encounter.
#
# The negative tests ... testing for negatives is hard.  I did a variety
# that should cover most of the issues?

if ! command -v shunit2 > /dev/null 2> /dev/null
then
    cat << EOF
This test script requires the Bash unit testing framework 'shunit2' which
doesn't seem to be available on this machine.  It's available as an
OS-level package for at least Debian, Fedora, and Homebrew on Mac.  Please
install it before running this script.
Exiting.
EOF
    exit 1
fi

source ../robotface_utils

testSingleDomain() {
    assertTrue 'gilesorr.com did not match gilesorr.com.' \
        "dnsmatch 'gilesorr.com' 'gilesorr.com'"
}

testSingleDomainNegative() {
    assertFalse 'gilesorr.com matched gilesorr.ca.' \
        "dnsmatch 'gilesorr.com' 'gilesorr.ca'"
}

testTwoDomain() {
    assertTrue 'howtouselinux.com did not match either of two domains, one of which is an exact match.' \
        'dnsmatch "howtouselinux.com" "howtouselinux.com, www.howtouselinux.com"'
}

testTwoDomainNegative() {
    assertFalse 'chat.howtouselinux.com matched a list of two domains, neither of which is a match.' \
        'dnsmatch "chat.howtouselinux.com" "howtouselinux.com, www.howtouselinux.com"'
}

testMultiDomain() {
    assertTrue 'secure.newegg.com does not match any of neweggs many domain names, even though an exact match exists.' \
        'dnsmatch "secure.newegg.com" "www.usopc.com, c1.neweggimages.com, c2.neweggimages.com, carriercentral.newegg.com, chat.newegg.com, download.newegg.com, eniac.newegg.com, flash.newegg.com, globalselling.newegg.com, help.newegg.ca, help.newegg.com, help.neweggbusiness.com, ih.newegg.com, images10.newegg.com, images10.nutrend.com, images10.rosewill.com, imgion4.newegg.com, imk.neweggimages.com, investors.newegg.com, kb.newegg.ca, kb.newegg.com, kb.neweggbusiness.com, newegg.ca, newegg.com, neweggbusiness.com, ows1.newegg.com, partner.newegg.com, pf.newegg.com, pmtcards.newegg.com, promotions.newegg.ca, promotions.newegg.com, promotions.neweggbusiness.com, promotions.nutrend.com, push.newegg.com, secure.m.newegg.ca, secure.m.newegg.com, secure.newegg.ca, secure.newegg.com, secure.neweggbusiness.com, ssl-images.newegg.com, staffing.newegg.com, usopc.com, waf-poc.newegg.com, www-ts1.newegg.com, www-ts2.newegg.com, www.buildeniac.com, www.newegg.ca, www.newegg.com, www.neweggbusiness.com, www.neweggstaffing.com, www.purecleaninginc.com, www.rosewill.com, www.rosewillhome.com, www2.newegg.com"'
}

testMultiDomainNegative() {
    assertTrue 'a1.newegg.com matches one of neweggs many domain names, even though there is no exact match and no wildcard.' \
        'dnsmatch "secure.newegg.com" "www.usopc.com, c1.neweggimages.com, c2.neweggimages.com, carriercentral.newegg.com, chat.newegg.com, download.newegg.com, eniac.newegg.com, flash.newegg.com, globalselling.newegg.com, help.newegg.ca, help.newegg.com, help.neweggbusiness.com, ih.newegg.com, images10.newegg.com, images10.nutrend.com, images10.rosewill.com, imgion4.newegg.com, imk.neweggimages.com, investors.newegg.com, kb.newegg.ca, kb.newegg.com, kb.neweggbusiness.com, newegg.ca, newegg.com, neweggbusiness.com, ows1.newegg.com, partner.newegg.com, pf.newegg.com, pmtcards.newegg.com, promotions.newegg.ca, promotions.newegg.com, promotions.neweggbusiness.com, promotions.nutrend.com, push.newegg.com, secure.m.newegg.ca, secure.m.newegg.com, secure.newegg.ca, secure.newegg.com, secure.neweggbusiness.com, ssl-images.newegg.com, staffing.newegg.com, usopc.com, waf-poc.newegg.com, www-ts1.newegg.com, www-ts2.newegg.com, www.buildeniac.com, www.newegg.ca, www.newegg.com, www.neweggbusiness.com, www.neweggstaffing.com, www.purecleaninginc.com, www.rosewill.com, www.rosewillhome.com, www2.newegg.com"'
}

testWildcardPlus() {
    assertTrue 'www.google.ca did not match on a *.google.ca wildcard.' \
        'dnsmatch "www.google.ca" "*.google.ca, google.ca"'
}

testWildcardPlus2() {
    assertTrue 'google.ca did not match on a google.ca match in a list that includes a wildcard.' \
        'dnsmatch "google.ca" "*.google.ca, google.ca"'
}

testMultiWildcard() {
    assertTrue 'stackoverflow.com does not match a list that includes multiple wildcards and stackoverflow.com.' \
        'dnsmatch "stackoverflow.com" "*.askubuntu.com, *.blogoverflow.com, *.mathoverflow.net, *.meta.stackexchange.com, *.meta.stackoverflow.com, *.serverfault.com, *.sstatic.net, *.stackexchange.com, *.stackoverflow.com, *.stackoverflow.email, *.stackoverflowteams.com, *.superuser.com, askubuntu.com, blogoverflow.com, mathoverflow.net, openid.stackauth.com, serverfault.com, sstatic.net, stackapps.com, stackauth.com, stackexchange.com, stackoverflow.blog, stackoverflow.com, stackoverflow.email, stackoverflowteams.com, stacksnippets.net, superuser.com"'
}

testMultiWildcard2() {
    assertTrue 'www.stackoverflow.com does not match a list that includes multiple wildcards including *.stackoverflow.com.' \
        'dnsmatch "www.stackoverflow.com" "*.askubuntu.com, *.blogoverflow.com, *.mathoverflow.net, *.meta.stackexchange.com, *.meta.stackoverflow.com, *.serverfault.com, *.sstatic.net, *.stackexchange.com, *.stackoverflow.com, *.stackoverflow.email, *.stackoverflowteams.com, *.superuser.com, askubuntu.com, blogoverflow.com, mathoverflow.net, openid.stackauth.com, serverfault.com, sstatic.net, stackapps.com, stackauth.com, stackexchange.com, stackoverflow.blog, stackoverflow.com, stackoverflow.email, stackoverflowteams.com, stacksnippets.net, superuser.com"'
}

testMultiWildcardNegative() {
    assertFalse 'www.stackapps.com matched in a long list of wildcards includes multiple wildcards .' \
        'dnsmatch "www.stackapps.com" "*.askubuntu.com, *.blogoverflow.com, *.mathoverflow.net, *.meta.stackexchange.com, *.meta.stackoverflow.com, *.serverfault.com, *.sstatic.net, *.stackexchange.com, *.stackoverflow.com, *.stackoverflow.email, *.stackoverflowteams.com, *.superuser.com, askubuntu.com, blogoverflow.com, mathoverflow.net, openid.stackauth.com, serverfault.com, sstatic.net, stackapps.com, stackauth.com, stackexchange.com, stackoverflow.blog, stackoverflow.com, stackoverflow.email, stackoverflowteams.com, stacksnippets.net, superuser.com"'
}

. shunit2

