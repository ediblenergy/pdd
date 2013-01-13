use strictures 1;
use WebService::Google::Reader;

my $user = 'samuel.c.kaufman@gmail.com';
my $pass = 'itqizpaqnwbviokk';

my $reader = WebService::Google::Reader->new(
    username => $user,
    password => $pass,
    https => 1,
);

my $feed = $reader->state('starred', count => 10 );
my @entries = $feed->entries;
warn $_->title for(@entries);
