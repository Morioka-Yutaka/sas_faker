filename P0AE2C06 list;

 %put NOTE- ;
 %put NOTE: Data for package sas_faker, version 0.1.0, license MIT; 
 %put NOTE: *** %superq(packageTitle) ***; 
 %put NOTE- Generated: 2025-07-03T07:39:58; 
 %put NOTE- Author(s): %superq(packageAuthor); 
 %put NOTE- Maintainer(s): %superq(packageMaintainer); 
 %put NOTE- ;
 %put NOTE- Write %nrstr(%%)helpPackage(sas_faker) for the description;
 %put NOTE- ;
 %put NOTE- *** START ***; 

data _null_;
 length lazyData $ 32767; lazyData = lowcase(symget("lazyData"));
run;
%put NOTE- ;
%put NOTE: Data for package sas_faker, version 0.1.0, license MIT;
%put NOTE- *** END ***;

/* lazydata.sas end */

