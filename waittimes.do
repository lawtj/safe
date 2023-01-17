/* converted from sas7bdat format in R, using haven package (read_sas) */

* remove pediatric and missing values, showing tables of each. 
*Create binary out of window, DART and DART percent variables
gen oow=1 if totalwait>accesstarget
replace oow=0 if oow==.

gen dartyn=0 if totaldart==0
replace dartyn=1 if dartyn==.

gen dartpercent = totaldart/totalwait
replace dartpercent=. if dartpercent==0

*Label deprivation quintiles and rural categories
label define quintileslabel 1 "Most favored" 5 "Most deprived"
label values quintmatrc quintileslabel
label define saclabels 1 "Metropolitan" 4 "Strong influence" 5 "Moderate influence" 6 "Weak influence" 7 "No influence"
label values sactype saclabels

*How many missing observations?
gen quintmiss = 1 if quintmatrc == .
replace quintmiss = 0 if quintmiss != 1
tab quintmiss
drop if missing(quintmatrc)

*PEDIATRICS
gen peds=1 if ageatproced<=17 | serviceareacd=="PAN" | serviceareacd=="PAO" | serviceareacd=="PPS" | serviceareacd=="POT" | serviceareacd=="PAOS" | serviceareacd=="PCS" | serviceareacd=="PAU" | serviceareacd=="PCS" | serviceareacd=="PDS" | serviceareacd=="PGR" | serviceareacd=="PGY"
replace peds=0 if peds==.
tab facilityname if peds==1, sort //Prove that a majority of peds surgery is done at HSC, to justify dropping

*Now remove pediatric cases from dataset for rest of analysis
drop if peds==1 
drop peds
tab quintmiss //compare to previous to see how many missing cases were peds

/////////////////////////////////////////////////////////////////////////begin overall description
*d1 procedures per year
tab procedureyear
bysort procedureyear : gen n = _N if _n == 1
su n //mean procedures per year
hist procedureyear, discrete frequency //histogram of procedures per year

su ageatproced //mean age at procedure
hist ageatproced if ageatproced<=100, discrete percent //histogram of age at procedure
su totalwait, detail //mean waiting time and 95% percentile

* Sanity check - do the quintiles behave as you would expect for rich and poor?
twoway (histogram ageatproced if quintmatrc==1 & ageatproced<110, color(green) discrete) || (hist ageatproced if quintmatrc==5 & ageatproced<110, fcolor(none) lcolor(black) discrete) // rich are skewed older as you would expect

*rich folk live mostly in the cities. so do poor folks. everyone mostly lives in cities.
graph bar (percent),  over(sactype) over(quintmatrc) stack percentages asyvars title("population distribution - where do the rich and poor live?") 

*the metropolitan population is approximately divided into quintiles. no rich folk live in the rural areas, most rich folk live in urban. good.
*since metropolitan population is evenly divided, can't blame long waiting times for the rich on some effect of being metropolitan.
graph bar (percent),  over(quintmatrc) over(sactype) stack percentages asyvars title("population distribution - where do the rich and poor live?") 


**************************************************Descriptive analysis

*W1 wait x material deprivation
	table quintmatrc, c(mean totalwait sd totalwait) format(%9.1f) row

*W1b wait x material deprivation, no metropolitan
	*do the rich still wait longest if you exclude metropolitan areas? yes
	table quintmatrc if sactype!=1, c(mean totalwait sd totalwait) format(%9.1f) row

*W2 wait x matdep x rural
	table quintmatrc sactype, c(mean totalwait) format(%9.1f) row column 
	//skip w3 wait x matdev x age

*W4 wait x social dep
	table quintsocrc, c(mean totalwait sd totalwait) format(%9.1f) row 

*W6 wait x social dep x rural
	table quintsocrc sactype, c(mean totalwait) format(%9.1f) row column 
	//skip w7 wait x social dep x age
table procedureyear, c(mean totalwait) format(%9.1f) row //W8 wait x year
table procedureyear quintmatrc, c(mean totalwait sd totalwait) format(%9.1f) row column //W9 wait x year x material deprivation

*W10 wait x service area
	preserve
	collapse (mean) totalwait, by(serviceareadesc)
	gsort -totalwait
	list serviceareadesc totalwait
	restore
*end w10

table procedureyear serviceareadesc, c(mean totalwait) format(%9.1f) //W11 wait x year x service area
table sactype, c(mean totalwait) format(%9.1f) row //W12 wait x rural
table procedureyear sactype, c(mean totalwait) format(%9.1f) row col //W13 wait x year x rural
tab gendercd if gendercd!="U" //Male to female distribution

*W14 and W14b wait x gender x deprivation, table gives both
	table quintmatrc gendercd if gendercd!="U", c(mean totalwait) format(%9.1f) row col 

