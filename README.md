# sas_faker
SAS package to create dummy data in CDISC format for clinical trials
Purpose: A macro to generate dummy clinical trial data. Creates datasets in SDTM (DM, AE, SV, VS) and ADaM (ADSL, ADAE，ADVS, ADTTE) formats.
Generates pseudo subject data, vital signs, study visits, and adverse events based on user-specified group numbers and sample sizes.

![sas_faker](./sas_faker_small.png)  

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
For rights reasons, meddra variables have non-standard CDISC variable names, event names are dummy generated, and the dictionary form has the same structure as MedDRA, but is specific and different from MedDRA
![Image](https://github.com/user-attachments/assets/814db470-1a4c-47cb-931e-f956bebbffba)

# vs domain
Synchronized with the VISIT information of SV domain.
![Image](https://github.com/user-attachments/assets/8bce7257-0c12-4a15-9b42-63b724dc368f)

# sv domain
Synchronized with the VISIT information of the domain of the Finding Class.
![Image](https://github.com/user-attachments/assets/ca99d459-4436-495e-b74a-51dbb1d5e2f9)
