 
  /* Temporary replacement of loadPackage() macro. */                      
  %macro ICEloadPackage(                                                   
    packageName                         /* name of a package */            
  , path = %sysfunc(pathname(packages)) /* location of a package */        
  , options = %str(LOWCASE_MEMNAME)     /* possible options for ZIP */     
  , zip = zip                           /* file ext. */                    
  , requiredVersion = .                 /* required version */             
  , source2 = /* source2 */                                                
  , suppressExec = 0                    /* suppress execs */               
  )/secure;                                                                
    %PUT ** NOTE: Package sas_faker loaded in ICE mode **;       
    %local _PackageFileref_;                                               
    /* %let _PackageFileref_ = P%sysfunc(MD5(%lowcase(&packageName.)),hex7.); */                  
    data _null_;                                                                                  
     call symputX("_PackageFileref_", "P" !! put(MD5("%lowcase(&packageName.)"), hex7. -L), "L"); 
    run;                                                                                          
    filename &_PackageFileref_. &ZIP.                                      
      "&path./%lowcase(&packageName.).&zip." %unquote(&options.)           
    ;                                                                      
    %include &_PackageFileref_.(packagemetadata.sas) / &source2.;          
    filename &_PackageFileref_. clear;                                     
    %local rV pV rV0 pV0 rVsign;                                           
    %let pV0 = %sysfunc(compress(&packageVersion.,.,kd));                  
    %let pV = %sysevalf((%scan(&pV0.,1,.,M)+0)*1e8                         
                      + (%scan(&pV0.,2,.,M)+0)*1e4                         
                      + (%scan(&pV0.,3,.,M)+0)*1e0);                       
                                                                           
    %let rV0 = %sysfunc(compress(&requiredVersion.,.,kd));                 
    %let rVsign = %sysfunc(compress(&requiredVersion.,<=>,k));             
    %if %superq(rVsign)= %then %let rVsign=<=;                             
    %else %if NOT (%superq(rVsign) IN (%str(=) %str(<=) %str(=<) %str(=>) %str(>=) %str(<) %str(>))) %then 
      %do;                                                                                                 
        %put WARNING: Illegal operatopr "%superq(rVsign)"! Default(<=) will be used.;                      
        %put WARNING- Supported operators are: %str(= <= =< => >= < >);                                    
        %let rVsign=<=;                                                    
      %end;                                                                
    %let rV = %sysevalf((%scan(&rV0.,1,.,M)+0)*1e8                         
                      + (%scan(&rV0.,2,.,M)+0)*1e4                         
                      + (%scan(&rV0.,3,.,M)+0)*1e0);                       
                                                                           
    %if NOT %sysevalf(&rV. &rVsign. &pV.) %then                            
      %do;                                                                 
        %put ERROR: Package &packageName. will not be loaded!;             
        %put ERROR- Required version is &rV0.;                             
        %put ERROR- Provided version is &pV0.;                             
        %put ERROR- Condition %bquote((&rV0. &rVsign. &pV0.)) evaluates to %sysevalf(&rV. &rVsign. &pV.);  
        %put ERROR- Verify installed version of the package.;              
        %put ERROR- ;                                                      
        %GOTO WrongVersionOFPackage; /*%RETURN;*/                          
      %end;                                                                
    filename &_PackageFileref_. &ZIP.                                      
      "&path./%lowcase(&packageName.).&zip." %unquote(&options.)           
      ENCODING =                                                           
        %if %bquote(&packageEncoding.) NE %then &packageEncoding. ;        
                                          %else utf8 ;                     
    ;                                                                      
    %local cherryPick; %let cherryPick=*;                                  
    %local tempLoad_minoperator;                                           
    %let tempLoad_minoperator = %sysfunc(getoption(minoperator));          
    options minoperator;                                                   
    %if %superq(suppressExec) NE 1 %then %let suppressExec = 0;            
    %include &_PackageFileref_.(load.sas) / &source2.;                     
    options &tempLoad_minoperator.;                                        
    filename &_PackageFileref_. clear;                                     
    %WrongVersionOFPackage:                                                
  %mend ICEloadPackage;                                                    
 
