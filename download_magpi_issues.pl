#!/usr/bin/perl
#
use strict;
use warnings;

for (my $i=1; $i <= 70; $i++) {
	my $url = "https://magpi.raspberrypi.org/issues/$i/pdf";
	print "$url\n";
	my $download_url = `lynx --dump $url|grep -i MagPi|grep original|tail -1|awk '{print \$2}'`;
	next unless $download_url;
	print "Download PDF: >$download_url<\n";

	system("wget -O MagPi-$i.pdf '$download_url'");
}
