use Test::More;
use strictures 1;
use pdd::Config;

ok my $cfg = pdd::Config->config;
done_testing;
