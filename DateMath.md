# Date Math
<!-- :created: 2023-04-11 21:13 -->

To paraphrase "The Princess Bride:" "Ha ha! You fool! You fell victim to
one of the classic coder blunders - the most famous of which is 'never get
involved in a land war in Asia' - but only slightly less well-known is
this: 'never write your own date utilities!'"

Seriously - don't.  Date math is inconceivably horrible.  Stop and think
about it: there are 365 days in the year ... except when there aren't.
There are 60 seconds in the minute, 60 minutes in the hour, 24 hours in the
day, and seven days in the week.  What the hell kind of structure is that?
And how many days are there in a month?  Oh, hey, we added a leap-second
this year.  And that's before you hit the Julian calendar.

Which is to say ... I use the GNU `date` utility wherever possible to do
my date math for me, and Apple's not-quite-as-good BSD `date` utility the
rest of the time.

## Get the Final Date from the Certificate

See also [Dissecting the Connection](DissectingTheConnection.md) for
details of using `openssl`.

Get the certificate dates:

    `echo | openssl s_client -connect gilesorr.com:443 -servername gilesorr.com 2>/dev/null | openssl x509 -noout -dates`

The dates are formatted like this: "Jul  1 12:36:42 2023 GMT"

## Get `date` to Understand the Date Format

Read in the date with GNU `date` and convert to seconds since the millennium:

    `expiry_epoch_seconds=$(date '+%s' -d "${ugly_date}")`

With GNU `date` it's easy: it's very good at figuring out the formatting and
can read most semi-standard date formats.  With Mac `date` this is much
harder, we have to specify the exact format of the incoming date for the
application to be able to read it:

    `expiry_epoch_seconds=$(date -jf '%b %e %H:%M:%S %Y %Z' "${ugly_date}" "+%s")`

Happily, this date format has been very stable (ie. it hasn't changed in
the seven or so years I've been maintaining this utility so far).

## Seconds Since the Millennium

When I first heard this next part some 15 or 20 years ago, I thought it was
insane.  In working with it, you eventually realize it's ... kind of the
easiest way to deal with date math - so long as the dates you're dealing
with aren't before "1970-01-01 00:00:00 UTC".  We convert the certificate
expiry date into that format, then we convert the time right now into that
format, and subtract the two to see how many seconds it is until the
certificate expires.  Then the math to see how soon the certificate expires
in days/weeks/months is easy.  For days, divide by 86400 (the number of
seconds in a day).

