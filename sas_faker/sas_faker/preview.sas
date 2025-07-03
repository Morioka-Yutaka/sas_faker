filename P0AE2C06 list;

 %put NOTE- ;
 %put NOTE: Preview of the sas_faker package, version 0.1.0, license MIT;
 %put NOTE: *** %superq(packageTitle) ***; 
 %put NOTE- Generated: 2025-07-03T07:39:58; 
 %put NOTE- Author(s): %superq(packageAuthor); 
 %put NOTE- Maintainer(s): %superq(packageMaintainer); 
 %put NOTE- ;
 %put NOTE- *** START ***;

%let ls_tmp     = %sysfunc(getoption(ls));         
%let ps_tmp     = %sysfunc(getoption(ps));         
%let notes_tmp  = %sysfunc(getoption(notes));      
%let source_tmp = %sysfunc(getoption(source));     
options ls = MAX ps = MAX nonotes nosource;        
%include P0AE2C06(packagemetadata.sas) / nosource2; 

data _null_;                                                 
  if strip(symget("helpKeyword")) = " " then                 
    do until (EOF);                                          
      infile P0AE2C06(description.sas) end = EOF;  
      input;                                                 
      put _infile_;                                          
    end;                                                     
  else stop;                                                 
run;                                                         

data WORK._%sysfunc(datetime(), hex16.)_;                      
infile cards4 dlm = "/";                                       
input @;                                                       
if 0 then output;                                              
length helpKeyword $ 64;                                       
retain helpKeyword "*";                                        
drop helpKeyword;                                              
if _N_ = 1 then helpKeyword = strip(symget("helpKeyword"));    
if FIND(_INFILE_, helpKeyword, "it") or helpKeyword = "*" then 
 do;                                                           
   input (folder order type file fileshort) (: $ 256.);        
   output;                                                     
 end;                                                          
cards4;                                                        
06_macros/06/macros/sas_faker.sas/sas_faker/'%sas_faker()'
;;;;
run;

data _null_;                                                                        
if upcase(strip(symget("helpKeyword"))) in (" " "LICENSE") then do; stop; end;      
if NOBS = 0 then do; 
put; put ' *> No preview. Try %previewPackage(packageName,*) to display all.'; put; stop; 
end; 
  do until(EOFDS);                                                                  
   set WORK._last_ end = EOFDS nobs = NOBS;                                         
   length memberX $ 1024;                                                           
   memberX = cats("_",folder,".",file);                                             
   call execute("data _null_;                                                    ");
   call execute('infile P0AE2C06(' || strip(memberX) || ') end = EOF;  ');
   call execute("    do until(EOF);                                              ");
   call execute("      input;                                                    ");
   call execute("      put _infile_;                                             ");
   call execute("    end;                                                        ");
   call execute("  put "" "" / "" "";                                            ");
   call execute("  stop;                                                         ");
   call execute("run;                                                            ");
  end; 
  stop; 
run; 
proc delete data = WORK._last_; 
run; 
options ls = &ls_tmp. ps = &ps_tmp. &notes_tmp. &source_tmp.; 

%put NOTE: Preview of the sas_faker package, version 0.1.0, license MIT;
%put NOTE- *** END ***;

/* preview.sas end */
