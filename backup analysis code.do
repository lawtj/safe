/* backup code */


/* begin analysis */
* first task is to do chi squared on pre and post values of variables that look like they might change

* what are the variables of interest?
/* 
	****
	Communication: comm_consent comm_indication checklist_signin checklist_timeout checklist_signout

	**** equipment checking
	equipment_monitoring___1-equipment_others___4

	**** preop checks
	>>> these are the ones that have yes = 1 and no = 2 labels
		prep_preop-prep_neonatal
		>>>> NB prep_ivaccess_ and prep_fluids_ do not have ANY 'no' answers so should be excluded from tabulation
	
	
	>>> these have checked = 1 and unchecked = 0 as answers 
		prep_preop_parts___1-prep_neonatal_which___5
*/

/* Chi2 of pre/post and communication of indication, sign in, time out and sign out */
* displays expected frequencies as the second item, to confirm none are below 5 and don't need to use Fischer's exact.

foreach i of varlist equipment_monitoring___1-equipment_airway___7 equipment_drugs___1-prep_neonatal_which___5 {
	tabulate `i' phase2, chi2 expected exact
}

/*
***** here are the significant results from chi2
	>>>> equipment
	>>>> all are checked/unchecked
	>>>> note the following with expected values < 5, using fisher exact, and not significant: 
				equipment_others___2 operating table with tilt
	
				equipment_monitoring___4 equipment_airway___2 equipment_airway___4 equipment_airway___6 equipment_airway___7 equipment_drugs___3 equipment_drugs___6
	
	
	
	>>>> communication
	>>>> yes/no
	>>>> comm consent has expected <5, still positive with fishers exact
		comm_consent comm_indication checklist_signin checklist_timeout checklist_signout

	>>>> preop checks
		>>>>> yes/no
		>>>>> prep_neonatal has exp<5, positive with exact
		prep_preop prep_machine prep_airwaychecked prep_suction prep_neonatal 
		
		>>>>> checked/unchecked
		prep_preop_parts___1 prep_preop_parts___4 prep_machine_parts___1 prep_machine_parts___2
	
	>>>> drugs
		>>>> checked/unchecked
		>>>>
		prep_drugs___1-prep_drugs___4
	
	>>>> last set of equipment, drugs, neonatal stuff
	>>>> checked/unchecked
		prep_airwaychecked_which___2 prep_vasopressor_parts___1 prep_neonatal_which___2 prep_neonatal_which___5
	
*/

/* 

Now we run regular odds ratio and mixed effects regression the variables which had a significant pre/immediate post difference, across all phases this time

*/


* >>>>> equipment >>>>>>>>>>>>

foreach i of varlist equipment_monitoring___4 equipment_airway___2 equipment_airway___4 equipment_airway___6 equipment_airway___7 equipment_drugs___3 equipment_drugs___6 {
	tabodds `i' phase if phase != 4, or
	melogit `i' i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
}

* >>>>> communication >>>>>>>>>>>

foreach i of varlist comm_consent2 comm_indication2 checklist_signin2 checklist_timeout2 checklist_signout2 {
	tabodds `i' phase if phase != 4, or
	melogit `i' i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
}

* >>>>> preop checks >>>>>>>>>>>

		
foreach i of varlist prep_preop2 prep_machine2 prep_airwaychecked2 prep_suction2 {
	tabodds `i' phase if phase != 4, or
	melogit `i' i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
}

/*

NB NB NB

prep_neonatal2 fails the standard melogit
it works with meqrlogit - need to ask aaron


*/

* >>>>> drugs >>>>>>>>>>>

foreach i of varlist prep_drugs___1-prep_drugs___4 {
	tabodds `i' phase if phase != 4, or
	melogit `i' i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
}

* >>>>> last set >>>>>>>>>>>
foreach i of varlist prep_airwaychecked_which___2 prep_vasopressor_parts___1 prep_neonatal_which___2 prep_neonatal_which___5 {
	tabodds `i' phase if phase != 4, or
	melogit `i' i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
}



* >>>>>> Spinal packet analysis >>>>>>>>>>>>>>

** spinal behavior analysis
** starting with descriptives
foreach i of varlist spinal_hat-spinal_oxytocin_how {
tabulate `i' phase, col
}

** now spinal chi2 on pre and post values
foreach i of varlist spinal_hat-spinal_oxytocin_how {
	tabulate `i' phase2, chi2 expected exact
}

/* Chi2 results
spinal hat				all yes results, no stats performed
spinal maks				all yes results, no stats performed
spinal gloves			all yes results, no stats performed
spinal cleaning			not significant
spinal sterile field	significant increase
spinal titlt			significant increase
spinal vitals			not significant
spinal block height		significant increase
vasopressors			significant DECREASE
antibiotics				significant increase
oxytocin administered	not significant
oxytocin timing			not significant
present in theatre		not significant
BP monitored			not significant
HR monitored			not significant
SPO2 monitored			not significant

*/

** now spinal odds ratio


foreach i of varlist spinal_sterile2 spinal_wedge2 spinal_height2-spinal_abx2 {
	tabodds `i' phase if phase != 4, or
	melogit `i' i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
}

****


********* programattic export ******

/* 
foreach i of varlist equipment_monitoring___1-equipment_airway___7 equipment_drugs___1-prep_neonatal_which___5 {
	tabulate `i' phase2, chi2 expected exact
	}
