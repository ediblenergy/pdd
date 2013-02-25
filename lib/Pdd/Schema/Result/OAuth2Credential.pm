package Pdd::Schema::Result::OAuth2Credential;
use Pdd::Schema::Result;

table 'oauth2_credential';


primary_column access_token => { data_type => text };

integer_column 'service_credential_id';

text_column refresh_token => { is_nullable => 1, default_value => undef };

integer_column expires_at => { is_nullable => 1, default_value => undef };

text_column scope => { is_nullable => 1, default_value => undef };

text_column 'token_type';

integer_column 'service_id';

integer_column 'user_id';

create_date;

update_date;

unique_constraint(['service_credential_id']);

belongs_to
  service_credential => "::ServiceCredential",
  {
    'foreign.service_credential_id' => 'self.service_credential_id',
    'foreign.service_id'            => 'self.service_id',
    'foreign.user_id'               => 'self.user_id',
  },{
    add_fk_index => 0
  };
#rels
belongs_to service => "::Service", 'service_id';

belongs_to user => "::User", 'user_id';

sub is_expired { 
    shift->expires_at < time();
}

sub sqlt_deploy_hook {
    my ( $source_instance, $sqlt_table ) = @_;
    $sqlt_table->add_index(
        name   => 'oauth2_credential_create_date_idx',
        fields => [qw/create_date/] );
    $sqlt_table->add_index(
        name   => 'oauth2_credential_idx2',
        fields => [qw/user_id service_id service_credential_id/] );
}
1;

=head1 NAME

Pdd::Schema::Result::OAuth2Credential - Storage for L<Net::OAuth2::AccessToken> serialized tokens.

=cut
