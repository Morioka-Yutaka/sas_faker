# sas_faker
SAS package to create dummy data in CDISC format for clinical trials
Purpose: A macro to generate dummy clinical trial data. Creates datasets in SDTM (DM, AE, SV, VS) and ADaM (ADSL, ADAE，ADVS, ADTTE) formats.
Generates pseudo subject data, vital signs, study visits, and adverse events based on user-specified group numbers and sample sizes.

<img width="180" height="180" alt="Image" src="https://github.com/user-attachments/assets/bc07dd1e-8dd4-432b-a0a3-03bb33a7df4c" />

~~~sas  
/*example*/
%sas_faker(n_groups=2,
                 n_per_group=50, 
                 output_lib=WORK)
~~~

# dm domain
Dummy is designed to be a randomized parallel-group　study, with a low probability of discontinuation or death data.
![Image](https://github.com/user-attachments/assets/a4ba4c51-793e-451d-ac23-c7d936d13ee4)

# ae domain
For rights reasons, meddra variables have non-standard CDISC variable names, event names are dummy generated, and the dictionary form has the same structure as MedDRA, but is specific and different from MedDRA.
For example, variables related to toxicity, such as severity, are set to be less likely to occur at higher values.
![Image](https://github.com/user-attachments/assets/814db470-1a4c-47cb-931e-f956bebbffba)

# vs domain
Synchronized with the VISIT information of SV domain.
Values are stable from participant to participant and rise and fall with random errors. No systematic differences are built into the values between groups or time series.
![Image](https://github.com/user-attachments/assets/8bce7257-0c12-4a15-9b42-63b724dc368f)

# sv domain
Synchronized with the VISIT information of the domain of the Finding Class.
![Image](https://github.com/user-attachments/assets/ca99d459-4436-495e-b74a-51dbb1d5e2f9)

# adsl dataset
It is created based on the information in the SDTM, mainly in the DM domain. For example, WEIGHTBL is consistent with VS domain information, which should basically be consistent with SDTM information.
![Image](https://github.com/user-attachments/assets/804820d5-1284-4aec-853d-beaa31b15600)

# adae dataset
Created from AE domain information and ADSL
![Image](https://github.com/user-attachments/assets/488ddfe0-6eb6-45fe-9269-32da5989f169)

# advs dataset
Created from VS domain information and ADSL
![Image](https://github.com/user-attachments/assets/db22e49f-8b5e-4e33-a9c2-6830c37bf47e)

# adtte dataset
The event times are adjusted for differences in appearance in the Kaplan-Meier curves for each Treatment Group(TRTP). If there are many groups, the same distribution will appear.
![Image](https://github.com/user-attachments/assets/30cfa97e-c7a1-4206-a148-6d670397f14e)
~~~sas  
proc lifetest data=adtte
  plots=survival(atrisk=1 7 14 21 28 35 42 49 56 63 70 77);
  time AVAL * CNSR(1);
  strata TRTPN ;
run;
~~~
<img width="484" alt="Image" src="https://github.com/user-attachments/assets/d8fd5dbb-eaab-4e6a-aee7-1b34b029654b" />


# %sas_faker
Purpose: A macro to generate dummy clinical trial data. Creates datasets in SDTM (DM, AE, SV, VS) and ADaM (ADSL, ADAE) formats.
         Generates pseudo subject data, vital signs, study visits, and adverse events based on user-specified group numbers and sample sizes.<br>
         
Author: [Yutaka Morioka]<br>
Date: July 2, 2025<br>
Version: 0.1<br>

Input Parameters:
  - n_groups: Number of groups (default=2)
  - n_per_group: Number of subjects per group (default=50)
  - output_lib: Output library (default=WORK)
  - seed: Random seed (default=123456)
  - create_dm: Flag to generate DM dataset (Y/N, default=Y)
  - create_ae: Flag to generate AE dataset (Y/N, default=Y)
  - create_sv: Flag to generate SV dataset (Y/N, default=Y)
  - create_vs: Flag to generate VS dataset (Y/N, default=Y)
  - create_adsl: Flag to generate ADSL dataset (Y/N, default=Y)
  - create_adae: Flag to generate ADAE dataset (Y/N, default=Y)
  - create_adae: Flag to generate ADTTE dataset (Y/N, default=Y)
If, for example, create_dm is set to N and no DM domain is created, ADSL is not affected. All datasets are created harmoniously once in the background.

Output:
  - SDTM datasets: DM, AE, SV, VS (if specified) <br>
  - ADaM datasets: ADSL, ADAE, ADVS, ADTTE (if specified) <br>

Notes: 
  - Uses a random seed for reproducible data generation.
  - Utilizes the minimize_charlen macro to optimize character variable lengths.
  - Generated data mimics the structure of clinical trial data but is not real.
  - Variable names related to MeDRA dictionary (e.g., F_AELLTCD, F_AEPTCD) are prefixed with "F_" to avoid infringement of intellectual property rights.
  - Adverse event terms and codes (AETERM, AEDECOD, AEBODSYS, etc.) are structured systematically but are fictitious dictionary coding data and unrelated to the actual MeDRA dictionary.

~~~sas  
/*example*/
** Generate data with 3 treatment groups, 100 subjects per group.
%generate_clinical_dummy_data(
n_groups=3,
n_per_group=100,
seed=789012)
~~~

# version history<br>
0.1.0(03July2025): Initial version<br>

## What is SAS Packages?  
The package is built on top of **SAS Packages framework(SPF)** developed by Bartosz Jablonski. 
For more information about SAS Packages framework, see [SAS_PACKAGES](https://github.com/yabwon/SAS_PACKAGES).  
You can also find more SAS Packages(SASPACs) in [SASPAC](https://github.com/SASPAC).

## How to use SAS Packages? (quick start)
### 1. Set-up SPF(SAS Packages Framework)
Firstly, create directory for your packages and assign a fileref to it.
~~~sas      
filename packages "\path\to\your\packages";
~~~
Secondly, enable the SAS Packages Framework.  
(If you don't have SAS Packages Framework installed, follow the instruction in [SPF documentation](https://github.com/yabwon/SAS_PACKAGES/tree/main/SPF/Documentation) to install SAS Packages Framework.)  
~~~sas      
%include packages(SPFinit.sas)
~~~  
### 2. Install SAS package  
Install SAS package you want to use using %installPackage() in SPFinit.sas.
~~~sas      
%installPackage(packagename, sourcePath=\github\path\for\packagename)
~~~
(e.g. %installPackage(ABC, sourcePath=https://github.com/XXXXX/ABC/raw/main/))  
### 3. Load SAS package  
Load SAS package you want to use using %loadPackage() in SPFinit.sas.
~~~sas      
%loadPackage(packagename)
~~~
### Enjoy😁
