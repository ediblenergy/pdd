package Pdd::Log::Router;
 
use Moo;
use Log::Contextual::SimpleLogger;
 
with 'Log::Contextual::Role::Router';
 
has logger => (is => 'lazy');
 
sub _build_logger {
   return Log::Contextual::SimpleLogger->new({ levels_upto => 'debug' });
}
 
sub before_import {
   my ($self, %export_info) = @_;
   my $exporter = $export_info{exporter};
   my $target = $export_info{target};
   print STDERR "Package '$target' will import from '$exporter'\n";
}
 
sub after_import {
   my ($self, %export_info) = @_;
   my $exporter = $export_info{exporter};
   my $target = $export_info{target};
   print STDERR "Package '$target' has imported from '$exporter'\n";
}
 
sub handle_log_request {
   my ($self, %message_info) = @_;
   my $log_code_block = $message_info{message_sub};
   my $args = $message_info{message_args};
   my $log_level_name = $message_info{message_level};
   my $logger = $self->logger;
   my $is_active = $logger->can("is_${log_level_name}");
 
   return unless defined $is_active && $logger->$is_active;
   my $log_message = $log_code_block->(@$args);
   $logger->$log_level_name($log_message);
}
1;
