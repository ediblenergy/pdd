package Pdd::Web::Role::NextUrl;
use strictures 1;
use Moose::Role;

sub _get_next_url {
    my($self,$ctx) = @_;
    my $next_url = delete $ctx->session->{_next_url};
    return $next_url || "/";
}
sub _set_next_url {
    my($self,$ctx,$url) = @_;
    $ctx->session->{_next_url} = "$url";
}
sub next_url {
    my $self = shift;
    my($ctx,$url) = @_;
    return $url ? $self->_set_next_url(@_) : $self->_get_next_url(@_);
}
1;