tabulate sactype serviceareadesc, row col //w15 proportion of procedures by deprivation and service area
table sactype prioritylevelcd, c(mean totalwait) format(%9.1f) row col //W16 wait x rural x priority
table quintmatrc prioritylevelcd, c(mean totalwait) format(%9.1f) row col //W16b wait x deprivation x priority
tabulate quintmatrc prioritylevel, row col //w17 proportion of procedures by deprivation and priority area
table quintmatrc prioritylevelcd, by(sactype) c(mean totalwait) format(%9.1f) row col //w18 wait x rural x material deprivation x priority
tab3way quintmatrc sactype prioritylevel, nofreq allpct //w19 proportions of priority areas by deprivation and rurality
table sactype gendercd, c(mean totalwait) format(%9.1f) row col //W20 wait x gender x rural
tabulate quintmatrc sactype, row col //w21 & w22 proportion of procedures by deprivation and rural
tabulate quintmatrc sactype if oow==1, row col //w23 & w24 proportion of OOW by deprivation and rural
tabulate sactype oow, row //w25 
tabulate quintmatrc oow, row // w25b
tabulate prioritylevelcd oow, row col //w25c not compiled
tabulate procedureyear oow, row //w26
tab3way procedureyear oow quintmatrc, nofreq rowpct //w27

*begin w28
bysort procedureyear serviceareadesc: egen oowpc=mean(oow)
replace oowpc=100*oowpc
table procedureyear serviceareadesc, c(mean oowpc) format(%9.1f) row
drop oowpc
*end w28

table procedureyear prioritylevelcd quintmatrc, c(mean totalwait) format(%9.1f) row col //w29 wait x priority x deprivation x year
table procedureyear prioritylevelcd, c(mean totalwait) format(%9.1f) row col //w30 wait x priority x year

*begin w31 oow x priority area x year
bysort procedureyear prioritylevelcd: egen oowpc=mean(oow*100)
table procedureyear prioritylevelcd, c(mean oowpc) format (%9.1f) row
drop oowpc
*end w31

table procedureyear serviceareadesc if prioritylevel==1 & quintmatrc==5, c(mean totalwait) format(%9.1f) row col //w32 wait x service area x priority1 AND most DEPRIVED quintile 
table procedureyear serviceareadesc if prioritylevel==1 & quintmatrc==1, c(mean totalwait) format(%9.1f) row col //w33 wait x service area x priority1 AND most FAVORED quintile 
table procedureyear serviceareadesc if prioritylevelcd==1, c(mean totalwait) format(%9.1f) row col //w34 wait x service area x priority1

*w35 & w36 wait x year x hips, knees, cataracts
preserve
keep if serviceareadesc=="Oncology Procedures" | servicedetail1desc=="Cataract" | servicedetail1desc=="Knee" | servicedetail1desc=="Hip" | servicedetail1desc=="Primary Total Hip Replacement" | servicedetail1desc=="Primary Total Knee Replacement" | servicedetail1desc=="Revision Total Knee Replacement" | servicedetail1desc=="Revision Total Hip Replacement"
replace servicedetail1desc=serviceareadesc if serviceareadesc=="Oncology Procedures"
table procedureyear servicedetail1desc, c(mean totalwait) format(%9.1f) row col
restore

*w37 facility volume and waiting time, table and graph 
	preserve
	collapse (mean) totalwait (count) facilitynumber, by(facilityname)
	gsort -facilitynumber
	list facilityname facilitynumber totalwait, clean
	restore

*Regression
	*What's the effect of increasing waiting time on days waited?
	encode gendercd, gen(gender)
	encode serviceareadesc, gen(specialty)
	regress totalwait i.quintmatrc i.sactype i.prioritylevelcd i.gender i.specialty procedureyear if gender!=3
	
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
/*///////////////////////GRAPHS //////////////////////////////// */
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

graph bar (mean) totalwait, over(quintmatrc) title("W1 wait x material deprivation") asyvars legend(position(6) rows(1)) saving(W1, replace) //w1
graph bar (mean) totalwait, over(quintmatrc, label(angle(45) labsize(vsmall))) over(sactype, label(labsize(vsmall))) legend(position(6) rows(1)) asyvars title("W2 Wait x material deprivation x rural") saving(W2, replace) //w2

*W3 wait x material deprivation x age
preserve
collapse (mean) totalwait, by(ageatproced quintmatrc) 
separate totalwait, by (quintmatrc)
label variable totalwait1 "Most favored"
label variable totalwait2 "2"
label variable totalwait3 "3"
label variable totalwait4 "4"
label variable totalwait5 "Most deprived"
twoway (line totalwait1 totalwait2 totalwait3 totalwait4 totalwait5 ageatproced, sort) if ageatproced<=100, legend(rows(1) position(6)) title("W3 Wait x material deprivation x age") saving(W3, replace)
restore
*end W3

