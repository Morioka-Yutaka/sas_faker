filename P0AE2C06 list;

 %put NOTE- ;
 %put NOTE: Loading package sas_faker, version 0.1.0, license MIT; 
 %put NOTE: *** %superq(packageTitle) ***; 
 %put NOTE- Generated: 2025-07-03T07:39:58; 
 %put NOTE- Author(s): %superq(packageAuthor); 
 %put NOTE- Maintainer(s): %superq(packageMaintainer); 
 %put NOTE- ;
 %put NOTE- Run %nrstr(%%)helpPackage(sas_faker) for the description;
 %put NOTE- ;
 %put NOTE- *** START ***; 

data _null_; 
 if NOT ("*"=symget("cherryPick")) then do; 
  put "NOTE- "; 
  put "NOTE: *** Cherry Picking ***"; 
  put "NOTE- Cherry Picking in action!! Be advised that"; 
  put "NOTE- dependencies/required packages will not be loaded!"; 
  put "NOTE- "; 
 end; 
run; 
%include  P0AE2C06(packagemetadata.sas) / nosource2; 

 data _null_;                                                     
  call symputX("packageRequiredErrors", 0, "L");                  
 run;                                                             
 %put NOTE- *Testing required SAS components*%sysfunc(DoSubL(     
 options nonotes nosource %str(;)                                 
 options ls=max ps=max locale=en_US %str(;)                       
 /* temporary redirect log */                                     
 filename _stinit_ TEMP %str(;)                                   
 proc printto log = _stinit_ %str(;) run %str(;)                  
 /* print out setinit */                                          
 proc setinit %str(;) run %str(;)                                 
 proc printto %str(;) run %str(;)                                 
 data _null_ %str(;)                                              
   /* loadup checklist of required SAS components */              
   if _n_ = 1 then                                                
     do %str(;)                                                   
       length req $ 256 %str(;)                                   
       declare hash R() %str(;)                                   
       _N_ = R.defineKey("req") %str(;)                           
       _N_ = R.defineDone() %str(;)                               
       declare hiter iR("R") %str(;)                              
         do req = %bquote(
"BASE SAS SOFTWARE"
) %str(;)        
          _N_ = R.add(key:req,data:req) %str(;)   
         end %str(;)                                              
     end %str(;)                                                  
                                                                  
   /* read in output from proc setinit */                         
   infile _stinit_ end=eof %str(;)                                
   input %str(;)                                                  
                                                                  
   /* if component is in setinit remove it from checklist */      
   if _infile_ =: "---" then                                      
     do %str(;)                                                   
       req = upcase(substr(_infile_, 4, 64)) %str(;)              
       if R.find(key:req) = 0 then                                
         do %str(;)                                               
           _N_ = R.remove() %str(;)                               
         end %str(;)                                              
     end %str(;)                                                  
                                                                  
   /* if checklist is not null rise error */                      
   if eof and R.num_items > 0 then                                
     do %str(;)                                                   
       put "WARNING- ###########################################" %str(;) 
       put "WARNING:  The following SAS components are missing! " %str(;) 
       call symputX("packageRequiredErrors", 0, "L") %str(;)              
       do while(iR.next() = 0) %str(;)                                    
         put "WARNING-   " req %str(;)                                    
       end %str(;)                                                        
       put "WARNING:  The package may NOT WORK as expected      " %str(;) 
       put "WARNING:  or even result with ERRORS!               " %str(;) 
       put "WARNING- ###########################################" %str(;) 
       put %str(;)                                                
     end %str(;)                                                  
 run %str(;)                                                      
 filename _stinit_ clear %str(;)                                  
 options notes source %str(;)                                     
 ))*;                                                             
 data _null_;                                                     
  if 1 = symgetn("packageRequiredErrors") then                    
    do;                                                           
      put "ERROR: Loading package &packageName. will be aborted!";
      put "ERROR- Required components are missing.";              
      put "ERROR- *** STOP ***";                                  
      call symputX("packageRequiredErrors",
     'options ls = &ls_tmp. ps = &ps_tmp. 
       &notes_tmp. &source_tmp. msglevel=&msglevel_tmp. 
       &stimer_tmp. &fullstimer_tmp. ;
       data _null_;abort;run;', "L");              
    end;                                            
  else                                              
    call symputX("packageRequiredErrors", " ", "L");
 run;                                               
 &packageRequiredErrors.                            
 
%if (%str(*)=%superq(cherryPick)) or (sas_faker in %superq(cherryPick)) %then %do; 
  %put NOTE- ;
  %put NOTE: >> Element of type macros from the file "sas_faker.sas" will be included <<;
  %put %sysfunc(ifc(%SYSMACEXIST(sas_faker)=1, NOTE# Macro sas_faker exist. It will be overwritten by the macro from the sas_faker package, ));
  %include P0AE2C06(_06_macros.sas_faker.sas) / nosource2;
%end; 

data _null_;                                   
  call symputX("cherryPick_CASLUDF",  0, "L"); 
run;                                           
data _null_;
length CASLUDF $ 32767;
dtCASLudf = datetime();
CASLUDF =                                      
    '%macro sas_fakerCASLudf('         
 !! "list=1,depList="                          
 !! ')/ des = ''CASL User Defined Functions loader for sas_faker package'';'
 !! '  %if HELP = %superq(list) %then                               '
 !! '    %do;                                                       '
 !! '      %put ****************************************************************************;'
 !! '      %put This is help for the `sas_fakerCASLudf` macro;'
 !! '      %put Parameters (optional) are the following:;'
 !! '      %put - `list` indicates if the list of loaded CASL UDFs should be displayed,;'
 !! '      %put %str(  )when set to the value of `1` (the default) runs `FUNCTIONLIST USER%str(;)`,;'
 !! '      %put %str(  )when set to the value of `HELP` (upcase letters!) displays this help message.;'
 !! '      %put - `depList` [technical] contains the list of dependencies required by the package.;'
 !! '      %put %str(  )for _this_ instance of the macro the default value is: `.;'
 !! '      %put The macro generated: ' !! put(dtCASLudf, E8601DT19.-L) !! ";"
 !! '      %put with the SAS Packages Framework version 20241207.;'
 !! '      %put ****************************************************************************;'
 !! '    %GOTO theEndOfTheMacro;'
 !! '    %end;'
 !! '  %if %superq(depList) ne %then                                '
 !! '    %do;                                                       '
 !! '      %do i = 1 %to %sysfunc(countw(&depList.,%str( )));       '
 !! '        %let depListNm = %scan(&depList.,&i.,%str( ));         '
 !! '        %if %SYSMACEXIST(&depListNm.CASLudf) %then             '
 !! '          %do;                                                 '
 !! '            %&depListNm.CASLudf(list=0)                        '
 !! '          %end;                                                '
 !! '      %end;                                                    '
 !! '    %end;                                                      '
 !! '  %local tmp_NOTES;'                                                                     
 !! '  %let tmp_NOTES = %sysfunc(getoption(NOTES));'                                          
 !! "  filename P0AE2C06 &ZIP. '&path./sas_faker.&zip.';"
 !! "  options nonotes;"                      
 !! '  filename P0AE2C06 clear;'    
 !! '  options &tmp_NOTES.;'                
 !! '   %if 1 = %superq(list) %then '       
 !! '     %do; '                            
 !! "       FUNCTIONLIST USER;"               
 !! "       run;"                             
 !! '     %end; '                           
 !! '%theEndOfTheMacro: %mend;';            
run;

data _null_;
run;
data _null_;
run;
options noNotes;
%if (%str(*)=%superq(cherryPick)) %then %do; 
 data _null_ ;                                                                                              
  length SYSloadedPackages stringPCKG $ 32767;                                                              
  if SYMEXIST("SYSloadedPackages") = 1 and SYMGLOBL("SYSloadedPackages") = 1 then                           
    do;                                                                                                     
      do until(EOF);                                                                                        
        set sashelp.vmacro(where=(scope="GLOBAL" and name="SYSLOADEDPACKAGES")) end=EOF;                    
        substr(SYSloadedPackages, 1+offset, 200) = value;                                                   
      end;                                                                                                  
      SYSloadedPackages = cats("#", translate(strip(SYSloadedPackages), "#", " "), "#");                    
      indexPCKG = INDEX(lowcase(SYSloadedPackages), '#sas_faker(');                           
      if indexPCKG = 0 then                                                                                 
         do;                                                                                                
          SYSloadedPackages = catx('#', SYSloadedPackages, 'sas_faker(0.1.0)');              
          SYSloadedPackages = compbl(translate(SYSloadedPackages, " ", "#"));                               
          call symputX("SYSloadedPackages", SYSloadedPackages, "G");                                        
          put / "INFO:[SYSLOADEDPACKAGES] " SYSloadedPackages ;                                             
         end ;                                                                                              
      else                                                                                                  
         do;                                                                                                
          stringPCKG = kscanx(substr(SYSloadedPackages, indexPCKG+1), 1, '#');                              
          SYSloadedPackages = compbl(tranwrd(SYSloadedPackages, strip(stringPCKG), "#"));                   
          SYSloadedPackages = catx('#', SYSloadedPackages, 'sas_faker(0.1.0)');              
          SYSloadedPackages = compbl(translate(SYSloadedPackages, " ", "#"));                               
          call symputX("SYSloadedPackages", SYSloadedPackages, "G");                                        
          put / "INFO:[SYSLOADEDPACKAGES] " SYSloadedPackages ;                                             
         end ;                                                                                              
    end;                                                                                                    
  else                                                                                                      
    do;                                                                                                     
      call symputX('SYSloadedPackages', 'sas_faker(0.1.0)', 'G');                            
      put / 'INFO:[SYSLOADEDPACKAGES] sas_faker(0.1.0)';                                      
    end;                                                                                                    
  stop;                                                                                                     
 run;                                                                                                       
%end; 

options NOTES;
%put NOTE- ;
%put NOTE: Loading package sas_faker, version 0.1.0, license MIT;
%put NOTE- *** END ***;

options &temp_noNotes_etc.;
%symdel temp_noNotes_etc / noWarn;
/* load.sas end */

