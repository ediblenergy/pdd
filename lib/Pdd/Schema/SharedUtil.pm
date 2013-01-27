package Pdd::Schema::SharedUtil;
use strictures 1;
use parent 'Exporter';
use Encode;
my $_encoding = Encode::find_encoding("UTF-8");

sub utf8_encoding { $_encoding }
our @EXPORT_OK = qw{ utf8_encoding };

1;