graph bar (mean) totalwait, over(quintsocrc) title("W4 Wait x Social Deprivation 1=most favored") saving(W4, replace) //w4 wait x social deprivation
//w5 does not exist
graph bar (mean) totalwait, over(quintsocrc, label(angle(45) labsize(vsmall))) over(sactype, label(labsize(vsmall))) title("W6 Wait x social deprivation x rural") saving(W6, replace) //w6 wait x social deprivation x rural

*W7 wait x social deprivation x age
preserve
collapse (mean) totalwait, by(ageatproced quintsocrc)
separate totalwait, by (quintsocrc)
label variable totalwait1 "Most favored"
label variable totalwait2 "2"
label variable totalwait3 "3"
label variable totalwait4 "4"
label variable totalwait5 "Most deprived"
twoway (line totalwait1 totalwait2 totalwait3 totalwait4 totalwait5 ageatproced, sort) if ageatproced<=100, legend(rows(1) position(6)) title("W7 Wait x social deprivation x age") saving(W7, replace)
restore
*end W7

*w8 wait x year
preserve
collapse (mean) totalwait, by(procedureyear)
twoway (line totalwait procedureyear), title("W8 Average wait x year") saving(W8, replace)
restore

*w9 wait x year x material deprivation
preserve
collapse (mean) totalwait, by(procedureyear quintmatrc)
separate totalwait, by(quintmatrc)
label variable totalwait1 "Most favored"
label variable totalwait2 "2"
label variable totalwait3 "3"
label variable totalwait4 "4"
label variable totalwait5 "Most deprived"
twoway (line totalwait1 totalwait2 totalwait3 totalwait4 totalwait5 procedureyear, sort), legend(rows(1) position(6)) title("w9 Wait x material deprivation x year") saving(W9, replace)
restore

*w9b as above, except as bar graph
graph bar (mean) totalwait, over(quintmatrc) over(procedureyear) asyvars title("w9b Wait x material deprivation x year") legend(position(6) rows(1)) saving(W9b, replace)

*w9c trying to plot the SD on the graph
preserve
collapse (mean) meanwait=totalwait (sd) sdwait=totalwait, by(procedureyear quintmatrc)
generate sdhigh = meanwait + sdwait
generate sdlow = meanwait - sdwait
generate quintyear = quintmatrc if procedureyear == 2006
replace quintyear = quintmatrc+6 if procedureyear == 2007
replace quintyear = quintmatrc+12 if procedureyear == 2008
replace quintyear = quintmatrc+18 if procedureyear == 2009
replace quintyear = quintmatrc+24 if procedureyear == 2010
replace quintyear = quintmatrc+30 if procedureyear == 2011
replace quintyear = quintmatrc+36 if procedureyear == 2012
replace quintyear = quintmatrc+42 if procedureyear == 2013
replace quintyear = quintmatrc+48 if procedureyear == 2014
replace quintyear = quintmatrc+54 if procedureyear == 2015
sort quintyear
list quintyear procedureyear quintmatrc, sepby(procedureyear)
twoway (bar meanwait quintyear if quintmatrc==1) ///
	(bar meanwait quintyear if quintmatrc==2) /// 
	(bar meanwait quintyear if quintmatrc==3) ///
	(bar meanwait quintyear if quintmatrc==4) ///
	(bar meanwait quintyear if quintmatrc==5) ///
	(rcap sdhigh sdlow quintyear), ///
	legend(row(1) order(1 "Least deprived" 2 "2" 3 "3" 4 "4" 5 "Most deprived") position(6) ) ///
	xlabel( 2.5 "2006" 9 "2007" 15 "2008" 21 "2009" 27 "2010" 33 "2011" 39 "2012" 45 "2013" 51 "2014" 57 "2015", noticks) ///
	xtitle("Procedure year") ytitle("Mean wait time")
restore

*w9d wait x procedure year x deprivation, as box plot
graph box totalwait, over(quintmatrc) over(procedureyear) noout asyvars legend(position(6))

*W10 wait x service area
graph bar (mean) totalwait, over(serviceareadesc, label(angle(90) labsize(vsmall)) sort(totalwait) descending) title("W10 wait x service area") saving(W10, replace)

