#!/m1/shared/bin/perl -w

use lib "/usr/local/bin/voyager/perl";
use MARC::Batch;
use UCLA_Batch; #for UCLA_Batch::safenext to better handle data errors
use strict;

if ($#ARGV != 1) {
  print "\nUsage: $0 infile outfile\n";
  print "outfile will contain records from infile with duplicates removed.\n";
  exit 1;
}

my $infile = $ARGV[0];
my $outfile = $ARGV[1];

my $batch = MARC::Batch->new('USMARC', $infile);
# 20080429 akohler: BSLW records are now in UTF-8
#open OUT130, '>:utf8', $out130file;
#open OUTNO130, '>:utf8', $outno130file;

# Hash to contain records as they're read from file and the set is de-duped
# Key is 001 field (generally OCLC#), value is the binary MARC record itself.
my %deduped_records;

# MARC::Batch doesn't check encoding, so get it from record(s) as read
my $encoding;

# 20050526 akohler: turn off strict validation - otherwise, all records after error are lost
$batch->strict_off();

#while ($record = $batch->next()) {
while (my $record = UCLA_Batch::safenext($batch)) {
  my $fld001 = $record->field('001')->as_string();
  # Naive, unsorted, QAD: keep final version of record per source file, discard all others
  $deduped_records{$fld001} = $record;

  # Capture current encoding (UTF-8 vs MARC-8) from record;
  # assume all records in file have that encoding (naive, but always true for PromptCat)
  $encoding = $record->encoding();
}

# Open file for output using the correct encoding
if ($encoding eq "UTF-8") {
  open OUT, '>:utf8', $outfile;
}
else {
  open OUT, '>', $outfile;
}

# Output the deduped records
for my $fld001 (keys %deduped_records) {
  my $record = $deduped_records{$fld001};
  print OUT $record->as_usmarc();
}

close OUT;

exit 0;