*/


capture program drop mysumtab
program define mysumtab
	syntax varlist using[, replace append ]
	tempname fh
	file open `fh' `using', write `replace' `append'
	file write `fh' "variable" _tab "mean" _tab "sd"
	foreach v of local varlist{
		quietly summarize `v'
		file write `fh' _n "`v'" _tab (r(mean)) _tab (r(sd))
		}
	file close `fh'
end

mysumtab equipment_monitoring___1-equipment_airway___7 using example.txt, append

file open fh using test1.csv, write replace
file write fh "variable" "," ///
"label" "," ///
"chi2" "," ///
"p_value" ","  ///
"exact" ","  ///
"or_immediate" ","  ///
"OR6" ","  ///
"OR12" ","  ///
"p_imm" ","  ///
"p_6" ","  ///
"p12" ","  ///
"lci_imm" ","  ///
"lci6" ","  ///
"lci12" ","  ///
"uci_imm" ","  ///
"uci6" ","  ///
"uci12" ","  ///
"adj_or_immediate" ","  ///
"adj_OR6" ","  ///
"adj_OR12" ","  ///
"adj_p_imm" ","  ///
"adj_p_6" ","  ///
"adj_p12" ","  ///
"adj_lci_imm" ","  ///
"adj_lci6" ","  ///
"adj_lci12" ","  ///
"adj_uci_imm" ","  ///
"adj_uci6" ","  ///
"adj_uci12" ","
foreach i of varlist comm_consent comm_indication checklist_signin checklist_timeout checklist_signout{
	quietly tabulate `i' phase2, chi2 expected exact
	local name: variable label `i'
	file write fh _n "`i'" "," "`name'" "," (r(chi2)) "," (r(p)) "," (r(p_exact)) ","
	if r(p) < .05 | r(p_exact) <.05{
		logistic `i'2 i.phase if phase != 4
		matrix row1 = r(table)
		file write fh (row1[1,2]) "," (row1[1,3]) "," (row1[1,4]) "," (row1[4,2]) "," (row1[4,3]) "," (row1[4,4]) "," ///
		(row1[5,2]) "," (row1[5,3]) "," (row1[5,4]) "," /// lower CI
		(row1[6,2]) "," (row1[6,3]) "," (row1[6,4]) "," /* upper CI */
		melogit `i'2 i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
		matrix row1 = r(table)
		file write fh (row1[1,2]) "," (row1[1,3]) "," (row1[1,4]) "," (row1[4,2]) "," (row1[4,3]) "," (row1[4,4]) "," ///
		(row1[5,2]) "," (row1[5,3]) "," (row1[5,4]) "," /// lower CI
		(row1[6,2]) "," (row1[6,3]) "," (row1[6,4]) "," /* upper CI */
		}
	else {
		continue
		}
}
file close fh


/* final program!   */
file open fh using test1.csv, write replace
file write fh "variable" "," ///
"label" "," ///
"chi2" "," ///
"p_value" ","  ///
"exact" ","  ///
"or_immediate" ","  ///
"OR6" ","  ///
"OR12" ","  ///
"p_imm" ","  ///
"p_6" ","  ///
"p12" ","  ///
"lci_imm" ","  ///
"lci6" ","  ///
"lci12" ","  ///
"uci_imm" ","  ///
"uci6" ","  ///
"uci12" ","  ///
"adj_or_immediate" ","  ///
"adj_OR6" ","  ///
"adj_OR12" ","  ///
"adj_p_imm" ","  ///
"adj_p_6" ","  ///
"adj_p12" ","  ///
"adj_lci_imm" ","  ///
"adj_lci6" ","  ///
"adj_lci12" ","  ///
"adj_uci_imm" ","  ///
"adj_uci6" ","  ///
"adj_uci12" ","
foreach i of varlist spinal_gloves spinal_hat{
	quietly tabulate `i' phase2, chi2 expected exact matcell(o)
	local name: variable label `i'
	file write fh _n "`i'" "," "`name'" "," (r(chi2)) ","
	mata: o = st_matrix("o")
	mata: st_matrix("e", (rowsum(o)* colsum(o)) / sum(o)) 
	mata: mata clear
	if e[1,1] >7 & e[1,2] >7 & e[2,1] >7 & e[2,2] >7{
		file write fh (r(p)) "," "" ","
		if r(p) > .05{
			continue
			}
		else{
			quietly logistic `i'2 i.phase if phase != 4
			matrix row1 = r(table)
			file write fh (row1[1,2]) "," (row1[1,3]) "," (row1[1,4]) "," (row1[4,2]) "," (row1[4,3]) "," (row1[4,4]) "," ///
			(row1[5,2]) "," (row1[5,3]) "," (row1[5,4]) "," /// lower CI
			(row1[6,2]) "," (row1[6,3]) "," (row1[6,4]) "," /* upper CI */
			quietly melogit `i'2 i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
			matrix row1 = r(table)
			file write fh (row1[1,2]) "," (row1[1,3]) "," (row1[1,4]) "," (row1[4,2]) "," (row1[4,3]) "," (row1[4,4]) "," ///
			(row1[5,2]) "," (row1[5,3]) "," (row1[5,4]) "," /// lower CI
			(row1[6,2]) "," (row1[6,3]) "," (row1[6,4]) "," /* upper CI */
			}
		}
	else{
		file write fh "" "," (r(p_exact)) ","
		if r(p_exact) > .05 {
			continue
			}
		else {
			quietly logistic `i'2 i.phase if phase != 4
			matrix row1 = r(table)
			file write fh (row1[1,2]) "," (row1[1,3]) "," (row1[1,4]) "," (row1[4,2]) "," (row1[4,3]) "," (row1[4,4]) "," ///
			(row1[5,2]) "," (row1[5,3]) "," (row1[5,4]) "," /// lower CI
			(row1[6,2]) "," (row1[6,3]) "," (row1[6,4]) "," /* upper CI */
			quietly melogit `i'2 i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
			matrix row1 = r(table)
			file write fh (row1[1,2]) "," (row1[1,3]) "," (row1[1,4]) "," (row1[4,2]) "," (row1[4,3]) "," (row1[4,4]) "," ///
			(row1[5,2]) "," (row1[5,3]) "," (row1[5,4]) "," /// lower CI
			(row1[6,2]) "," (row1[6,3]) "," (row1[6,4]) "," /* upper CI */
		}
	}
}
file close fh

