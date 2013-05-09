#!/usr/bin/perl
# 0xAF: this script is alternative to sendxmpp, which was not working for me
# Requirements: Net::Jabber and all it's requirements (obviously)
# License: WTFPL
# NOTE: wont work for GMail probably.

use strict;
use Net::Jabber qw/Client/;

# configuration
my $server   = "jabber.org";
my $enc      = 0; # 0 = off, 1 = tls, 2 = ssl
my $port     = 0; # 0 = defaults (5223 for ssl, 5222 for others)
my $username = 'username'; # w/o the @domain.tld part
my $password = "password";
my $resource = "someresource";
my $subject  = undef; #'Automated message'; # send message if set or send chat if not defined

########################
# leave the rest alone #
########################

my $debuglevel = 0; # 0|1|2

die qq{usage: $0 [jid_1] [jid_2] [...]
examples:
	$0 af\@jabber.com
	[message will be read from STDIN, terminated with CTRL-D or a dot on an empty line]
or
	echo 'this is my message sent to "af" and "twister"' | $0 af\@itc.bg twister\@itc.bg
} unless ($#ARGV >= 0);

$port = ($enc == 2 ? 5223 : 5222) unless ($port);

my $c = new Net::Jabber::Client( debuglevel => $debuglevel );

my $status = $c->Connect(
	hostname => $server,
	port     => $port,
	tls      => ($enc == 1 ? 1 : 0),
	ssl      => ($enc == 2 ? 1 : 0),
) or die "Connect error: ".$c->GetErrorCode()."\n";

my @auth = $c->AuthSend(
	username => $username,
	password => $password,
	resource => $resource,
);
die "Auth Error: ".$auth[1]."\n" unless ($auth[0] eq 'ok');

my $body = '';
while (<STDIN>) {
	last if (/^\.$/); # dot on empty line
	$body .= $_;
}
chomp($body);

foreach (@ARGV) {
	$c->MessageSend(
		to       => $_,
		body     => $body,
		priority => 10,
		type     => ( defined($subject) ? undef : 'chat' ),
		subject  => ( defined($subject) ? "Automated message" : undef),
	);
}

$c->Disconnect();

