package Pdd::Schema::Result;

use strictures 1;
use Import::Into;
use DBIx::Class::Candy ();
use boolean ();
use parent ();
use Function::Parameters ();

sub _candy_components {
    my($class,$params) = @_;
    my @imports = qw[
      TimeStamp
      +Pdd::Schema::Util
      +Pdd::Schema::Component::ServiceId
      Helper::Row::RelationshipDWIM
      Helper::Row::ProxyResultSetMethod 
      ];
    if( $params->{extra_components} ) {
        push( @imports, @{ delete $params->{extra_components} } );
    }
    return \@imports;
}
sub import {
    my $target = caller;
    my ( $class, $params ) = @_;
    my $extra_components = strictures->import::into( $target, 1 );
    DBIx::Class::Candy->import::into( $target,
                           -components => $class->_candy_components($params), );
    boolean->import::into($target);
    Function::Parameters->import::into( $target, ":strict" );
}

1;
