use Test::More;
use strictures 1;
use pdd::Config;

ok my $cfg = pdd::Config->config, 'Config loads, doesnt explode';
is ref $cfg, 'HASH', "config is a hashref";
done_testing;
