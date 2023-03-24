use Test::More;

use_ok('Data::Page::Any');

my $any = Data::Page::Any->new(
    [
        125,
        90
    ],
    20,
    12
);

$any->limit;
$any->offset;

done_testing;
