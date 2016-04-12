#!/m1/shared/bin/perl -w

#use FindBin;
#use lib "$FindBin::Bin";
use lib "/opt/local/perl";
use MARC::Batch;
use UCLA_Batch; #for UCLA_Batch::safenext to better handle data errors

my $marcfile = $ARGV[0] or die "Must provide marc input filename\n";
my $startdate = $ARGV[1] or die "Must provide startdate as yyyymmdd\n";
my $enddate = $ARGV[2] or die "Must provide enddate as yyyymmdd\n";

my $batch = MARC::Batch->new('USMARC', $marcfile);
# 20050526 akohler: turn off strict validation - otherwise, all records after error are lost
$batch->strict_off();

#while ($record = $batch->next()) {
while ($record = UCLA_Batch::safenext($batch)) {
  # Get 005 field
  $field = $record->field('005');
  $yyyymmdd = substr $field->as_string(), 0, 8;
  next unless $yyyymmdd >= $startdate and $yyyymmdd <= $enddate;
  $field = $record->field('001');
  # Just send output to stdout
  print $field->as_string(), "\n";
}

# close OUT;
exit 0;