/* can i make it into a program? */
capture program drop comparestats
program define comparestats
	syntax varlist using[, replace append ]
	tempname fh
	file open `fh' `using', write `replace' `append'
	file write `fh' "variable" "," ///
	"label" "," ///
	"chi2" "," ///
	"p_value" ","  ///
	"exact" ","  ///
	"or_immediate" ","  ///
	"OR6" ","  ///
	"OR12" ","  ///
	"p_imm" ","  ///
	"p_6" ","  ///
	"p12" ","  ///
	"lci_imm" ","  ///
	"lci6" ","  ///
	"lci12" ","  ///
	"uci_imm" ","  ///
	"uci6" ","  ///
	"uci12" ","  ///
	"adj_or_immediate" ","  ///
	"adj_OR6" ","  ///
	"adj_OR12" ","  ///
	"adj_p_imm" ","  ///
	"adj_p_6" ","  ///
	"adj_p12" ","  ///
	"adj_lci_imm" ","  ///
	"adj_lci6" ","  ///
	"adj_lci12" ","  ///
	"adj_uci_imm" ","  ///
	"adj_uci6" ","  ///
	"adj_uci12" ","
	foreach i of local varlist{
		quietly tabulate `i' phase2, chi2 expected exact matcell(o)
		local name: variable label `i'
		file write `fh' _n "`i'" "," "`name'" "," (r(chi2)) ","
		mata: o = st_matrix("o")
		mata: st_matrix("e", (rowsum(o)* colsum(o)) / sum(o)) 
		mata: mata clear
		if e[1,1] >7 & e[1,2] >7 & e[2,1] >7 & e[2,2] >7{
			file write `fh' (r(p)) "," "" ","
			if r(p) > .05{
				continue
				}
			else{
				quietly logistic `i'2 i.phase if phase != 4
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) "," (row1[1,3]) "," (row1[1,4]) "," (row1[4,2]) "," (row1[4,3]) "," (row1[4,4]) "," ///
				(row1[5,2]) "," (row1[5,3]) "," (row1[5,4]) "," /// lower CI
				(row1[6,2]) "," (row1[6,3]) "," (row1[6,4]) "," /* upper CI */
				quietly melogit `i'2 i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) "," (row1[1,3]) "," (row1[1,4]) "," (row1[4,2]) "," (row1[4,3]) "," (row1[4,4]) "," ///
				(row1[5,2]) "," (row1[5,3]) "," (row1[5,4]) "," /// lower CI
				(row1[6,2]) "," (row1[6,3]) "," (row1[6,4]) "," /* upper CI */
				}
			}
		else{
			file write `fh' "" "," (r(p_exact)) ","
			if r(p_exact) > .05 {
				continue
				}
			else {
				quietly logistic `i'2 i.phase if phase != 4
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) "," (row1[1,3]) "," (row1[1,4]) "," (row1[4,2]) "," (row1[4,3]) "," (row1[4,4]) "," ///
				(row1[5,2]) "," (row1[5,3]) "," (row1[5,4]) "," /// lower CI
				(row1[6,2]) "," (row1[6,3]) "," (row1[6,4]) "," /* upper CI */
				quietly melogit `i'2 i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) "," (row1[1,3]) "," (row1[1,4]) "," (row1[4,2]) "," (row1[4,3]) "," (row1[4,4]) "," ///
				(row1[5,2]) "," (row1[5,3]) "," (row1[5,4]) "," /// lower CI
				(row1[6,2]) "," (row1[6,3]) "," (row1[6,4]) "," /* upper CI */
			}
		}
	}
	file close `fh'
end

