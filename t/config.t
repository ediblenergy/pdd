use Test::More;
use strictures 1;
use Pdd::Config;

ok my $cfg = Pdd::Config->config('test'), 'Config loads, doesnt explode';
is ref $cfg, 'HASH', "config is a hashref";
is $cfg->{db_copy}{dsn},$cfg->{db}{dsn}, "__VAR()__ replacement works";
done_testing;
