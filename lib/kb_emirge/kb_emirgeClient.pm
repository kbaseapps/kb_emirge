package kb_emirge::kb_emirgeClient;

use JSON::RPC::Client;
use POSIX;
use strict;
use Data::Dumper;
use URI;
use Bio::KBase::Exceptions;
my $get_time = sub { time, 0 };
eval {
    require Time::HiRes;
    $get_time = sub { Time::HiRes::gettimeofday() };
};

use Bio::KBase::AuthToken;

# Client version should match Impl version
# This is a Semantic Version number,
# http://semver.org
our $VERSION = "0.1.0";

=head1 NAME

kb_emirge::kb_emirgeClient

=head1 DESCRIPTION


A KBase module: kb_emirge


=cut

sub new
{
    my($class, $url, @args) = @_;
    

    my $self = {
	client => kb_emirge::kb_emirgeClient::RpcClient->new,
	url => $url,
	headers => [],
    };

    chomp($self->{hostname} = `hostname`);
    $self->{hostname} ||= 'unknown-host';

    #
    # Set up for propagating KBRPC_TAG and KBRPC_METADATA environment variables through
    # to invoked services. If these values are not set, we create a new tag
    # and a metadata field with basic information about the invoking script.
    #
    if ($ENV{KBRPC_TAG})
    {
	$self->{kbrpc_tag} = $ENV{KBRPC_TAG};
    }
    else
    {
	my ($t, $us) = &$get_time();
	$us = sprintf("%06d", $us);
	my $ts = strftime("%Y-%m-%dT%H:%M:%S.${us}Z", gmtime $t);
	$self->{kbrpc_tag} = "C:$0:$self->{hostname}:$$:$ts";
    }
    push(@{$self->{headers}}, 'Kbrpc-Tag', $self->{kbrpc_tag});

    if ($ENV{KBRPC_METADATA})
    {
	$self->{kbrpc_metadata} = $ENV{KBRPC_METADATA};
	push(@{$self->{headers}}, 'Kbrpc-Metadata', $self->{kbrpc_metadata});
    }

    if ($ENV{KBRPC_ERROR_DEST})
    {
	$self->{kbrpc_error_dest} = $ENV{KBRPC_ERROR_DEST};
	push(@{$self->{headers}}, 'Kbrpc-Errordest', $self->{kbrpc_error_dest});
    }

    #
    # This module requires authentication.
    #
    # We create an auth token, passing through the arguments that we were (hopefully) given.

    {
	my $token = Bio::KBase::AuthToken->new(@args);
	
	if (!$token->error_message)
	{
	    $self->{token} = $token->token;
	    $self->{client}->{token} = $token->token;
	}
        else
        {
	    #
	    # All methods in this module require authentication. In this case, if we
	    # don't have a token, we can't continue.
	    #
	    die "Authentication failed: " . $token->error_message;
	}
    }

    my $ua = $self->{client}->ua;	 
    my $timeout = $ENV{CDMI_TIMEOUT} || (30 * 60);	 
    $ua->timeout($timeout);
    bless $self, $class;
    #    $self->_validate_version();
    return $self;
}




=head2 run_emirge

  $output = $obj->run_emirge($input_params)

=over 4

=item Parameter and return types

=begin html

<pre>
$input_params is a kb_emirge.run_emirge_Input
$output is a kb_emirge.run_emirge_Output
run_emirge_Input is a reference to a hash where the following keys are defined:
	input_ws has a value which is a kb_emirge.workspace_name
	input_reads_ref has a value which is a kb_emirge.data_obj_ref
	output_ws has a value which is a kb_emirge.workspace_name
	output_reads_name has a value which is a kb_emirge.data_obj_name
workspace_name is a string
data_obj_ref is a string
data_obj_name is a string
run_emirge_Output is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string

</pre>

=end html

=begin text

$input_params is a kb_emirge.run_emirge_Input
$output is a kb_emirge.run_emirge_Output
run_emirge_Input is a reference to a hash where the following keys are defined:
	input_ws has a value which is a kb_emirge.workspace_name
	input_reads_ref has a value which is a kb_emirge.data_obj_ref
	output_ws has a value which is a kb_emirge.workspace_name
	output_reads_name has a value which is a kb_emirge.data_obj_name
workspace_name is a string
data_obj_ref is a string
data_obj_name is a string
run_emirge_Output is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string


=end text

=item Description



=back

=cut

 sub run_emirge
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function run_emirge (received $n, expecting 1)");
    }
    {
	my($input_params) = @args;

	my @_bad_arguments;
        (ref($input_params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"input_params\" (value was \"$input_params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to run_emirge:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'run_emirge');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "kb_emirge.run_emirge",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'run_emirge',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method run_emirge",
					    status_line => $self->{client}->status_line,
					    method_name => 'run_emirge',
				       );
    }
}
 


