#!/m1/shared/bin/perl -w

use lib "/usr/local/bin/voyager/perl";
use MARC::Batch;
use UCLA_Batch; #for UCLA_Batch::safenext to better handle data errors

my $batch = MARC::Batch->new('USMARC', $ARGV[0]);
my $type = $ARGV[1] or die "Must enter type: auth, bib, or mfhd\n";

# my $yymmdd = get_yymmdd();

# 20050526 akohler: turn off strict validation - otherwise, all records after error are lost
$batch->strict_off();

#while ($record = $batch->next()) {
while ($record = UCLA_Batch::safenext($batch)) {
  # Get 005 field
  $field = $record->field('005');
  my $yyyymm = substr $field->as_string, 0, 6;
  my $filename = "deleted.$type.$yyyymm.mrc";
  # Voyager MARC is UTF-8, so be sure that's what we write
  open OUT, '>>:utf8', $filename or die "Cannot open output file $filename: $!\n";
  print OUT $record->as_usmarc();
  close OUT;
}

exit 0;

sub get_yymmdd {
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
  $year-=100; # add 1900, subtract 2000, to get current 2-digit year for 2000-2099
  if ( $year <= 9 ) {
    $year = "0".$year;
  }
  $mon+=1;    # localtime gives $mon as 0..11
  if ( $mon <= 9 ) {
    $mon = "0".$mon;
  }
  if ( $mday <= 9 ) {
    $mday = "0".$mday;
  }
  return $year.$mon.$mday;
}