*W11 wait x service area x year
preserve
collapse (mean) totalwait, by(serviceareadesc procedureyear)
separate totalwait, by(serviceareadesc)
label variable totalwait1 "General Surgery"
label variable totalwait2 "Gynaecologic Surgery"
label variable totalwait3 "Neurosurgery"
label variable totalwait4 "Oncology Procedures"
label variable totalwait5 "Ophthalmologic Surgery"
label variable totalwait6 "Oral and Maxillofacial Surgery and Dentistry"
label variable totalwait7 "Orthopaedic Surgery"
label variable totalwait8 "Otolaryngic Surgery"
label variable totalwait9 "Plastic and Reconstructive Surgery"
label variable totalwait10 "Thoracic Surgery"
label variable totalwait11 "Urologic Surgery"
label variable totalwait12 "Vascular Surgery"
twoway (line totalwait1 totalwait2 totalwait3 totalwait4 totalwait5 totalwait6 totalwait7 totalwait8 totalwait9 totalwait10 totalwait11 procedureyear, sort), legend(cols(3) position(6) ) title("w11 Wait x service area x year") saving(W11, replace)
restore

*w12
graph bar (mean) totalwait, over(sactype, label(angle(45))) title("W12 Wait x rural") asyvars legend(position(6) rows(1)) saving(W12, replace)

*w13 wait x rural x  year
preserve
collapse (mean) totalwait, by(procedureyear sactype)
separate totalwait, by(sactype)
label variable totalwait1 "Metropolitan"
label variable totalwait2 "2"
label variable totalwait3 "3"
label variable totalwait4 "Strong influence"
label variable totalwait5 "Moderate influence"
label variable totalwait6 "Weak influence"
label variable totalwait7 "No influence"
twoway (line totalwait1 totalwait2 totalwait3 totalwait4 totalwait5 totalwait6 totalwait7 procedureyear, sort), legend(cols(2)) title("w13 wait x rural x year") saving(W13, replace)
restore

*w13b, wait x rural x year, except as a bar graph
graph bar (mean) totalwait, over(sactype) over(procedureyear) asyvars title("w13b wait x rural x year") legend(position(6) cols(4)) saving(W13b, replace)

*w14 gender x wait
graph bar (mean) totalwait if gendercd!="U", over(gendercd) title("w14 gender x wait") saving(W14, replace)

*w14b gender x wait x quintmatrc
graph bar (mean) totalwait if gendercd!="U", over(gendercd) over(quintmatrc) asyvars saving(W14b, replace) title("W14b gender x wait x deprivation")

*w15
graph bar (count), over(serviceareadesc, descending label(angle(forty_five) labsize(vsmall))) over(sactype, label(angle(forty_five) labsize(vsmall))) asyvars percentages stack legend(size(vsmall) position(6) rows(3)) title("W15 Proportion of service area by rural") saving(W15, replace)

*w15b
graph bar (count), over(serviceareadesc, descending label(angle(forty_five) labsize(vsmall))) over(quintmatrc, label(angle(forty_five) labsize(vsmall))) asyvars percentages stack legend(size(vsmall) position(6) rows(3)) title("W15b Proportion of service area by deprivation")

*w15c proportion service area by year
graph bar (count), over(serviceareadesc, descending label(angle(forty_five) labsize(vsmall))) over(procedureyear, label(angle(forty_five) labsize(vsmall))) asyvars percentages stack legend(size(vsmall) position(6) rows(3)) title("W15c Proportion of service area by year") saving(w15c, replace)

*w16
graph bar (mean) totalwait, over(sactype) over(prioritylevelcd, label(labsize(vsmall))) asyvars title("W16 wait x priority level x rural") legend(position(6) rows(2)) saving(W16, replace)

*w16b
graph bar (mean) totalwait, over(quintmatrc) over(prioritylevelcd, label(labsize(vsmall))) asyvars title("W16b wait x priority level x deprivation") legend(position(6) rows(1)) saving(W16b, replace)

*w17
graph bar (count), over(prioritylevelcd) over(sactype, label(labsize(vsmall))) asyvars percentages stack title("W17 proportion of p1-4 surgeries by rural") saving(W17, replace)

*there is no w18
*there is no w19

*w20
	graph bar (mean) totalwait if gendercd!="U", over(gendercd) over(sactype, label(angle(45))) asyvars title("W20 wait x gender x rural") saving(W20, replace)

*w21
	graph bar (count), over(quintmatrc) over(sactype, label(labsize(vsmall))) asyvars percentages stack legend(rows(1) position(6)) title("W21 proportion of procedures by deprivation and rural") name("w21") saving(W21, replace)

*w22
	graph bar (count), over(sactype, label(labsize(vsmall))) over(quintmatrc, label(labsize(vsmall))) asyvars percentages stack legend(rows(1) position(6)) title("W22 proportion of procedures by rural and deprivation") saving(W22, replace)

*w23
	graph bar (count) if oow==1, over(sactype, label(labsize(vsmall))) over(quintmatrc, label(labsize(vsmall))) asyvars percentages stack legend(size(vsmall) rows(1) position(6)) title("W23 Distribution of OOW by rural and deprivation") name("w23") saving(W23, replace)

