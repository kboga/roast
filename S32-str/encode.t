use v6;
use Test;
plan 13;


# L<S32::Containers/Buf>

ok 'ab'.encode('ASCII') ~~ Buf, '$str.encode returns a Buf';
ok ('ab'.encode('ASCII') eqv Buf.new(97, 98)),  'encoding to ASCII';
is 'ab'.encode('ASCII').elems, 2, 'right length of Buf';
ok ('ö'.encode('UTF-8') eqv Buf.new(195, 182)), 'encoding to UTF-8';
is 'ab'.encode('UTF-8').elems, 2, 'right length of Buf';

is 'abc'.encode()[0], 97, 'can index one element in a Buf';
is_deeply 'abc'.encode()[1, 2], (98, 99), 'can slice-index a Buf';

# verified with Perl 5:
# perl -CS -Mutf8 -MUnicode::Normalize -e 'print NFD("ä")' | hexdump -C
#?rakudo todo 'We do not handle NDF yet'
ok ('ä'.encode('UTF-8', 'D') eqv Buf.new(:16<61>, :16<cc>, :16<88>)),
                'encoding to UTF-8, with NFD';

ok Buf.new(195, 182).decode ~~ Str, '.decode returns a Str';
is Buf.new(195, 182).decode, 'ö', 'decoding a Buf with UTF-8';
#?rakudo skip 'Not handling non-UTF-8 yet'
is Buf.new(246).decode('ISO-8859-1'), 'ö', 'decoding a Buf with Latin-1';

ok Buf ~~ Stringy, 'Buf does Stringy';
ok Buf ~~ Positional, 'Buf does Positional';

# vim: ft=perl6
