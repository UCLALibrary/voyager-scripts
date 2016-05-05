#!/m1/shared/bin/perl -w
############################################################
# This script takes a filename and key as parameters and 
# returns a value where the file is of the form 
# "key\tvalue".
#
# Last revised: 2006-09-13 chunt
############################################################

use strict;

# There should be exactly two arguments. If there are not,
# show usage and exit.
if ($#ARGV != 1)
{
	print "$#ARGV\n";
	show_usage();
}
# Otherwise continue.
else
{
	my($filename) = shift(@ARGV);
	my($search_key) = shift(@ARGV);

	open(FILE, $filename) or die("Could not open file \"$filename\":\n\t$!");
	while (my $line = <FILE>)
	{
		chomp($line);
		my($key, $value) = split('\t', $line);
		if ($key eq $search_key)
		{
			print "$value\n";
			exit(1);
		}
	}

}

sub show_usage 
{
	print <<USAGE;
Usage:
	get_value.pl filename key

Where:
	filename is the name of the file that contains key/value pairs.
	key is the key for the value that is desired.
USAGE

	return;
}