*w24
	graph bar (count) if oow==1, over(quintmatrc, label(labsize(vsmall))) over(sactype, label(labsize(vsmall))) asyvars percentages stack legend(size(vsmall) rows(1) position(6)) title("W24 Distribution of OOW by deprivation and rural") name("w24") saving(W24, replace)

*w25
	graph bar (count), over(oow) over(sactype, label(labsize(vsmall))) asyvars percentages stack title("W25 Distribution of OOW by rural") saving(W25, replace)

*w25b
	graph bar (count), over(oow) over(quintmatrc, label(labsize(vsmall))) asyvars percentages stack title("W25b Distribution of OOW by deprivation") saving(W25b, replace)

*w25c NOT compiled
	graph bar (count), over(oow) over(prioritylevelcd, label(labsize(vsmall))) asyvars percentages stack
	
*w26
	bysort procedureyear: egen oowpc=mean(100*oow)
	gen oowpcneg=(100-oowpc)
	label variable oowpc "% out of window"
	label variable oowpcneg "% in window"
	twoway (line oowpc oowpcneg procedureyear), ytitle("OOW %") title("W26 Proportion OOW over time") legend(position(6) rows(1)) saving(W26, replace) 
	drop oowpc
	drop oowpcneg

*w27 & w27b
	bysort procedureyear quintmatrc: egen oowpc=mean(100*oow)
	graph bar (mean) oowpc, over(quintmatrc) over(yearprocedur) asyvars title("W27b OOW% over time, by deprivation") legend(position(6) rows(1)) saving(w27b, replace)
	separate oowpc, by(quintmatrc)
	label variable oowpc1 "Most favored"
	label variable oowpc2 "2"
	label variable oowpc3 "3"
	label variable oowpc4 "4"
	label variable oowpc5 "Most deprived"
	twoway (line oowpc1 oowpc2 oowpc3 oowpc4 oowpc5 procedureyear), ytitle("OOW %") title("W27 OOW% over time, by deprivation") legend(position(6) rows(1)) saving(W27, replace)
	drop oowpc
	drop oowpc1
	drop oowpc2
	drop oowpc3
	drop oowpc4
	drop oowpc5
	
*w27c as above, but for rural
	bysort procedureyear sactype: egen oowpc=mean(100*oow)
	graph bar (mean) oowpc, over(sactype) over(yearprocedur) asyvars title("W27c OOW% over time, by rural") legend(position(6) rows(2)) saving(w27c, replace)

*w28 OOW% by service area by year
	bysort procedureyear serviceareadesc: egen oowpc=mean(100*oow)
	separate oowpc, by(serviceareadesc)
	label variable oowpc1 "General Surgery"
	label variable oowpc2 "Gynaecologic Surgery"
	label variable oowpc3 "Neurosurgery"
	label variable oowpc4 "Oncology Procedures"
	label variable oowpc5 "Ophthalmic Surgery"
	label variable oowpc6 "Oral and Maxillofacial Surgery and Dentistry"
	label variable oowpc7 "Orthopaedic Surgery"
	label variable oowpc8 "Otolaryngic Surgery"
	label variable oowpc9 "Plastic and Reconstructive Surgery"
	label variable oowpc10 "Thoracic Surgery"
	label variable oowpc11 "Urologic Surgery"
	label variable oowpc12 "Vascular Surgery"
	twoway (line oowpc1 oowpc2 oowpc3 oowpc4 oowpc5 oowpc6 oowpc7 oowpc8 oowpc9 oowpc10 oowpc11 oowpc12 procedureyear), legend(position(6) rows(3)) ytitle("OOW%") title("w28 OOW% by service area over time") saving(W28, replace)
	drop oowpc oowpc1 oowpc2 oowpc3 oowpc4 oowpc5 oowpc6 oowpc7 oowpc8 oowpc9 oowpc10 oowpc11 oowpc12
	
*w29 is kind of messy 
/* 
	preserve
	collapse (mean) totalwait, by(prioritylevelcd procedureyear quintmatrc)
	separate totalwait, by(prioritylevelcd)
	label variable totalwait1 "1"
	label variable totalwait2 "2"
	label variable totalwait3 "3"
	label variable totalwait4 "4"
	twoway (line totalwait1 totalwait2 totalwait3 totalwait4 procedureyear, sort), by(quintmatrc) legend(cols(2)) title("w29 wait x priority area x deprivation x year") ytitle("Mean waiting days") saving(W29, replace)	restore
*/
	