=head2 exec_emirge

  $output = $obj->exec_emirge($input_params)

=over 4

=item Parameter and return types

=begin html

<pre>
$input_params is a kb_emirge.exec_emirge_Input
$output is a kb_emirge.exec_emirge_Output
exec_emirge_Input is a reference to a hash where the following keys are defined:
	input_reads_ref has a value which is a kb_emirge.data_obj_ref
	output_ws has a value which is a kb_emirge.workspace_name
	output_reads_name has a value which is a kb_emirge.data_obj_name
data_obj_ref is a string
workspace_name is a string
data_obj_name is a string
exec_emirge_Output is a reference to a hash where the following keys are defined:
	output_sequences_ref has a value which is a kb_emirge.data_obj_ref
	report has a value which is a string

</pre>

=end html

=begin text

$input_params is a kb_emirge.exec_emirge_Input
$output is a kb_emirge.exec_emirge_Output
exec_emirge_Input is a reference to a hash where the following keys are defined:
	input_reads_ref has a value which is a kb_emirge.data_obj_ref
	output_ws has a value which is a kb_emirge.workspace_name
	output_reads_name has a value which is a kb_emirge.data_obj_name
data_obj_ref is a string
workspace_name is a string
data_obj_name is a string
exec_emirge_Output is a reference to a hash where the following keys are defined:
	output_sequences_ref has a value which is a kb_emirge.data_obj_ref
	report has a value which is a string


=end text

=item Description



=back

=cut

 sub exec_emirge
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function exec_emirge (received $n, expecting 1)");
    }
    {
	my($input_params) = @args;

	my @_bad_arguments;
        (ref($input_params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"input_params\" (value was \"$input_params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to exec_emirge:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'exec_emirge');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "kb_emirge.exec_emirge",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'exec_emirge',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method exec_emirge",
					    status_line => $self->{client}->status_line,
					    method_name => 'exec_emirge',
				       );
    }
}
 


=head2 exec_emirge_SingleLibrary

  $output = $obj->exec_emirge_SingleLibrary($input_params)

=over 4

=item Parameter and return types

=begin html

<pre>
$input_params is a kb_emirge.exec_emirge_Input
$output is a kb_emirge.exec_emirge_Output
exec_emirge_Input is a reference to a hash where the following keys are defined:
	input_reads_ref has a value which is a kb_emirge.data_obj_ref
	output_ws has a value which is a kb_emirge.workspace_name
	output_reads_name has a value which is a kb_emirge.data_obj_name
data_obj_ref is a string
workspace_name is a string
data_obj_name is a string
exec_emirge_Output is a reference to a hash where the following keys are defined:
	output_sequences_ref has a value which is a kb_emirge.data_obj_ref
	report has a value which is a string

</pre>

=end html

=begin text

$input_params is a kb_emirge.exec_emirge_Input
$output is a kb_emirge.exec_emirge_Output
exec_emirge_Input is a reference to a hash where the following keys are defined:
	input_reads_ref has a value which is a kb_emirge.data_obj_ref
	output_ws has a value which is a kb_emirge.workspace_name
	output_reads_name has a value which is a kb_emirge.data_obj_name
data_obj_ref is a string
workspace_name is a string
data_obj_name is a string
exec_emirge_Output is a reference to a hash where the following keys are defined:
	output_sequences_ref has a value which is a kb_emirge.data_obj_ref
	report has a value which is a string


=end text

=item Description



=back

=cut

 sub exec_emirge_SingleLibrary
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function exec_emirge_SingleLibrary (received $n, expecting 1)");
    }
    {
	my($input_params) = @args;

	my @_bad_arguments;
        (ref($input_params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"input_params\" (value was \"$input_params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to exec_emirge_SingleLibrary:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'exec_emirge_SingleLibrary');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "kb_emirge.exec_emirge_SingleLibrary",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'exec_emirge_SingleLibrary',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method exec_emirge_SingleLibrary",
					    status_line => $self->{client}->status_line,
					    method_name => 'exec_emirge_SingleLibrary',
				       );
    }
}
 
  
sub status
{
    my($self, @args) = @_;
    if ((my $n = @args) != 0) {
        Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
                                   "Invalid argument count for function status (received $n, expecting 0)");
    }
    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
        method => "kb_emirge.status",
        params => \@args,
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
                           code => $result->content->{error}->{code},
                           method_name => 'status',
                           data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
                          );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method status",
                        status_line => $self->{client}->status_line,
                        method_name => 'status',
                       );
    }
}
   

