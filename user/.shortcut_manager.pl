#!/usr/bin/perl

use strict;

my $DEBUG=2; # enable syslog debugging

# run this script without parameters to print the configuration on the screen.

# configuration format is:
# 'appname1' => ( # use `xdotool getactivewindow getwindowname` to get the name of the active window (you can use substring here)
#    'key_name1' => 'command to execute',
#    'key_name2' => 'command to execute',
# ),
# qr/konsole/i => ( # to match any app with 'konsole' title
#    'key_name1' => 'command to execute',
#    'key_name2' => 'command to execute',
# ),


my %config = (
	# for the kde konsole
	qr/konsole/i => {
		# mouse btn 9
		'mb9' => qq{ xte "keydown Control_L" "key Page_Up"   "keyup Control_L" },

		# mouse btn 8
		'mb8' => qq{ xte "keydown Control_L" "key Page_Down" "keyup Control_L" },

		# mouse btn 6 (scroll left)
		'mb6' => qq{ tmux previous-window },

		# mouse btn 7 (scroll right)
		'mb7' => qq{ tmux next-window },
	},

	qr/kontact/i => {
		'mb9' => qq{ xte "str +" }, # next unread msg
		#'mb8' => qq{ xte "keydown Alt_L" "str +" "keyup Alt_L" }, # next unread folder
		'mb8' => qq{ xte "keydown Alt_L" "key KP_Add" "keyup Alt_L" }, # next unread folder
	},

	# for firefox
	qr/firefox|chromium/i => {
		# mouse btn 9
		#'mb9' => qq{ xte "keydown Control_L" "key Page_Up"   "keyup Control_L" },
		'mb9' => qq{ xte "keydown Alt_L" "key Left" "keyup Alt_L" },

		# mouse btn 8
		#'mb8' => qq{ xte "keydown Control_L" "key Page_Down" "keyup Control_L" },
		'mb8' => qq{ xte "keydown Alt_L" "key Right" "keyup Alt_L" },

		# mouse btn 6 (scroll left)
		#'mb6' => qq{ xte "keydown Alt_L" "key Left" "keyup Alt_L" },
		'mb6' => qq{ xte "keydown Control_L" "key Page_Up"   "keyup Control_L" },

		# mouse btn 7 (scroll right)
		#'mb7' => qq{ xte "keydown Alt_L" "key Right" "keyup Alt_L" },
		'mb7' => qq{ xte "keydown Control_L" "key Page_Down" "keyup Control_L" },
	},

	qr/Code - OSS/i => {
		# mouse btn 9
		'mb9' => qq{ xte "keydown Control_L" "key Page_Up"   "keyup Control_L" },

		# mouse btn 8
		'mb8' => qq{ xte "keydown Control_L" "key Page_Down" "keyup Control_L" },

		# mouse btn 6
		'mb6' => qq{ xte "keydown Control_L" "key Page_Up"   "keyup Control_L" },

		# mouse btn 7
		'mb7' => qq{ xte "keydown Control_L" "key Page_Down" "keyup Control_L" },
	},

);

# sanitize
foreach my $app (keys %config) {
	foreach my $key (keys %{$config{$app}}) {
		$config{$app}{$key} =~ s/^[\r\n\s]*(.*)[\r\n\s]*$/$1/;
	}
}

unless ($#ARGV == 0) {
	print qq{Shortcuts manager. Use with xbindtool.
Author: Stanislav Lechev <af\@0xAF.org>
License: WTFPL http://www.wtfpl.net/

usage: $0 <key_name>

};

	foreach my $app (sort keys %config) {
		print "$app:\n";
		foreach my $key ( sort keys %{$config{$app}} ) {
			print sprintf "  %15s: %s\n", $key, $config{$app}{$key};
		}
	}
	exit 1;
}


# find a matching app
my $appname = `xdotool getactivewindow getwindowname`;
# xdotool getwindowfocus getwindowname
$appname =~ s/^[\r\n\s]*(.*)[\r\n\s]*$/$1/;

my $found = 0;
foreach my $app (keys %config) {
	if ($appname =~ /$app/) {
		foreach my $key ( keys %{$config{$app}} ) {
			if ($ARGV[0] eq $key) {
				system("logger 'executing command on [$app] for shortcut [$key]: [$config{$app}{$key}]'") if ($DEBUG > 1);
				system($config{$app}{$key});
				system("logger 'command [$config{$app}{$key}] failed: [$?]'") if ($? != 0);
				$found++;
			}
		}
	}
}

unless ($found) {
	print "not found action for [$ARGV[0]] on active window [$appname]\n";
	system("logger 'not found action for [$ARGV[0]] on active window [$appname]'") if ($DEBUG);
	exit 1;
}