*w30 wait x priority area x year
	preserve
	collapse (mean) totalwait, by(prioritylevelcd procedureyear)
	separate totalwait, by(prioritylevelcd)
	label variable totalwait1 "1"
	label variable totalwait2 "2"
	label variable totalwait3 "3"
	label variable totalwait4 "4"
	twoway (line totalwait1 totalwait2 totalwait3 totalwait4 procedureyear, sort), ///
	legend(cols(1)) title("w30 wait x priority area x year") ytitle("Mean waiting days") saving(W30, replace)
	restore

*w31 OOW% x priority x year
	bysort procedureyear prioritylevelcd: egen oowpc=mean(oow*100)
	separate oowpc, by(prioritylevelcd)
	label variable oowpc1 "P1"
	label variable oowpc2 "P2"
	label variable oowpc3 "P3"
	label variable oowpc4 "P4"
	twoway (line oowpc1 oowpc2 oowpc3 oowpc4 procedureyear), title("W31 OOW% by priority, over time") ytitle("OOW%") saving(W31, replace)
	drop oowpc oowpc1 oowpc2 oowpc3 oowpc4

*W32 Wait x serivice area (P1 only)
	gen waitw32=totalwait if prioritylevelcd==1 
	preserve
	collapse (mean) waitw32, by(serviceareadesc procedureyear)
	separate waitw32, by(serviceareadesc)
	label variable waitw321 "General Surgery"
	label variable waitw322 "Gynaecologic Surgery"
	label variable waitw323 "Neurosurgery"
	label variable waitw324 "Oncology Procedures"
	label variable waitw325 "Ophthalmologic Surgery"
	label variable waitw326 "Oral and Maxillofacial Surgery and Dentistry"
	label variable waitw327 "Orthopaedic Surgery"
	label variable waitw328 "Otolaryngic Surgery"
	label variable waitw329 "Plastic and Reconstructive Surgery"
	label variable waitw3210 "Thoracic Surgery"
	label variable waitw3211 "Urologic Surgery"
	label variable waitw3212 "Vascular Surgery"
	twoway (line waitw321 waitw322 waitw323 waitw324 waitw325 waitw326 waitw327 waitw328 waitw329 waitw3210 waitw3211 waitw3212 procedureyear), legend(position(6) rows(3)) title("W32 Wait x serivice area (P1 only)") ytitle("Wait in days") legend(size(vsmall)) saving(W32, replace)
	restore
	drop waitw32

*W33 Wait x serivice area (P1 and most favored only)
	/*
	gen waitw33=totalwait if prioritylevelcd==1 & quintmatrc==1
	preserve
	collapse (mean) waitw33, by(serviceareadesc procedureyear)
	separate waitw33, by(serviceareadesc)
	label variable waitw331 "General Surgery"
	label variable waitw332 "Gynaecologic Surgery"
	label variable waitw333 "Neurosurgery"
	label variable waitw334 "Oncology Procedures"
	label variable waitw335 "Ophthalmologic Surgery"
	label variable waitw336 "Oral and Maxillofacial Surgery and Dentistry"
	label variable waitw337 "Orthopaedic Surgery"
	label variable waitw338 "Otolaryngic Surgery"
	label variable waitw339 "Plastic and Reconstructive Surgery"
	label variable waitw3310 "Thoracic Surgery"
	label variable waitw3311 "Urologic Surgery"
	label variable waitw3312 "Vascular Surgery"
	twoway (line waitw331 waitw332 waitw333 waitw334 waitw335 waitw336 waitw337 waitw338 waitw339 waitw3310 waitw3311 waitw3312 procedureyear), title("W33 Wait x serivice area (P1 and most favored only)") ytitle("Wait in days") legend(size(vsmall)) saving(W33, replace)
	restore
	drop waitw33
	*/
	
*W34 Wait x serivice area (P4 only)
	/* previously wait x service area x p1 x most deprived
	gen waitw33=totalwait if prioritylevelcd==4
	preserve
	collapse (mean) waitw33, by(serviceareadesc procedureyear)
	separate waitw33, by(serviceareadesc)
	label variable waitw331 "General Surgery"
	label variable waitw332 "Gynaecologic Surgery"
	label variable waitw333 "Neurosurgery"
	label variable waitw334 "Oncology Procedures"
	label variable waitw335 "Ophthalmologic Surgery"
	label variable waitw336 "Oral and Maxillofacial Surgery and Dentistry"
	label variable waitw337 "Orthopaedic Surgery"
	label variable waitw338 "Otolaryngic Surgery"
	label variable waitw339 "Plastic and Reconstructive Surgery"
	label variable waitw3310 "Thoracic Surgery"
	label variable waitw3311 "Urologic Surgery"
	label variable waitw3312 "Vascular Surgery"
	twoway (line waitw331 waitw332 waitw333 waitw334 waitw335 waitw336 waitw337 waitw338 waitw339 waitw3310 waitw3311 waitw3312 procedureyear), title("W34 Wait x serivice area (P1 only)") ytitle("Wait in days") legend(size(vsmall)) saving(W34, replace)
	restore
	drop waitw33
	*/
	
