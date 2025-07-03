filename P0AE2C06 list;

%put NOTE: Unloading package sas_faker, version 0.1.0, license MIT;
%put NOTE- *** START ***;

proc sql;
  create table WORK._%sysfunc(datetime(), hex16.)_ as
  select memname, objname, objtype
  from dictionary.catalogs
  where 
  (
   objname in ("*"
   ,'SAS_FAKERIML'
   ,'SAS_FAKERCASLUDF'

   %put NOTE- Element of type macros generated from the file "sas_faker.sas" will be deleted;
   %put NOTE- ;
   ,"SAS_FAKER                                                       "

  )
  and objtype = "MACRO"
  and libname  = "WORK"
  )
  or
  (
   objname in ("*"

  )
  and objtype in ("FORMAT" "FORMATC" "INFMT" "INFMTC")
  and libname  = "WORK"
  and memname = 'SAS_FAKERFORMAT'
  )
  order by objtype, memname, objname
  ;
quit;
data _null_;
  do until(last.memname);
    set WORK._last_;
    by objtype memname;
    if first.memname then call execute("proc catalog cat = work." !! strip(memname) !! " force;");
    call execute("delete " !! strip(objname) !! " /  et =" !! objtype !! "; run;");
  end;
  call execute("quit;");
run;
proc delete data = WORK._last_;
run;
proc fcmp outlib = work.sas_fakerfcmp.package;
run;

proc SQL noprint;
quit;

data _null_; call symputx("_DS2_2_del_",0,"L"); run;
proc SQL noprint;
quit;

run;

data _null_ ;                                                                                        
  length SYSloadedPackages $ 32767;                                                                   
  if SYMEXIST("SYSloadedPackages") = 1 and SYMGLOBL("SYSloadedPackages") = 1 then                     
    do;                                                                                               
      do until(EOF);                                                                                  
        set sashelp.vmacro(where=(scope="GLOBAL" and name="SYSLOADEDPACKAGES")) end=EOF;              
        substr(SYSloadedPackages, 1+offset, 200) = value;                                             
      end;                                                                                            
      SYSloadedPackages = cats("#", translate(strip(SYSloadedPackages), "#", " "), "#");              
      if INDEX(lowcase(SYSloadedPackages), '#sas_faker(0.1.0)#') > 0 then    
         do;                                                                                          
          SYSloadedPackages = tranwrd(SYSloadedPackages, '#sas_faker(0.1.0)#', '##');  
          SYSloadedPackages = compbl(translate(SYSloadedPackages, " ", "#"));                         
          call symputX("SYSloadedPackages", SYSloadedPackages, "G");                                  
          put "NOTE: " SYSloadedPackages = ;                                                          
         end ;                                                                                        
    end;                                                                                              
  stop;                                                                                               
run;                                                                                                  

%put NOTE: Unloading package sas_faker, version 0.1.0, license MIT;
%put NOTE- *** END ***;
%put NOTE- ;

/* unload.sas end */
