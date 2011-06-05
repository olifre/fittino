#!/usr/local/bin/perl


$list = "/afs/naf.desy.de/user/p/prudent/grid-fittino/Analyse/scratch_zn/grid-fittino/ListOfParameterPoints_mSUGRA.txt";

open( FILE, $list );
@tab = <FILE>;
while ($ligne = shift @tab) {
    my @p = split(' ',$ligne);
    $name = "$p[0]\_$p[1]\_$p[2]\_$p[3]";
    print "$name\n";
    system("rm Analyse\_$name");
    system("cp Analyse Analyse\_$name");
    system("sed -i 's/XXX/$name/g' Analyse\_$name");
}
close FILE;