*W35 & W36 scrap this graph, see below for better graph
/*	preserve
	keep if servicedetail1desc=="Cataract" | servicedetail1desc=="Knee" | servicedetail1desc=="Hip" | servicedetail1desc=="Primary Total Hip Replacement" | servicedetail1desc=="Primary Total Knee Replacement" | servicedetail1desc=="Revision Total Knee Replacement" | servicedetail1desc=="Revision Total Hip Replacement" | serviceareadesc=="Oncology Procedures"
	replace servicedetail1desc=serviceareadesc if serviceareadesc=="Oncology Procedures"
	collapse (mean) totalwait, by(servicedetail1desc procedureyear)
	separate totalwait, by(servicedetail1desc)
	label variable totalwait1 "Cataract"
	label variable totalwait2 "Hip"
	label variable totalwait3 "Knee"
	label variable totalwait4 "Oncology Procedures"
	label variable totalwait5 "Primary Total Hip Replacement"
	label variable totalwait6 "Primary Total Knee Replacement"
	label variable totalwait7 "Revision Total Hip Replacement"
	label variable totalwait8 "Revision Total Knee Replacement"
	twoway (line totalwait1 totalwait2 totalwait3 totalwait4 totalwait5 totalwait6 totalwait7 totalwait8 procedureyear), legend(position(6) rows(3)) title("W35 Waiting time in Priority areas") saving(W35&36, replace)
	restore */

*W35b priority procedures vs wait times, as per the BMJ article
	gen hpriority = 1 if servicedetail1desc=="Cataract" | servicedetail1desc=="Knee" | servicedetail1desc=="Hip" | servicedetail1desc=="Primary Total Hip Replacement" | servicedetail1desc=="Primary Total Knee Replacement" | serviceareadesc=="Oncology Procedures"
	gen hplabel = servicedetail1desc if hpriority==1 //copy the procedure names to a new label to not mess with the original label
	replace hplabel = "Non-priority procedures" if hpriority==. // label non priority procedures
	replace hplabel = "Oncology Procedures" if serviceareadesc=="Oncology Procedures" //replace the various oncology procedure names with just 'oncology procedures'
	replace hplabel = "Hip" if hplabel=="Primary Total Hip Replacement" //merge hips
	replace hplabel = "Knee" if hplabel=="Primary Total Knee Replacement" //merge knees

	*alternate graph, bar graph
	//graph bar (mean) totalwait, over(hplabel, sort(1)) over(procedureyear) asyvars legend(position(6) rows(1)) title("W35c Waiting time in priority areas")
	
	*line graph looks best
		preserve
			collapse (mean) totalwait=totalwait (sd) sdwait=totalwait, by(hplabel procedureyear)
			gen sdlow = totalwait - sdwait
			gen sdhigh = totalwait + sdwait
			separate totalwait, by(hplabel)
			label variable totalwait1 "Cataract"
			label variable totalwait2 "Hip"
			label variable totalwait3 "Knee"
			label variable totalwait4 "Non-priority procedures"
			label variable totalwait5 "Oncology Procedures"
			twoway (line totalwait1 totalwait2 totalwait3 totalwait4 totalwait5 procedureyear), ///
			legend(position(6) rows(1)) title("W35 Waiting time in Priority areas") saving(W35, replace)
		restore
	
	/* alternate scatter plot with SDs
	twoway (scatter totalwait1 totalwait2 totalwait3 totalwait4 totalwait5 procedureyear) ///
			(rcap sdhigh sdlow procedureyear), ///
			legend(position(6) rows(1)) title("W35 Waiting time in Priority areas") saving(W35, replace)
			*/

*W37 procedure volume and wait time, repeated preserve again here
	preserve
	collapse (mean) totalwait (count) facilitynumber, by(facilityname) //collapses, creating the mean of total wait and the count of facilitynumber (the facility unique id), sorted on facility name
	gsort -facilitynumber *descending sort based on count of facilitynumber (e.g. procedural volume)
	gen id = _n
	la var id "Hospital"
	la var totalwait "Waiting time (days)"
	la var facilitynumber "Procedure volume"
		twoway (scatter facilitynumber id, msize(vsmall)) ///
		(scatter totalwait id, yaxis(2) msize(small) msymbol(x)), ///
		xscale(off) saving(w37, replace) legend(position(6) rows(1)) title("W37 Procedure volume and waiting time by hospital")
	restore

	////////////////////// Graph combine
	*NB have replaced w9 and w13 with b versions (bar graph instead of line)

