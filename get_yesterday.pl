#!/m1/shared/bin/perl

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(( time() - ( 24 * 60 * 60 ) ));
$mon += 1;
$year += 1900;

if ($mon < 10 ) {
	$mon = '0'.$mon;
}
if ($mday < 10 ) {
	$mday = '0'.$mday;
}
$output = $year.$mon.$mday;
print "$output\n";