sub version {
    my ($self) = @_;
    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
        method => "kb_emirge.version",
        params => [],
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(
                error => $result->error_message,
                code => $result->content->{code},
                method_name => 'exec_emirge_SingleLibrary',
            );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(
            error => "Error invoking method exec_emirge_SingleLibrary",
            status_line => $self->{client}->status_line,
            method_name => 'exec_emirge_SingleLibrary',
        );
    }
}

sub _validate_version {
    my ($self) = @_;
    my $svr_version = $self->version();
    my $client_version = $VERSION;
    my ($cMajor, $cMinor) = split(/\./, $client_version);
    my ($sMajor, $sMinor) = split(/\./, $svr_version);
    if ($sMajor != $cMajor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Major version numbers differ.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor < $cMinor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Client minor version greater than Server minor version.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor > $cMinor) {
        warn "New client version available for kb_emirge::kb_emirgeClient\n";
    }
    if ($sMajor == 0) {
        warn "kb_emirge::kb_emirgeClient version is $svr_version. API subject to change.\n";
    }
}

=head1 TYPES



=head2 workspace_name

=over 4



=item Description

** Common types


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 data_obj_ref

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 data_obj_name

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 run_emirge_Input

=over 4



=item Description

run_emirge()
**
** to backend a KBase App, potentially operating on ReadSets


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
input_ws has a value which is a kb_emirge.workspace_name
input_reads_ref has a value which is a kb_emirge.data_obj_ref
output_ws has a value which is a kb_emirge.workspace_name
output_reads_name has a value which is a kb_emirge.data_obj_name

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
input_ws has a value which is a kb_emirge.workspace_name
input_reads_ref has a value which is a kb_emirge.data_obj_ref
output_ws has a value which is a kb_emirge.workspace_name
output_reads_name has a value which is a kb_emirge.data_obj_name


=end text

=back



=head2 run_emirge_Output

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string


=end text

=back



=head2 exec_emirge_Input

=over 4



=item Description

exec_emirge()
**
** the local method that runs EMIRGE on each read library


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
input_reads_ref has a value which is a kb_emirge.data_obj_ref
output_ws has a value which is a kb_emirge.workspace_name
output_reads_name has a value which is a kb_emirge.data_obj_name

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
input_reads_ref has a value which is a kb_emirge.data_obj_ref
output_ws has a value which is a kb_emirge.workspace_name
output_reads_name has a value which is a kb_emirge.data_obj_name


=end text

=back



=head2 exec_emirge_Output

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
output_sequences_ref has a value which is a kb_emirge.data_obj_ref
report has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
output_sequences_ref has a value which is a kb_emirge.data_obj_ref
report has a value which is a string


=end text

=back



=cut

package kb_emirge::kb_emirgeClient::RpcClient;
use base 'JSON::RPC::Client';
use POSIX;
use strict;

#
# Override JSON::RPC::Client::call because it doesn't handle error returns properly.
#

sub call {
    my ($self, $uri, $headers, $obj) = @_;
    my $result;


    {
	if ($uri =~ /\?/) {
	    $result = $self->_get($uri);
	}
	else {
	    Carp::croak "not hashref." unless (ref $obj eq 'HASH');
	    $result = $self->_post($uri, $headers, $obj);
	}

    }

    my $service = $obj->{method} =~ /^system\./ if ( $obj );

    $self->status_line($result->status_line);

    if ($result->is_success) {

        return unless($result->content); # notification?

        if ($service) {
            return JSON::RPC::ServiceObject->new($result, $self->json);
        }

        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    elsif ($result->content_type eq 'application/json')
    {
        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    else {
        return;
    }
}


sub _post {
    my ($self, $uri, $headers, $obj) = @_;
    my $json = $self->json;

    $obj->{version} ||= $self->{version} || '1.1';

    if ($obj->{version} eq '1.0') {
        delete $obj->{version};
        if (exists $obj->{id}) {
            $self->id($obj->{id}) if ($obj->{id}); # if undef, it is notification.
        }
        else {
            $obj->{id} = $self->id || ($self->id('JSON::RPC::Client'));
        }
    }
    else {
        # $obj->{id} = $self->id if (defined $self->id);
	# Assign a random number to the id if one hasn't been set
	$obj->{id} = (defined $self->id) ? $self->id : substr(rand(),2);
    }

    my $content = $json->encode($obj);

    $self->ua->post(
        $uri,
        Content_Type   => $self->{content_type},
        Content        => $content,
        Accept         => 'application/json',
	@$headers,
	($self->{token} ? (Authorization => $self->{token}) : ()),
    );
}



1;