graph combine w1.gph w2.gph w3.gph w4.gph w6.gph w7.gph w8.gph w9b.gph w10.gph w11.gph w12.gph w13b.gph w14.gph w14b.gph w15.gph w16.gph w16b.gph w17.gph w20.gph w22.gph w23.gph w21.gph w24.gph w25.gph w25b.gph w26.gph w27.gph w27b.gph w28.gph w30.gph w31.gph w32.gph w35&36.gph w37.gph, altshrink saving(combined, replace)
graph export "combined.png", as(png) replace width(2560)

graph combine w1.gph w2.gph w3.gph w4.gph w6.gph w7.gph w8.gph w9b.gph w10.gph w11.gph w12.gph w13b.gph w14.gph w14b.gph w15.gph w15b.gph w16.gph w16b.gph w17.gph w20.gph, altshrink saving(combined1, replace)
graph export "combined1.png", as(png) replace width(3840)
graph combine w22.gph w23.gph w21.gph w24.gph w25.gph w25b.gph w26.gph w27.gph w27b.gph w28.gph w30.gph w31.gph w35.gph w37.gph, altshrink saving(combined2, replace)
graph export "combined2.png", as(png) replace width(3840)

/////////////////////////////////////Exploring why the rich wait longer

* we know from w16b and w2 that the rich wait longer in the city and in all prioirty areas. 
* what about looking ONLY at metropolitan p4?
	graph bar (mean) totalwait if sactype==1 & prioritylevel==4, over(quintmatrc) title("wait x deprivation in metropolitan areas, p4 procedures only") //the rich still wait longer
	table quintmatrc if sactype==1 & prioritylevel==4, c(mean totalwait)
	
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
/*///////////////////////GIS Maps ///////////////////////////// */
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

preserve
collapse (mean) totalwait, by(dauid)
export delimited using "C:\Users\tyler\Dropbox\2. wait times and income\data\partial database\dauid_totalwait.csv", replace
restore
*now save as csv

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
/*///////////////////////survival analysis///////////////////// */
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/*
* divide into 3 year periods	
gen period = 1 if inrange(procedureyear,2006,2008)
replace period = 2 if inrange(procedureyear,2009,2011)
replace period = 3 if inrange(procedureyear,2012,2015)


stset totalwait
*KM priority level
	sts graph if totalwait<=189, fail by(prioritylevelcd) addplot((pci 1 182 0 182 "this is the P4", lcolor(orange) lpattern(dash)) || (pci 1 84 0 84 "P3", lcolor(green)) || (pci 1 28 0 28 "P2", lcolor(red)) || (pci 1 2 0 2 "P1", lcolor(blue))) saving(KM_priority, replace)
	
*KM by deprivation
	sts graph if totalwait<=189, fail by(quintmatrc) saving(KM_material, replace) //where 189 days is the 95th percentile of waiting

*KM by rural	
	sts graph if totalwait<=189, fail by(sactype) saving(KM_sactype, replace)

*KM by priority procedures
	sts graph if totalwait<=189, fail by(hplabel) saving(KM_priorityprocedure, replace)

*KM by priority procedures, look at 3 periods
	sts graph if totalwait<=189 & period==1, fail by(hplabel) saving(KM_priorityprocedure_period1, replace) title("Priority procedures, period 2006-2008")
	sts graph if totalwait<=189 & period==2, fail by(hplabel) saving(KM_priorityprocedure_period2, replace) title("Priority procedures, period 2009-2011")
	sts graph if totalwait<=189 & period==3, fail by(hplabel) saving(KM_priorityprocedure_period3, replace) title("Priority procedures, period 2012-2015")
	graph combine KM_priorityprocedure_period1.gph KM_priorityprocedure_period2.gph KM_priorityprocedure_period3.gph, altshrink saving(KM_priorityprocedure_periods, replace)
	graph export "KM priority procedures 3 periods.png", as(png) replace width(2560)
	
graph combine KM_priority.gph KM_material.gph KM_sactype.gph, altshrink saving(KM, replace)
graph export "KM.png", as(png) replace width(2560)
	
sts graph if totalwait<=358, fail by(quintmatrc) saving(KM_material, replace) //where 358 days is the 99th percentile of waiting
sts graph if totalwait<=189, fail by(quintsocrc) //social deprivation
sts graph if totalwait<=189 & sactype==1, fail by(quintmatrc) // only urban or rural areas

sts graph if totalwait<=358, fail by(sactype) saving(KM_sactype, replace)

sts graph if totalwait<=189, fail by(gendercd)
sts graph if totalwait<=189, fail by(serviceareadesc)

sts graph if totalwait<=189, fail by(oow)

*/
/*
stset totalwait, fail(OOW==1)
stcox i.quintmatrc
stcox i.sactype


