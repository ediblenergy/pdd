package Pdd::Schema::Result::Account::Soundcloud;
use Pdd::Schema::Result;

table 'account_soundcloud';

primary_column service_credential_id => { data_type => integer };

integer_column 'user_id';

text_column 'access_token';

text_column 'refresh_token';

integer_column 'expires_at';

integer_column 'souncloud_user_id';

meta_column;

create_date;

update_date;

belongs_to
  service_credential => "::ServiceCredential",
  {
    'foreign.service_credential_id' => 'self.service_credential_id',
    'foreign.user_id'               => 'self.user_id',
  },
  { add_fk_index => false, };

belongs_to user => "::User", 'user_id';

sub sqlt_deploy_callback {
    my ( $source_instance, $sqlt_table ) = @_;
    $sqlt_table->add_index( name   => 'agr_service_credential_id_user_id_idx',
                            fields => [qw/ service_credential_id user_id /] );
}

1;

__END__
[debug] access_token: {
  access_token => "1-32392-2624818-9e7c8c95e7d78578",
  auto_refresh => "",
  expires_at => "1359938180",
  net_oauth2_version => "0.53",
  refresh_token => "584f4264f2561a73421774a3aa5093c3",
  scope => "*"
}
