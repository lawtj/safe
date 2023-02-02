version 13
clear

import delimited record_id redcap_survey_identifier baseline_packet_1_ma_v_0 phase obs_date obs_time observer_id pt_id_number anesthetist_id safe_yn refresher_yn cadre cadre_other case_asa case_urgency case_initialtechnique indication___1 indication___2 indication___3 indication___4 indication___5 indication___6 indication___7 indication___8 indication___9 indication___10 indication___11 indication___13 indication___14 indication___12 indication_other indication_additional ecl_coag ecl_antihtn ecl_mgs04 ecl_avoidspinal ecl_garsi time_informed time_or time_incision incisiontype incisiontype_other incisiontime time_birth time_skinclosed baseline_measured baseline_hr baseline_sbp baseline_dbp baseline_spo2 team___1 team___2 team___3 team___4 team___5 team___12 team___6 team___7 team___8 team___9 team___10 team___11 team_other equipment_monitoring___1 equipment_monitoring___2 equipment_monitoring___3 equipment_monitoring___4 equipment_airway___1 equipment_airway___2 equipment_airway___3 equipment_airway___4 equipment_airway___5 equipment_airway___6 equipment_airway___7 equipment_spinalneedle equipment_drugs___1 equipment_drugs___2 equipment_drugs___3 equipment_drugs___4 equipment_drugs___5 equipment_drugs___6 equipment_drugs___7 equipment_others___1 equipment_others___2 equipment_others___3 equipment_others___4 comm_consent comm_indication checklist_signin checklist_timeout checklist_signout prep_preop prep_hb prep_machine prep_gadrugs prep_airwaychecked prep_suction prep_vasopressor prep_neonatal prep_ivaccess prep_fluids prep_preop_parts___1 prep_preop_parts___2 prep_preop_parts___3 prep_preop_parts___4 prep_machine_parts___1 prep_machine_parts___2 prep_drugs___1 prep_drugs___2 prep_drugs___3 prep_drugs___4 prep_airwaychecked_which___1 prep_airwaychecked_which___2 prep_vasopressor_parts___1 prep_vasopressor_parts___2 prep_vasopressor_parts___3 prep_vasopressor_parts___4 prep_neonatal_which___1 prep_neonatal_which___2 prep_neonatal_which___3 prep_neonatal_which___4 prep_neonatal_which___5 unstructured apgar1 apgar5 final_ordeath final_hospitaldeath final_pttransfer final_date baseline_packet_1_ma_v_1 spinal_packet_2_timestamp spinal_drug spinal_dose spinal_adjunct___1 spinal_adjunct___2 spinal_hat spinal_mask spinal_gloves spinal_clean spinal_sterile spinal_wedge spinal_vitals spinal_height spinal_vasopressor spinal_abx spinal_oxytocin spinal_oxytocintime spinal_present spinal_vitals_which___1 spinal_vitals_which___2 spinal_vitals_which___3 spinal_oxytocin_dose spinal_oxytocin_how adverse_failed_spinal adverse_spinal_failed_y___1 adverse_spinal_failed_y___2 adverse_loc adverse_hypoxia adverse_persistent_hypo adverse_hypo_which___1 adverse_hypo_which___2 adverse_major_hemorrhage spinal_end_where spinal_end_who spinal_end_monitors___1 spinal_end_monitors___2 spinal_end_monitors___3 spinal_unstructured spinal_packet_2_complete general_anesthesia_p_v_2 ga_tilt ga_help ga_preo2 ga_cricoid ga_tubeposition ga_secure ga_vitals ga_abx ga_oxytocin ga_oxytocintime ga_present ga_extubated ga_vitals_which___1 ga_vitals_which___2 ga_vitals_which___3 ga_oxytocin_dose ga_oxytocin_how ga_extubation_which___1 ga_extubation_which___2 ga_extubation_which___3 ga_adverse_diffaw ga_diffaw_which___1 ga_diffaw_which___2 ga_diffaw_which___3 ga_diffaw_which___4 ga_diffaw_which___5 ga_diffaw_which___6 ga_adverse_cicv ga_adverse_hypoxia ga_adverse_hypoxia_when___1 ga_adverse_hypoxia_when___2 ga_adverse_hypoxia_when___3 ga_adverse_hypoxia_when___4 ga_adverse_regurg ga_adverse_regurg_asp ga_adverse_hypotension ga_adverse_hypo_which___1 ga_adverse_hypo_which___2 ga_adverse_bleeding ga_adverse_seizure ga_adverse_arrest ga_end_where ga_end_who ga_end_monitors___1 ga_end_monitors___2 ga_end_monitors___3 ga_unstructured general_anesthesia_p_v_3 emergencies_packet_4_timestamp adverse_hem_bloodavail adverse_hem_xmatch adverse_hem_lbiv adverse_hem_garsi adverse_hem_txa adverse_hem_noblood adverse_arrest_help adverse_arrest_airway adverse_arrest_breathing adverse_arrest_o2 adverse_arrest_pulse adverse_arrest_tilt adverse_arrest_fluids adverse_arrest_bp adverse_arrest_communicate adverse_neo_attempt adverse_neo_timer adverse_neo_dries adverse_neo_towel adverse_neo_airway adverse_neo_breathing adverse_neo_hr adverse_neo_5breath adverse_neo_5morebreath adverse_neo_compressions adverse_other_equip adverse_other_power adverse_other_o2 adverse_unstructured emergencies_packet_4_complete using "SAFEEvaluationTanzan_DATA_NOHDRS_2021-05-06_1040.csv", varnames(nonames)

label data "SAFEEvaluationTanzan_DATA_NOHDRS_2021-05-06_1040.csv"

label define phase_ 1 "Pre-SAFE" 2 "Immediately post SAFE" 3 "6 months post SAFE" 4 "Never attended SAFE" 5 "12-mo post SAFE" 
label define observer_id_ 1 "A - Beti" 2 "B - Brendan" 3 "P - Privatus" 4 "M - Mutter" 5 "D - Dulla" 
label define anesthetist_id_ 1 "MB-A" 2 "MB-B" 3 "MB-C" 4 "MB-D" 5 "MB-E" 46 "MB-F" 47 "MB-G" 6 "R-A" 7 "R-B" 8 "R-C" 9 "R-D" 10 "R-E" 11 "R-F" 43 "R-G" 12 "K-A" 13 "K-B" 14 "K-C" 15 "K-D" 16 "Z-A" 17 "Z-B" 18 "Z-C" 19 "Z-D" 20 "Z-E" 21 "Z-F" 22 "Z-G" 23 "Z-H" 24 "Z-I" 25 "Z-J" 26 "Z-K" 27 "Z-L" 48 "Z-M" 28 "NJ-A" 29 "NJ-B" 30 "NJ-C" 31 "NJ-D" 32 "NJ-E" 33 "NJ-F" 45 "NJ-G" 34 "IR-A" 35 "IR-B" 36 "IR-C" 37 "IR-D" 38 "IR-E" 39 "IR-F" 40 "IR-G" 41 "IR-H" 42 "IR-I" 44 "IR-J" 49 "Z-N" 50 "NJ-H" 51 "NJ-I" 52 "NJ-J" 53 "Z-O" 
label define safe_yn_ 1 "Yes" 0 "No" 
label define refresher_yn_ 1 "Yes" 0 "No" 
label define cadre_ 1 "Medical officer (MO)" 2 "Assistant MO" 3 "Nurse anesthetist" 4 "Assistant nurse anaesthetist" 5 "Other (specify)" 
label define case_asa_ 1 "ASA 1" 2 "ASA 2" 3 "ASA 3" 4 "ASA 4" 5 "ASA 5" 6 "Not documented" 
label define case_urgency_ 1 "Elective" 2 "Emergency" 
label define case_initialtechnique_ 1 "Spinal" 2 "General" 
label define indication___1_ 0 "Unchecked" 1 "Checked" 
label define indication___2_ 0 "Unchecked" 1 "Checked" 
label define indication___3_ 0 "Unchecked" 1 "Checked" 
label define indication___4_ 0 "Unchecked" 1 "Checked" 
label define indication___5_ 0 "Unchecked" 1 "Checked" 
label define indication___6_ 0 "Unchecked" 1 "Checked" 
label define indication___7_ 0 "Unchecked" 1 "Checked" 
label define indication___8_ 0 "Unchecked" 1 "Checked" 
label define indication___9_ 0 "Unchecked" 1 "Checked" 
label define indication___10_ 0 "Unchecked" 1 "Checked" 
label define indication___11_ 0 "Unchecked" 1 "Checked" 
label define indication___13_ 0 "Unchecked" 1 "Checked" 
label define indication___14_ 0 "Unchecked" 1 "Checked" 
label define indication___12_ 0 "Unchecked" 1 "Checked" 
label define ecl_coag_ 1 "Yes" 2 "No" 
label define ecl_antihtn_ 1 "Yes" 2 "No" 
label define ecl_mgs04_ 1 "Yes" 2 "No" 
label define ecl_avoidspinal_ 1 "Yes" 2 "No" 
label define ecl_garsi_ 1 "Yes" 2 "No" 
label define incisiontype_ 1 "Lower transverse" 2 "Classical" 3 "T-incision" 4 "Other" 
label define baseline_measured_ 1 "True" 0 "False" 
label define team___1_ 0 "Unchecked" 1 "Checked" 
label define team___2_ 0 "Unchecked" 1 "Checked" 
label define team___3_ 0 "Unchecked" 1 "Checked" 
label define team___4_ 0 "Unchecked" 1 "Checked" 
label define team___5_ 0 "Unchecked" 1 "Checked" 
label define team___12_ 0 "Unchecked" 1 "Checked" 
label define team___6_ 0 "Unchecked" 1 "Checked" 
label define team___7_ 0 "Unchecked" 1 "Checked" 
label define team___8_ 0 "Unchecked" 1 "Checked" 
label define team___9_ 0 "Unchecked" 1 "Checked" 
label define team___10_ 0 "Unchecked" 1 "Checked" 
label define team___11_ 0 "Unchecked" 1 "Checked" 
label define equipment_monitoring___1_ 0 "Unchecked" 1 "Checked" 
label define equipment_monitoring___2_ 0 "Unchecked" 1 "Checked" 
label define equipment_monitoring___3_ 0 "Unchecked" 1 "Checked" 
label define equipment_monitoring___4_ 0 "Unchecked" 1 "Checked" 
label define equipment_airway___1_ 0 "Unchecked" 1 "Checked" 
label define equipment_airway___2_ 0 "Unchecked" 1 "Checked" 
label define equipment_airway___3_ 0 "Unchecked" 1 "Checked" 
label define equipment_airway___4_ 0 "Unchecked" 1 "Checked" 
label define equipment_airway___5_ 0 "Unchecked" 1 "Checked" 
label define equipment_airway___6_ 0 "Unchecked" 1 "Checked" 
label define equipment_airway___7_ 0 "Unchecked" 1 "Checked" 
label define equipment_drugs___1_ 0 "Unchecked" 1 "Checked" 
label define equipment_drugs___2_ 0 "Unchecked" 1 "Checked" 
label define equipment_drugs___3_ 0 "Unchecked" 1 "Checked" 
label define equipment_drugs___4_ 0 "Unchecked" 1 "Checked" 
label define equipment_drugs___5_ 0 "Unchecked" 1 "Checked" 
label define equipment_drugs___6_ 0 "Unchecked" 1 "Checked" 
label define equipment_drugs___7_ 0 "Unchecked" 1 "Checked" 
label define equipment_others___1_ 0 "Unchecked" 1 "Checked" 
label define equipment_others___2_ 0 "Unchecked" 1 "Checked" 
label define equipment_others___3_ 0 "Unchecked" 1 "Checked" 
label define equipment_others___4_ 0 "Unchecked" 1 "Checked" 
label define comm_consent_ 1 "Yes" 2 "No" 
label define comm_indication_ 1 "Yes" 2 "No" 
label define checklist_signin_ 1 "Yes" 2 "No" 
label define checklist_timeout_ 1 "Yes" 2 "No" 
label define checklist_signout_ 1 "Yes" 2 "No" 
label define prep_preop_ 1 "Yes" 2 "No" 
label define prep_hb_ 1 "Yes" 2 "No" 
label define prep_machine_ 1 "Yes" 2 "No" 
label define prep_gadrugs_ 1 "Yes" 2 "No" 
label define prep_airwaychecked_ 1 "Yes" 2 "No" 
label define prep_suction_ 1 "Yes" 2 "No" 
label define prep_vasopressor_ 1 "Yes" 2 "No" 
label define prep_neonatal_ 1 "Yes" 2 "No" 
label define prep_ivaccess_ 1 "Yes" 2 "No" 
label define prep_fluids_ 1 "Yes" 2 "No" 
label define prep_preop_parts___1_ 0 "Unchecked" 1 "Checked" 
label define prep_preop_parts___2_ 0 "Unchecked" 1 "Checked" 
label define prep_preop_parts___3_ 0 "Unchecked" 1 "Checked" 
label define prep_preop_parts___4_ 0 "Unchecked" 1 "Checked" 
label define prep_machine_parts___1_ 0 "Unchecked" 1 "Checked" 
label define prep_machine_parts___2_ 0 "Unchecked" 1 "Checked" 
label define prep_drugs___1_ 0 "Unchecked" 1 "Checked" 
label define prep_drugs___2_ 0 "Unchecked" 1 "Checked" 
label define prep_drugs___3_ 0 "Unchecked" 1 "Checked" 
label define prep_drugs___4_ 0 "Unchecked" 1 "Checked" 
label define prep_airwaychecked_which___1_ 0 "Unchecked" 1 "Checked" 
label define prep_airwaychecked_which___2_ 0 "Unchecked" 1 "Checked" 
label define prep_vasopressor_parts___1_ 0 "Unchecked" 1 "Checked" 
label define prep_vasopressor_parts___2_ 0 "Unchecked" 1 "Checked" 
label define prep_vasopressor_parts___3_ 0 "Unchecked" 1 "Checked" 
label define prep_vasopressor_parts___4_ 0 "Unchecked" 1 "Checked" 
label define prep_neonatal_which___1_ 0 "Unchecked" 1 "Checked" 
label define prep_neonatal_which___2_ 0 "Unchecked" 1 "Checked" 
label define prep_neonatal_which___3_ 0 "Unchecked" 1 "Checked" 
label define prep_neonatal_which___4_ 0 "Unchecked" 1 "Checked" 
label define prep_neonatal_which___5_ 0 "Unchecked" 1 "Checked" 
label define final_ordeath_ 1 "Yes" 2 "No" 
label define final_hospitaldeath_ 1 "Yes" 2 "No" 
label define final_pttransfer_ 1 "Yes" 2 "No" 
label define baseline_packet_1_ma_v_1_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define spinal_drug_ 1 "Bupivicaine - 0.25%" 2 "Bupivicaine - 0.5%" 3 "Bupivicaine - 0.75%" 4 "Lidocaine - 5%" 
label define spinal_adjunct___1_ 0 "Unchecked" 1 "Checked" 
label define spinal_adjunct___2_ 0 "Unchecked" 1 "Checked" 
label define spinal_hat_ 1 "Yes" 2 "No" 
label define spinal_mask_ 1 "Yes" 2 "No" 
label define spinal_gloves_ 1 "Yes" 2 "No" 
label define spinal_clean_ 1 "Yes" 2 "No" 
label define spinal_sterile_ 1 "Yes" 2 "No" 
label define spinal_wedge_ 1 "Yes" 2 "No" 
label define spinal_vitals_ 1 "Yes" 2 "No" 
label define spinal_height_ 1 "Yes" 2 "No" 
label define spinal_vasopressor_ 1 "Yes" 2 "No" 
label define spinal_abx_ 1 "Yes" 2 "No" 
label define spinal_oxytocin_ 1 "Yes" 2 "No" 
label define spinal_oxytocintime_ 1 "Yes" 2 "No" 
label define spinal_present_ 1 "Yes" 2 "No" 
label define spinal_vitals_which___1_ 0 "Unchecked" 1 "Checked" 
label define spinal_vitals_which___2_ 0 "Unchecked" 1 "Checked" 
label define spinal_vitals_which___3_ 0 "Unchecked" 1 "Checked" 
label define spinal_oxytocin_dose_ 1 "5 units" 2 "10 units" 3 ">10 units" 
label define spinal_oxytocin_how_ 1 "Bolus" 2 "Infusion" 3 "Both" 
label define adverse_failed_spinal_ 1 "Yes" 0 "No" 
label define adverse_spinal_failed_y___1_ 0 "Unchecked" 1 "Checked" 
label define adverse_spinal_failed_y___2_ 0 "Unchecked" 1 "Checked" 
label define adverse_loc_ 1 "Yes" 0 "No" 
label define adverse_hypoxia_ 1 "Yes" 0 "No" 
label define adverse_persistent_hypo_ 1 "Yes" 0 "No" 
label define adverse_hypo_which___1_ 0 "Unchecked" 1 "Checked" 
label define adverse_hypo_which___2_ 0 "Unchecked" 1 "Checked" 
label define adverse_major_hemorrhage_ 1 "Yes" 0 "No" 
label define spinal_end_where_ 1 "In theatre" 2 "Designated recovery room" 3 "Corridor" 4 "Ward" 5 "HDU/ICU" 
label define spinal_end_who_ 1 "Yes" 0 "No" 
label define spinal_end_monitors___1_ 0 "Unchecked" 1 "Checked" 
label define spinal_end_monitors___2_ 0 "Unchecked" 1 "Checked" 
label define spinal_end_monitors___3_ 0 "Unchecked" 1 "Checked" 
label define spinal_packet_2_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define ga_tilt_ 1 "Yes" 2 "No" 
label define ga_help_ 1 "Yes" 2 "No" 
label define ga_preo2_ 1 "Yes" 2 "No" 
label define ga_cricoid_ 1 "Yes" 2 "No" 
label define ga_tubeposition_ 1 "Yes" 2 "No" 
label define ga_secure_ 1 "Yes" 2 "No" 
label define ga_vitals_ 1 "Yes" 2 "No" 
label define ga_abx_ 1 "Yes" 2 "No" 
label define ga_oxytocin_ 1 "Yes" 2 "No" 
label define ga_oxytocintime_ 1 "Yes" 2 "No" 
label define ga_present_ 1 "Yes" 2 "No" 
label define ga_extubated_ 1 "Yes" 2 "No" 
label define ga_vitals_which___1_ 0 "Unchecked" 1 "Checked" 
label define ga_vitals_which___2_ 0 "Unchecked" 1 "Checked" 
label define ga_vitals_which___3_ 0 "Unchecked" 1 "Checked" 
label define ga_oxytocin_dose_ 1 "5 units" 2 "10 units" 3 ">10 units" 
label define ga_oxytocin_how_ 1 "Bolus" 2 "Infusion" 3 "Both" 
label define ga_extubation_which___1_ 0 "Unchecked" 1 "Checked" 
label define ga_extubation_which___2_ 0 "Unchecked" 1 "Checked" 
label define ga_extubation_which___3_ 0 "Unchecked" 1 "Checked" 
label define ga_adverse_diffaw_ 1 "Yes" 0 "No" 
label define ga_diffaw_which___1_ 0 "Unchecked" 1 "Checked" 
label define ga_diffaw_which___2_ 0 "Unchecked" 1 "Checked" 
label define ga_diffaw_which___3_ 0 "Unchecked" 1 "Checked" 
label define ga_diffaw_which___4_ 0 "Unchecked" 1 "Checked" 
label define ga_diffaw_which___5_ 0 "Unchecked" 1 "Checked" 
label define ga_diffaw_which___6_ 0 "Unchecked" 1 "Checked" 
label define ga_adverse_cicv_ 1 "Yes" 0 "No" 
label define ga_adverse_hypoxia_ 1 "Yes" 0 "No" 
label define ga_adverse_hypoxia_when___1_ 0 "Unchecked" 1 "Checked" 
label define ga_adverse_hypoxia_when___2_ 0 "Unchecked" 1 "Checked" 
label define ga_adverse_hypoxia_when___3_ 0 "Unchecked" 1 "Checked" 
label define ga_adverse_hypoxia_when___4_ 0 "Unchecked" 1 "Checked" 
label define ga_adverse_regurg_ 1 "Yes" 0 "No" 
label define ga_adverse_regurg_asp_ 1 "Yes" 0 "No" 
label define ga_adverse_hypotension_ 1 "Yes" 0 "No" 
label define ga_adverse_hypo_which___1_ 0 "Unchecked" 1 "Checked" 
label define ga_adverse_hypo_which___2_ 0 "Unchecked" 1 "Checked" 
label define ga_adverse_bleeding_ 1 "Yes" 0 "No" 
label define ga_adverse_seizure_ 1 "Yes" 0 "No" 
label define ga_adverse_arrest_ 1 "Yes" 0 "No" 
label define ga_end_where_ 1 "In theatre" 2 "Designated recovery room" 3 "Corridor" 4 "Ward" 5 "HDU/ICU" 
label define ga_end_who_ 1 "Yes" 0 "No" 
label define ga_end_monitors___1_ 0 "Unchecked" 1 "Checked" 
label define ga_end_monitors___2_ 0 "Unchecked" 1 "Checked" 
label define ga_end_monitors___3_ 0 "Unchecked" 1 "Checked" 
label define general_anesthesia_p_v_3_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label define adverse_hem_bloodavail_ 1 "Yes" 2 "No" 
label define adverse_hem_xmatch_ 1 "Yes" 2 "No" 
label define adverse_hem_lbiv_ 1 "Yes" 2 "No" 
label define adverse_hem_garsi_ 1 "Yes" 2 "No" 
label define adverse_hem_txa_ 1 "Yes" 2 "No" 
label define adverse_hem_noblood_ 1 "Yes" 2 "No" 
label define adverse_arrest_help_ 1 "Yes" 2 "No" 
label define adverse_arrest_airway_ 1 "Yes" 2 "No" 
label define adverse_arrest_breathing_ 1 "Yes" 2 "No" 
label define adverse_arrest_o2_ 1 "Yes" 2 "No" 
label define adverse_arrest_pulse_ 1 "Yes" 2 "No" 
label define adverse_arrest_tilt_ 1 "Yes" 2 "No" 
label define adverse_arrest_fluids_ 1 "Yes" 2 "No" 
label define adverse_arrest_bp_ 1 "Yes" 2 "No" 
label define adverse_arrest_communicate_ 1 "Yes" 2 "No" 
label define adverse_neo_attempt_ 1 "Yes" 2 "No" 3 "NA" 
label define adverse_neo_timer_ 1 "Yes" 2 "No" 3 "NA" 
label define adverse_neo_dries_ 1 "Yes" 2 "No" 3 "NA" 
label define adverse_neo_towel_ 1 "Yes" 2 "No" 3 "NA" 
label define adverse_neo_airway_ 1 "Yes" 2 "No" 3 "NA" 
label define adverse_neo_breathing_ 1 "Yes" 2 "No" 3 "NA" 
label define adverse_neo_hr_ 1 "Yes" 2 "No" 3 "NA" 
label define adverse_neo_5breath_ 1 "Yes" 2 "No" 3 "NA" 
label define adverse_neo_5morebreath_ 1 "Yes" 2 "No" 3 "NA" 
label define adverse_neo_compressions_ 1 "Yes" 2 "No" 3 "NA" 
label define adverse_other_equip_ 1 "Yes" 2 "No" 
label define adverse_other_power_ 1 "Yes" 2 "No" 
label define adverse_other_o2_ 1 "Yes" 2 "No" 
label define emergencies_packet_4_complete_ 0 "Incomplete" 1 "Unverified" 2 "Complete" 

label values phase phase_
label values observer_id observer_id_
label values anesthetist_id anesthetist_id_
label values safe_yn safe_yn_
label values refresher_yn refresher_yn_
label values cadre cadre_
label values case_asa case_asa_
label values case_urgency case_urgency_
label values case_initialtechnique case_initialtechnique_
label values indication___1 indication___1_
label values indication___2 indication___2_
label values indication___3 indication___3_
label values indication___4 indication___4_
label values indication___5 indication___5_
label values indication___6 indication___6_
label values indication___7 indication___7_
label values indication___8 indication___8_
label values indication___9 indication___9_
label values indication___10 indication___10_
label values indication___11 indication___11_
label values indication___13 indication___13_
label values indication___14 indication___14_
label values indication___12 indication___12_
label values ecl_coag ecl_coag_
label values ecl_antihtn ecl_antihtn_
label values ecl_mgs04 ecl_mgs04_
label values ecl_avoidspinal ecl_avoidspinal_
label values ecl_garsi ecl_garsi_
label values incisiontype incisiontype_
label values baseline_measured baseline_measured_
label values team___1 team___1_
label values team___2 team___2_
label values team___3 team___3_
label values team___4 team___4_
label values team___5 team___5_
label values team___12 team___12_
label values team___6 team___6_
label values team___7 team___7_
label values team___8 team___8_
label values team___9 team___9_
label values team___10 team___10_
label values team___11 team___11_
label values equipment_monitoring___1 equipment_monitoring___1_
label values equipment_monitoring___2 equipment_monitoring___2_
label values equipment_monitoring___3 equipment_monitoring___3_
label values equipment_monitoring___4 equipment_monitoring___4_
label values equipment_airway___1 equipment_airway___1_
label values equipment_airway___2 equipment_airway___2_
label values equipment_airway___3 equipment_airway___3_
label values equipment_airway___4 equipment_airway___4_
label values equipment_airway___5 equipment_airway___5_
label values equipment_airway___6 equipment_airway___6_
label values equipment_airway___7 equipment_airway___7_
label values equipment_drugs___1 equipment_drugs___1_
label values equipment_drugs___2 equipment_drugs___2_
label values equipment_drugs___3 equipment_drugs___3_
label values equipment_drugs___4 equipment_drugs___4_
label values equipment_drugs___5 equipment_drugs___5_
label values equipment_drugs___6 equipment_drugs___6_
label values equipment_drugs___7 equipment_drugs___7_
label values equipment_others___1 equipment_others___1_
label values equipment_others___2 equipment_others___2_
label values equipment_others___3 equipment_others___3_
label values equipment_others___4 equipment_others___4_
label values comm_consent comm_consent_
label values comm_indication comm_indication_
label values checklist_signin checklist_signin_
label values checklist_timeout checklist_timeout_
label values checklist_signout checklist_signout_
label values prep_preop prep_preop_
label values prep_hb prep_hb_
label values prep_machine prep_machine_
label values prep_gadrugs prep_gadrugs_
label values prep_airwaychecked prep_airwaychecked_
label values prep_suction prep_suction_
label values prep_vasopressor prep_vasopressor_
label values prep_neonatal prep_neonatal_
label values prep_ivaccess prep_ivaccess_
label values prep_fluids prep_fluids_
label values prep_preop_parts___1 prep_preop_parts___1_
label values prep_preop_parts___2 prep_preop_parts___2_
label values prep_preop_parts___3 prep_preop_parts___3_
label values prep_preop_parts___4 prep_preop_parts___4_
label values prep_machine_parts___1 prep_machine_parts___1_
label values prep_machine_parts___2 prep_machine_parts___2_
label values prep_drugs___1 prep_drugs___1_
label values prep_drugs___2 prep_drugs___2_
label values prep_drugs___3 prep_drugs___3_
label values prep_drugs___4 prep_drugs___4_
label values prep_airwaychecked_which___1 prep_airwaychecked_which___1_
label values prep_airwaychecked_which___2 prep_airwaychecked_which___2_
label values prep_vasopressor_parts___1 prep_vasopressor_parts___1_
label values prep_vasopressor_parts___2 prep_vasopressor_parts___2_
label values prep_vasopressor_parts___3 prep_vasopressor_parts___3_
label values prep_vasopressor_parts___4 prep_vasopressor_parts___4_
label values prep_neonatal_which___1 prep_neonatal_which___1_
label values prep_neonatal_which___2 prep_neonatal_which___2_
label values prep_neonatal_which___3 prep_neonatal_which___3_
label values prep_neonatal_which___4 prep_neonatal_which___4_
label values prep_neonatal_which___5 prep_neonatal_which___5_
label values final_ordeath final_ordeath_
label values final_hospitaldeath final_hospitaldeath_
label values final_pttransfer final_pttransfer_
label values baseline_packet_1_ma_v_1 baseline_packet_1_ma_v_1_
label values spinal_drug spinal_drug_
label values spinal_adjunct___1 spinal_adjunct___1_
label values spinal_adjunct___2 spinal_adjunct___2_
label values spinal_hat spinal_hat_
label values spinal_mask spinal_mask_
label values spinal_gloves spinal_gloves_
label values spinal_clean spinal_clean_
label values spinal_sterile spinal_sterile_
label values spinal_wedge spinal_wedge_
label values spinal_vitals spinal_vitals_
label values spinal_height spinal_height_
label values spinal_vasopressor spinal_vasopressor_
label values spinal_abx spinal_abx_
label values spinal_oxytocin spinal_oxytocin_
label values spinal_oxytocintime spinal_oxytocintime_
label values spinal_present spinal_present_
label values spinal_vitals_which___1 spinal_vitals_which___1_
label values spinal_vitals_which___2 spinal_vitals_which___2_
label values spinal_vitals_which___3 spinal_vitals_which___3_
label values spinal_oxytocin_dose spinal_oxytocin_dose_
label values spinal_oxytocin_how spinal_oxytocin_how_
label values adverse_failed_spinal adverse_failed_spinal_
label values adverse_spinal_failed_y___1 adverse_spinal_failed_y___1_
label values adverse_spinal_failed_y___2 adverse_spinal_failed_y___2_
label values adverse_loc adverse_loc_
label values adverse_hypoxia adverse_hypoxia_
label values adverse_persistent_hypo adverse_persistent_hypo_
label values adverse_hypo_which___1 adverse_hypo_which___1_
label values adverse_hypo_which___2 adverse_hypo_which___2_
label values adverse_major_hemorrhage adverse_major_hemorrhage_
label values spinal_end_where spinal_end_where_
label values spinal_end_who spinal_end_who_
label values spinal_end_monitors___1 spinal_end_monitors___1_
label values spinal_end_monitors___2 spinal_end_monitors___2_
label values spinal_end_monitors___3 spinal_end_monitors___3_
label values spinal_packet_2_complete spinal_packet_2_complete_
label values ga_tilt ga_tilt_
label values ga_help ga_help_
label values ga_preo2 ga_preo2_
label values ga_cricoid ga_cricoid_
label values ga_tubeposition ga_tubeposition_
label values ga_secure ga_secure_
label values ga_vitals ga_vitals_
label values ga_abx ga_abx_
label values ga_oxytocin ga_oxytocin_
label values ga_oxytocintime ga_oxytocintime_
label values ga_present ga_present_
label values ga_extubated ga_extubated_
label values ga_vitals_which___1 ga_vitals_which___1_
label values ga_vitals_which___2 ga_vitals_which___2_
label values ga_vitals_which___3 ga_vitals_which___3_
label values ga_oxytocin_dose ga_oxytocin_dose_
label values ga_oxytocin_how ga_oxytocin_how_
label values ga_extubation_which___1 ga_extubation_which___1_
label values ga_extubation_which___2 ga_extubation_which___2_
label values ga_extubation_which___3 ga_extubation_which___3_
label values ga_adverse_diffaw ga_adverse_diffaw_
label values ga_diffaw_which___1 ga_diffaw_which___1_
label values ga_diffaw_which___2 ga_diffaw_which___2_
label values ga_diffaw_which___3 ga_diffaw_which___3_
label values ga_diffaw_which___4 ga_diffaw_which___4_
label values ga_diffaw_which___5 ga_diffaw_which___5_
label values ga_diffaw_which___6 ga_diffaw_which___6_
label values ga_adverse_cicv ga_adverse_cicv_
label values ga_adverse_hypoxia ga_adverse_hypoxia_
label values ga_adverse_hypoxia_when___1 ga_adverse_hypoxia_when___1_
label values ga_adverse_hypoxia_when___2 ga_adverse_hypoxia_when___2_
label values ga_adverse_hypoxia_when___3 ga_adverse_hypoxia_when___3_
label values ga_adverse_hypoxia_when___4 ga_adverse_hypoxia_when___4_
label values ga_adverse_regurg ga_adverse_regurg_
label values ga_adverse_regurg_asp ga_adverse_regurg_asp_
label values ga_adverse_hypotension ga_adverse_hypotension_
label values ga_adverse_hypo_which___1 ga_adverse_hypo_which___1_
label values ga_adverse_hypo_which___2 ga_adverse_hypo_which___2_
label values ga_adverse_bleeding ga_adverse_bleeding_
label values ga_adverse_seizure ga_adverse_seizure_
label values ga_adverse_arrest ga_adverse_arrest_
label values ga_end_where ga_end_where_
label values ga_end_who ga_end_who_
label values ga_end_monitors___1 ga_end_monitors___1_
label values ga_end_monitors___2 ga_end_monitors___2_
label values ga_end_monitors___3 ga_end_monitors___3_
label values general_anesthesia_p_v_3 general_anesthesia_p_v_3_
label values adverse_hem_bloodavail adverse_hem_bloodavail_
label values adverse_hem_xmatch adverse_hem_xmatch_
label values adverse_hem_lbiv adverse_hem_lbiv_
label values adverse_hem_garsi adverse_hem_garsi_
label values adverse_hem_txa adverse_hem_txa_
label values adverse_hem_noblood adverse_hem_noblood_
label values adverse_arrest_help adverse_arrest_help_
label values adverse_arrest_airway adverse_arrest_airway_
label values adverse_arrest_breathing adverse_arrest_breathing_
label values adverse_arrest_o2 adverse_arrest_o2_
label values adverse_arrest_pulse adverse_arrest_pulse_
label values adverse_arrest_tilt adverse_arrest_tilt_
label values adverse_arrest_fluids adverse_arrest_fluids_
label values adverse_arrest_bp adverse_arrest_bp_
label values adverse_arrest_communicate adverse_arrest_communicate_
label values adverse_neo_attempt adverse_neo_attempt_
label values adverse_neo_timer adverse_neo_timer_
label values adverse_neo_dries adverse_neo_dries_
label values adverse_neo_towel adverse_neo_towel_
label values adverse_neo_airway adverse_neo_airway_
label values adverse_neo_breathing adverse_neo_breathing_
label values adverse_neo_hr adverse_neo_hr_
label values adverse_neo_5breath adverse_neo_5breath_
label values adverse_neo_5morebreath adverse_neo_5morebreath_
label values adverse_neo_compressions adverse_neo_compressions_
label values adverse_other_equip adverse_other_equip_
label values adverse_other_power adverse_other_power_
label values adverse_other_o2 adverse_other_o2_
label values emergencies_packet_4_complete emergencies_packet_4_complete_



tostring obs_date, replace
gen _date_ = date(obs_date,"YMD")
drop obs_date
rename _date_ obs_date
format obs_date %dM_d,_CY

tostring time_informed, replace
gen double _temp_ = Clock(time_informed,"YMDhm")
drop time_informed
rename _temp_ time_informed
format time_informed %tCMonth_dd,_CCYY_HH:MM

tostring time_or, replace
gen double _temp_ = Clock(time_or,"YMDhm")
drop time_or
rename _temp_ time_or
format time_or %tCMonth_dd,_CCYY_HH:MM

tostring time_incision, replace
gen double _temp_ = Clock(time_incision,"YMDhm")
drop time_incision
rename _temp_ time_incision
format time_incision %tCMonth_dd,_CCYY_HH:MM

tostring incisiontime, replace
gen double _temp_ = Clock(incisiontime,"YMDhm")
drop incisiontime
rename _temp_ incisiontime
format incisiontime %tCMonth_dd,_CCYY_HH:MM

tostring time_birth, replace
gen double _temp_ = Clock(time_birth,"YMDhm")
drop time_birth
rename _temp_ time_birth
format time_birth %tCMonth_dd,_CCYY_HH:MM

tostring time_skinclosed, replace
gen double _temp_ = Clock(time_skinclosed,"YMDhm")
drop time_skinclosed
rename _temp_ time_skinclosed
format time_skinclosed %tCMonth_dd,_CCYY_HH:MM

tostring final_date, replace
gen _date_ = date(final_date,"YMD")
drop final_date
rename _date_ final_date
format final_date %dM_d,_CY

label variable record_id "Record ID"
label variable redcap_survey_identifier "Survey Identifier"
label variable baseline_packet_1_ma_v_0 "Survey Timestamp"
label variable phase "What is the evaluation phase of this survey"
label variable obs_date "Observation date (e.g. 16-08-19)"
label variable obs_time "Observation time (e.g. 02:45)"
label variable observer_id "Observer initials:"
label variable pt_id_number "Enter patient ID number"
label variable anesthetist_id "Anesthetist ID:"
label variable safe_yn "Has this provider attended SAFE already?"
label variable refresher_yn "Has the provider completed a SAFE Refresher course?"
label variable cadre "Participant cadre: The participant is a "
label variable cadre_other "Other cadre:"
label variable case_asa "Patients ASA:"
label variable case_urgency "Elective or emergency?"
label variable case_initialtechnique "Initial anesthetic technique:"
label variable indication___1 "Indication for C-Section (check all that apply) (choice=Obstructed labour)"
label variable indication___2 "Indication for C-Section (check all that apply) (choice=Previous scars (c-section, laparotomies, etc))"
label variable indication___3 "Indication for C-Section (check all that apply) (choice=Antepartum hemorrhage - Ruptured uterus)"
label variable indication___4 "Indication for C-Section (check all that apply) (choice=Antepartum hemorrhage - Placental abruption)"
label variable indication___5 "Indication for C-Section (check all that apply) (choice=Antepartum hemorrhage - Placenta accreta/percreta)"
label variable indication___6 "Indication for C-Section (check all that apply) (choice=Eclampsia)"
label variable indication___7 "Indication for C-Section (check all that apply) (choice=Severe pre-eclampsia)"
label variable indication___8 "Indication for C-Section (check all that apply) (choice=Fetal distress)"
label variable indication___9 "Indication for C-Section (check all that apply) (choice=Cord prolapse)"
label variable indication___10 "Indication for C-Section (check all that apply) (choice=Multiple pregnancy (twins))"
label variable indication___11 "Indication for C-Section (check all that apply) (choice=Breech presentation)"
label variable indication___13 "Indication for C-Section (check all that apply) (choice=Failure to progress)"
label variable indication___14 "Indication for C-Section (check all that apply) (choice=Abnormal/invasive placenta)"
label variable indication___12 "Indication for C-Section (check all that apply) (choice=Other)"
label variable indication_other "Indication (other)"
label variable indication_additional "Additional information about case (premature, perimortem section, etc)"
label variable ecl_coag "Confirm platelet/coagulation values"
label variable ecl_antihtn "Confirm anti-hypertensives available"
label variable ecl_mgs04 "Confirm MgSO4 available"
label variable ecl_avoidspinal "Avoids spinal if platelets < 80,000"
label variable ecl_garsi "If eclampsia, proceeds to GA with RSI"
label variable time_informed "Time anesthetist informed about case:"
label variable time_or "Time in OR"
label variable time_incision "Time of skin incision"
label variable incisiontype "Type of uterine incision"
label variable incisiontype_other "Other incision"
label variable incisiontime "Uterine incision time"
label variable time_birth "Time of birth:"
label variable time_skinclosed "Time skin closure complete"
label variable baseline_measured "ALL vital signs were NOT fully measured (BP, HR, SpO2)"
label variable baseline_hr "Baseline HR:"
label variable baseline_sbp "Baseline SBP:"
label variable baseline_dbp "Baseline DBP"
label variable baseline_spo2 "Baseline SpO2"
label variable team___1 "Team members present (choice=Obstetrician resident)"
label variable team___2 "Team members present (choice=Obstetrician consultant)"
label variable team___3 "Team members present (choice=Medical officer)"
label variable team___4 "Team members present (choice=Intern)"
label variable team___5 "Team members present (choice=Anaesthetist (study participant))"
label variable team___12 "Team members present (choice=Anesthetist (other than study participant))"
label variable team___6 "Team members present (choice=Theatre nurse (runner))"
label variable team___7 "Team members present (choice=Scrub nurse)"
label variable team___8 "Team members present (choice=Midwife)"
label variable team___9 "Team members present (choice=Neonatal team (doctor or nurse))"
label variable team___10 "Team members present (choice=Medical student)"
label variable team___11 "Team members present (choice=Other)"
label variable team_other "Theatre team (other)"
label variable equipment_monitoring___1 "Monitoring equipment: (choice=BP cuff)"
label variable equipment_monitoring___2 "Monitoring equipment: (choice=Pulse oximeter)"
label variable equipment_monitoring___3 "Monitoring equipment: (choice=ECG)"
label variable equipment_monitoring___4 "Monitoring equipment: (choice=ET CO2)"
label variable equipment_airway___1 "Airway equipment: (choice=Laryngoscope)"
label variable equipment_airway___2 "Airway equipment: (choice=ETT)"
label variable equipment_airway___3 "Airway equipment: (choice=LMA)"
label variable equipment_airway___4 "Airway equipment: (choice=Bougie/stylet)"
label variable equipment_airway___5 "Airway equipment: (choice=Facemask and breathing circuit)"
label variable equipment_airway___6 "Airway equipment: (choice=Suction)"
label variable equipment_airway___7 "Airway equipment: (choice=Ambu-bag)"
label variable equipment_spinalneedle "Spinal Needle (type and guage)"
label variable equipment_drugs___1 "Drugs: (choice=Oxygen)"
label variable equipment_drugs___2 "Drugs: (choice=Ketamine)"
label variable equipment_drugs___3 "Drugs: (choice=Volatile anesthetic)"
label variable equipment_drugs___4 "Drugs: (choice=Pressor/adrenaline)"
label variable equipment_drugs___5 "Drugs: (choice=Muscle relaxants)"
label variable equipment_drugs___6 "Drugs: (choice=Antibiotics)"
label variable equipment_drugs___7 "Drugs: (choice=Uterotonic)"
label variable equipment_others___1 "Other equipment: (choice=Anesthesia machine)"
label variable equipment_others___2 "Other equipment: (choice=Operating table with tilt function)"
label variable equipment_others___3 "Other equipment: (choice=IV Fluids)"
label variable equipment_others___4 "Other equipment: (choice=Blood)"
label variable comm_consent "Procedure explained to patient & consent obtained"
label variable comm_indication "Discusses indication of c-section with obstetrician"
label variable checklist_signin "Sign in completed appropriately"
label variable checklist_timeout "Time out completed appropriately"
label variable checklist_signout "Sign out completed appropriately"
label variable prep_preop "Pre-operative anaesthetic assessment has been performed before C-section *can be verbal or documented"
label variable prep_hb "Checks recent Hb level"
label variable prep_machine "Anaesthetic machine has been checked before commencing anaesthesia"
label variable prep_gadrugs "Check availability of General anaesthestic drug before commencing anaesthesia (at least one of ketamine, propofol, or thiopentone, plus suxamethonium)"
label variable prep_airwaychecked "Airway equipment availability is checked before commencing anaesthesia (laryngoscope with functioning light and ETT with intact cuff)"
label variable prep_suction "Ensures suction is present in theatre & working"
label variable prep_vasopressor "Ensures a vasopressor is present in theatre"
label variable prep_neonatal "Confirms neonatal resuscitation equipment available (ambu-bag, mask, towel/blanket, warmer, oxygen)"
label variable prep_ivaccess "Obtains IV access"
label variable prep_fluids "Attaches running fluids"
label variable prep_preop_parts___1 "Which components of preanesthetic assessment were performed? (choice=Airway exam)"
label variable prep_preop_parts___2 "Which components of preanesthetic assessment were performed? (choice=CVS/RS exam)"
label variable prep_preop_parts___3 "Which components of preanesthetic assessment were performed? (choice=Co-morbidities)"
label variable prep_preop_parts___4 "Which components of preanesthetic assessment were performed? (choice=Allergies)"
label variable prep_machine_parts___1 "Which parts of the anesthesia machine were checked? (choice=Adequate oxygen supply)"
label variable prep_machine_parts___2 "Which parts of the anesthesia machine were checked? (choice=Working breathing circuit (pressure or leak test))"
label variable prep_drugs___1 "Which drugs were available? (choice=Ketamine)"
label variable prep_drugs___2 "Which drugs were available? (choice=Propofol)"
label variable prep_drugs___3 "Which drugs were available? (choice=Thiopentone)"
label variable prep_drugs___4 "Which drugs were available? (choice=Suxamethonium)"
label variable prep_airwaychecked_which___1 "Which airway equipment was checked (choice=Laryngoscope with light)"
label variable prep_airwaychecked_which___2 "Which airway equipment was checked (choice=ETT with cuff)"
label variable prep_vasopressor_parts___1 "Which vasopressors were present in theatre? (choice=Adrenaline)"
label variable prep_vasopressor_parts___2 "Which vasopressors were present in theatre? (choice=Ephedrine)"
label variable prep_vasopressor_parts___3 "Which vasopressors were present in theatre? (choice=Phenylephrine)"
label variable prep_vasopressor_parts___4 "Which vasopressors were present in theatre? (choice=Metaraminol)"
label variable prep_neonatal_which___1 "Which neonatal equipment was available? (choice=Ambu-bag)"
label variable prep_neonatal_which___2 "Which neonatal equipment was available? (choice=Mask)"
label variable prep_neonatal_which___3 "Which neonatal equipment was available? (choice=Towel/blanket)"
label variable prep_neonatal_which___4 "Which neonatal equipment was available? (choice=Warmer)"
label variable prep_neonatal_which___5 "Which neonatal equipment was available? (choice=Oxygen)"
label variable unstructured "Unstructured observation: Any additional notes, other adverse events or difficulty filling in form"
label variable apgar1 "Apgar at 1 minute: "
label variable apgar5 "Apgar a 5 minutes:"
label variable final_ordeath "Did the patient die intraoperatively?"
label variable final_hospitaldeath "Did the patient die before discharge from hospital?"
label variable final_pttransfer "Was the patient transferred to another facility?"
label variable final_date "Date of discharge, transfer, or death"
label variable baseline_packet_1_ma_v_1 "Complete?"
label variable spinal_packet_2_timestamp "Survey Timestamp"
label variable spinal_drug "What local anesthetic was used in the spinal?"
label variable spinal_dose "What dose was used in the spinal? (in mL, milliliters) "
label variable spinal_adjunct___1 "Adjuncts used: (choice=Opioid)"
label variable spinal_adjunct___2 "Adjuncts used: (choice=Dextrose)"
label variable spinal_hat "Wears hat when administering spinal"
label variable spinal_mask "Wears mask when administering spinal"
label variable spinal_gloves "Wears sterile gloves when administering spinal"
label variable spinal_clean "Uses cleaning solution (iodine / chlorhexidine / alcohol ) to clean back before administering spinal"
label variable spinal_sterile "Maintains sterile field whilst administering spinal"
label variable spinal_wedge "Applies left lateral tilt or wedge after giving the spinal"
label variable spinal_vitals "Monitors vital signs after giving the spinal"
label variable spinal_height "Measures the height of the spinal block using sensation to cold, blunt needle or soft touch"
label variable spinal_vasopressor "Administers vasopressor when appropriate for hypotension (if SBP< 100mmHg, or >20% reduction from baseline)"
label variable spinal_abx "Administers IV antibiotics or confirms have been given Within 1 hour of incision"
label variable spinal_oxytocin "Administers oxytocin"
label variable spinal_oxytocintime "Oxytocin administered at correct time (when umbilical cord clamped)"
label variable spinal_present "Participant present in theatre throughout the case"
label variable spinal_vitals_which___1 "Which vital signs were monitored? (choice=BP every 5 min)"
label variable spinal_vitals_which___2 "Which vital signs were monitored? (choice=HR every 5 min)"
label variable spinal_vitals_which___3 "Which vital signs were monitored? (choice=Continuous SpO2)"
label variable spinal_oxytocin_dose "What was the total dose of oxytocin?"
label variable spinal_oxytocin_how "Oxytocin administration method"
label variable adverse_failed_spinal "Failed spinal (no block or inadequate block requiring supplementary anaesthesia)"
label variable adverse_spinal_failed_y___1 "What was the response to the failed spinal? (choice=Convert to GA?)"
label variable adverse_spinal_failed_y___2 "What was the response to the failed spinal? (choice=Ketamine sedation without intubation?)"
label variable adverse_loc "Loss of consciousness/unresponsive"
label variable adverse_hypoxia "Hypoxia (SpO2 < 90% for >2 minutes)"
label variable adverse_persistent_hypo "Persistent hypotension (SBP>20% below baseline or < 80mmHg for >10 mins)"
label variable adverse_hypo_which___1 "How much drop? (choice=>20% drop)"
label variable adverse_hypo_which___2 "How much drop? (choice=< 70mmHg)"
label variable adverse_major_hemorrhage "Major haemorrhage (Quantitatively >1L blood loss or major haemorrhage being declared by obstetrician)"
label variable spinal_end_where "Place of recovery"
label variable spinal_end_who "Dedicated personnel for patient recovering from anesthesia"
label variable spinal_end_monitors___1 "Continuous monitoring (choice=BP)"
label variable spinal_end_monitors___2 "Continuous monitoring (choice=SpO2)"
label variable spinal_end_monitors___3 "Continuous monitoring (choice=HR)"
label variable spinal_unstructured "Unstructured observation: Any additional notes, other adverse events or difficulty filling in form"
label variable spinal_packet_2_complete "Complete?"
label variable general_anesthesia_p_v_2 "Survey Timestamp"
label variable ga_tilt "Applies left lateral tilt or wedge prior to induction"
label variable ga_help "Asks a colleague to help during induction of general anaesthesia"
label variable ga_preo2 "Pre-oxygenates patient adequately (3 minutes pre-oxygenation)"
label variable ga_cricoid "Applies cricoid pressure during RSI"
label variable ga_tubeposition "Checks endotracheal tube position by auscultation or ET CO2"
label variable ga_secure "Secure ETT with tape or tie"
label variable ga_vitals "Monitors vital signs"
label variable ga_abx "Administers IV antibiotics or confirms have been given"
label variable ga_oxytocin "Administers oxytocin"
label variable ga_oxytocintime "Oxytocin administered at correct time (when umbilical cord clamped)"
label variable ga_present "Participant present in theatre throughout the case"
label variable ga_extubated "Patient extubated safely (yes only if all 3 components performed)"
label variable ga_vitals_which___1 "Which vital signs were monitored? (choice=BP every 5 min)"
label variable ga_vitals_which___2 "Which vital signs were monitored? (choice=HR every 5 min)"
label variable ga_vitals_which___3 "Which vital signs were monitored? (choice=Continuous SpO2)"
label variable ga_oxytocin_dose "What was the total dose of oxytocin?"
label variable ga_oxytocin_how "How was oxytocin administered?"
label variable ga_extubation_which___1 "Which extubation components were checked (select 2 of 3, otherwise pick YES) (choice=Airway suctioned)"
label variable ga_extubation_which___2 "Which extubation components were checked (select 2 of 3, otherwise pick YES) (choice=Assess if patient awake (cough, moving arms, eyes opening))"
label variable ga_extubation_which___3 "Which extubation components were checked (select 2 of 3, otherwise pick YES) (choice=Assess for regular breathing)"
label variable ga_adverse_diffaw "Difficult (>3 attempts) or Failed intubation (inability to secure airway with ETT after 3 attempts)"
label variable ga_diffaw_which___1 "Check difficult airway actions performed: (choice=Gets help)"
label variable ga_diffaw_which___2 "Check difficult airway actions performed: (choice=Maintains oxygenation through BVM/LMA)"
label variable ga_diffaw_which___3 "Check difficult airway actions performed: (choice=Repositions patient)"
label variable ga_diffaw_which___4 "Check difficult airway actions performed: (choice=Applies BURP)"
label variable ga_diffaw_which___5 "Check difficult airway actions performed: (choice=Changes laryngoscope blade)"
label variable ga_diffaw_which___6 "Check difficult airway actions performed: (choice=Uses bougie or stylet)"
label variable ga_adverse_cicv "Cant intubate, Cant ventilate scenario (failed intubation + failure to ventilate)"
label variable ga_adverse_hypoxia "Hypoxia (SpO2 < 90% for >2 mins)"
label variable ga_adverse_hypoxia_when___1 "When was the hypoxia? (choice=Induction)"
label variable ga_adverse_hypoxia_when___2 "When was the hypoxia? (choice=Intraoperative)"
label variable ga_adverse_hypoxia_when___3 "When was the hypoxia? (choice=Extubation)"
label variable ga_adverse_hypoxia_when___4 "When was the hypoxia? (choice=Actions taken to resolve hypoxia?)"
label variable ga_adverse_regurg "Reguritation"
label variable ga_adverse_regurg_asp "Aspiration - regurgitation with subsequent desaturations within 5 minutes"
label variable ga_adverse_hypotension "Persistent Hypotension (SBP>20% below baseline or < 80mmHg for >10 mins)"
label variable ga_adverse_hypo_which___1 "Which element of hypotension? (choice=>20% drop in SBP)"
label variable ga_adverse_hypo_which___2 "Which element of hypotension? (choice=SBP < 80mmHg)"
label variable ga_adverse_bleeding "Major haemorrhage (Quantitatively >1L blood loss or obstetrician announces >1L or major haemorrhage)"
label variable ga_adverse_seizure "Eclamptic seizure"
label variable ga_adverse_arrest "Cardiorespiratory arrest"
label variable ga_end_where "Place of recovery"
label variable ga_end_who "Dedicated personnel for patient recovering from anesthesia"
label variable ga_end_monitors___1 "Continuous monitoring (choice=BP)"
label variable ga_end_monitors___2 "Continuous monitoring (choice=SpO2)"
label variable ga_end_monitors___3 "Continuous monitoring (choice=HR)"
label variable ga_unstructured "Unstructured observation: Any additional notes, other adverse events or difficulty filling in form"
label variable general_anesthesia_p_v_3 "Complete?"
label variable emergencies_packet_4_timestamp "Survey Timestamp"
label variable adverse_hem_bloodavail "Confirm blood available"
label variable adverse_hem_xmatch "Confirm type & cross match sent"
label variable adverse_hem_lbiv "Confirm 2+ large bore access (>18G)"
label variable adverse_hem_garsi "GA with RSI as choice of anaesthesia"
label variable adverse_hem_txa "Administer TXA"
label variable adverse_hem_noblood "No blood available when provider requests for blood"
label variable adverse_arrest_help "Asks for help"
label variable adverse_arrest_airway "Assesses and/or opens airway"
label variable adverse_arrest_breathing "Assesses breathing + SpO2"
label variable adverse_arrest_o2 "Administers high flow oxygen"
label variable adverse_arrest_pulse "Checks pulse"
label variable adverse_arrest_tilt "Applies/checks left lateral tilt"
label variable adverse_arrest_fluids "Checks IV access & fluids running"
label variable adverse_arrest_bp "Checks BP"
label variable adverse_arrest_communicate "Communicates with surgeon/obstetrician"
label variable adverse_neo_attempt "Attempts to resuscitate when newborn isnt breathing adequately"
label variable adverse_neo_timer "Starts timer"
label variable adverse_neo_dries "Dries baby & removes wet cloth"
label variable adverse_neo_towel "Keeps baby warm & wraps with fresh towel"
label variable adverse_neo_airway "Opens airway"
label variable adverse_neo_breathing "Assesses breathing"
label variable adverse_neo_hr "Assesses heart beat"
label variable adverse_neo_5breath "Gives 5 inflation breaths using bag-mask ventilation (rather than suction)"
label variable adverse_neo_5morebreath "Gives a further 5 inflation breaths if HR still < 100bpm"
label variable adverse_neo_compressions "Performs chest compressions if HR< 100bpm (compression to ventilation ratio 3:1)"
label variable adverse_other_equip "Anesthesia equipment failure"
label variable adverse_other_power "Power failure"
label variable adverse_other_o2 "Loss of oxygen supply"
label variable adverse_unstructured "Unstructured observation:  Any additional notes, other adverse events or difficulty filling in form"
label variable emergencies_packet_4_complete "Complete?"

order record_id redcap_survey_identifier baseline_packet_1_ma_v_0 phase obs_date obs_time observer_id pt_id_number anesthetist_id safe_yn refresher_yn cadre cadre_other case_asa case_urgency case_initialtechnique indication___1 indication___2 indication___3 indication___4 indication___5 indication___6 indication___7 indication___8 indication___9 indication___10 indication___11 indication___13 indication___14 indication___12 indication_other indication_additional ecl_coag ecl_antihtn ecl_mgs04 ecl_avoidspinal ecl_garsi time_informed time_or time_incision incisiontype incisiontype_other incisiontime time_birth time_skinclosed baseline_measured baseline_hr baseline_sbp baseline_dbp baseline_spo2 team___1 team___2 team___3 team___4 team___5 team___12 team___6 team___7 team___8 team___9 team___10 team___11 team_other equipment_monitoring___1 equipment_monitoring___2 equipment_monitoring___3 equipment_monitoring___4 equipment_airway___1 equipment_airway___2 equipment_airway___3 equipment_airway___4 equipment_airway___5 equipment_airway___6 equipment_airway___7 equipment_spinalneedle equipment_drugs___1 equipment_drugs___2 equipment_drugs___3 equipment_drugs___4 equipment_drugs___5 equipment_drugs___6 equipment_drugs___7 equipment_others___1 equipment_others___2 equipment_others___3 equipment_others___4 comm_consent comm_indication checklist_signin checklist_timeout checklist_signout prep_preop prep_hb prep_machine prep_gadrugs prep_airwaychecked prep_suction prep_vasopressor prep_neonatal prep_ivaccess prep_fluids prep_preop_parts___1 prep_preop_parts___2 prep_preop_parts___3 prep_preop_parts___4 prep_machine_parts___1 prep_machine_parts___2 prep_drugs___1 prep_drugs___2 prep_drugs___3 prep_drugs___4 prep_airwaychecked_which___1 prep_airwaychecked_which___2 prep_vasopressor_parts___1 prep_vasopressor_parts___2 prep_vasopressor_parts___3 prep_vasopressor_parts___4 prep_neonatal_which___1 prep_neonatal_which___2 prep_neonatal_which___3 prep_neonatal_which___4 prep_neonatal_which___5 unstructured apgar1 apgar5 final_ordeath final_hospitaldeath final_pttransfer final_date baseline_packet_1_ma_v_1 spinal_packet_2_timestamp spinal_drug spinal_dose spinal_adjunct___1 spinal_adjunct___2 spinal_hat spinal_mask spinal_gloves spinal_clean spinal_sterile spinal_wedge spinal_vitals spinal_height spinal_vasopressor spinal_abx spinal_oxytocin spinal_oxytocintime spinal_present spinal_vitals_which___1 spinal_vitals_which___2 spinal_vitals_which___3 spinal_oxytocin_dose spinal_oxytocin_how adverse_failed_spinal adverse_spinal_failed_y___1 adverse_spinal_failed_y___2 adverse_loc adverse_hypoxia adverse_persistent_hypo adverse_hypo_which___1 adverse_hypo_which___2 adverse_major_hemorrhage spinal_end_where spinal_end_who spinal_end_monitors___1 spinal_end_monitors___2 spinal_end_monitors___3 spinal_unstructured spinal_packet_2_complete general_anesthesia_p_v_2 ga_tilt ga_help ga_preo2 ga_cricoid ga_tubeposition ga_secure ga_vitals ga_abx ga_oxytocin ga_oxytocintime ga_present ga_extubated ga_vitals_which___1 ga_vitals_which___2 ga_vitals_which___3 ga_oxytocin_dose ga_oxytocin_how ga_extubation_which___1 ga_extubation_which___2 ga_extubation_which___3 ga_adverse_diffaw ga_diffaw_which___1 ga_diffaw_which___2 ga_diffaw_which___3 ga_diffaw_which___4 ga_diffaw_which___5 ga_diffaw_which___6 ga_adverse_cicv ga_adverse_hypoxia ga_adverse_hypoxia_when___1 ga_adverse_hypoxia_when___2 ga_adverse_hypoxia_when___3 ga_adverse_hypoxia_when___4 ga_adverse_regurg ga_adverse_regurg_asp ga_adverse_hypotension ga_adverse_hypo_which___1 ga_adverse_hypo_which___2 ga_adverse_bleeding ga_adverse_seizure ga_adverse_arrest ga_end_where ga_end_who ga_end_monitors___1 ga_end_monitors___2 ga_end_monitors___3 ga_unstructured general_anesthesia_p_v_3 emergencies_packet_4_timestamp adverse_hem_bloodavail adverse_hem_xmatch adverse_hem_lbiv adverse_hem_garsi adverse_hem_txa adverse_hem_noblood adverse_arrest_help adverse_arrest_airway adverse_arrest_breathing adverse_arrest_o2 adverse_arrest_pulse adverse_arrest_tilt adverse_arrest_fluids adverse_arrest_bp adverse_arrest_communicate adverse_neo_attempt adverse_neo_timer adverse_neo_dries adverse_neo_towel adverse_neo_airway adverse_neo_breathing adverse_neo_hr adverse_neo_5breath adverse_neo_5morebreath adverse_neo_compressions adverse_other_equip adverse_other_power adverse_other_o2 adverse_unstructured emergencies_packet_4_complete 
set more off
describe

* create the variable with pre and post
gen phase2 = 1 if phase == 1
replace phase2 = 2 if phase == 2
label define phase2_ 1 "Pre-SAFE" 2 "Immediately Post-SAFE"
label values phase2 phase2_

/* MB = 1
R = 2
K = 3
Z =4 
NJ = 5
IR = 6



1 "MB-A" 2 "MB-B" 3 "MB-C" 4 "MB-D" 5 "MB-E" 46 "MB-F" 47 "MB-G" 
6 "R-A" 7 "R-B" 8 "R-C" 9 "R-D" 10 "R-E" 11 "R-F" 43 "R-G" 
12 "K-A" 13 "K-B" 14 "K-C" 15 "K-D" 
16 "Z-A" 17 "Z-B" 18 "Z-C" 19 "Z-D" 20 "Z-E" 21 "Z-F" 22 "Z-G" 23 "Z-H" 24 "Z-I" 25 "Z-J" 26 "Z-K" 27 "Z-L" 48 "Z-M" 
28 "NJ-A" 29 "NJ-B" 30 "NJ-C" 31 "NJ-D" 32 "NJ-E" 33 "NJ-F" 45 "NJ-G" 
34 "IR-A" 35 "IR-B" 36 "IR-C" 37 "IR-D" 38 "IR-E" 39 "IR-F" 40 "IR-G" 41 "IR-H" 42 "IR-I" 44 "IR-J" 
49 "Z-N" 50 "NJ-H" 51 "NJ-I" 52 "NJ-J" 53 "Z-O"

*/
gen hospital = anesthetist_id
recode hospital 1/5=1 46/47=1 ///
6/11 = 2 43=2 ///
12/15=3 ///
16/27=4 48=4 ///
28/33=5 45=5 ///
34/42=6 44=6 /// 
49/53=4 /* zonal */
label define hospital_ 1 "MB" 2 "R" 3 "K" 4 "Z" 5 "NJ" 6 "IR"
label values hospital hospital_
label variable hospital "Hospital" 

* recode all communication, prep, and spinal variables where 1=no and 2=yes
foreach i of varlist comm_consent comm_indication checklist_signin checklist_timeout checklist_signout prep_preop-prep_vasopressor prep_neonatal spinal_hat-spinal_present {
	gen `i'2 = 0 if `i' == 2
	replace `i'2 = 1 if `i' == 1
	label define `i'__ 0 "No" 1 "Yes"
	label values  `i' `i'__
}


capture program drop comparetab
program define comparetab
	syntax varlist using[, replace append ]
	tempname fh
	file open `fh' `using', write `replace' `append'
	file write `fh' "variable" _tab ///
	"label" _tab ///
	"chi2" _tab ///
	"p_value" _tab  ///
	"exact" _tab  ///
	"or_immediate" _tab  ///
	"OR6" _tab  ///
	"OR12" _tab  ///
	"p_imm" _tab  ///
	"p_6" _tab  ///
	"p12" _tab  ///
	"lci_imm" _tab  ///
	"lci6" _tab  ///
	"lci12" _tab  ///
	"uci_imm" _tab  ///
	"uci6" _tab  ///
	"uci12" _tab  ///
	"adj_or_immediate" _tab  ///
	"adj_OR6" _tab  ///
	"adj_OR12" _tab  ///
	"adj_p_imm" _tab  ///
	"adj_p_6" _tab  ///
	"adj_p12" _tab  ///
	"adj_lci_imm" _tab  ///
	"adj_lci6" _tab  ///
	"adj_lci12" _tab  ///
	"adj_uci_imm" _tab  ///
	"adj_uci6" _tab  ///
	"adj_uci12" _tab
	foreach i of local varlist{
		di "checking `i'"
		quietly tabulate `i' phase2, chi2 expected exact matcell(o)
		local name: variable label `i'
		file write `fh' _n "`i'" _tab "`name'" _tab (r(chi2)) _tab
		mata: o = st_matrix("o")
		mata: st_matrix("e", (rowsum(o)* colsum(o)) / sum(o)) 
		mata: mata clear
		if e[1,1] >7 & e[1,2] >7 & e[2,1] >7 & e[2,2] >7{
			file write `fh' (r(p)) _tab "" _tab
			if r(p) > .05{
				di "`i' is not significant"
				continue
				}
			else{
				di "regress `i'"
				quietly logistic `i'2 i.phase if phase != 4
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
				quietly melogit `i'2 i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
				}
			}
		else{
			file write `fh' "" _tab (r(p_exact)) _tab
			if r(p_exact) > .05 {
				di "`i' is not significant"
				continue
				}
			else {
				di "regress `i'"
				quietly logistic `i'2 i.phase if phase != 4
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
				quietly melogit `i'2 i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
			}
		}
	}
	file close `fh'
end

comparetab comm_consent comm_indication checklist_signin checklist_timeout checklist_signout prep_preop-prep_vasopressor prep_ivaccess prep_fluids spinal_hat-spinal_present using output2.txt, replace

/* list of variable

comm_consent comm_indication checklist_signin checklist_timeout checklist_signout

prep variables: prep_preop-prep_neonatal

spinal variables: spinal_hat-spinal_present adverse_loc-adverse_major_hemorrhage
*/


/* repeat just for neonatal, which uses meqrlogit */

tabulate prep_neonatal phase2, chi2 expected exact matcell(o)
file open fh using output2.txt, write append
file write fh _n "prep_neonatal" _tab "checks prep_neonatal" _tab (r(chi2)) _tab
mata: o = st_matrix("o")
mata: st_matrix("e", (rowsum(o)* colsum(o)) / sum(o)) 
mata: mata clear


if e[1,1] >7 & e[1,2] >7 & e[2,1] >7 & e[2,2] >7{
			file write fh (r(p)) _tab "" _tab
			if r(p) > .05{
				continue
				}
			else{
				quietly logistic `i'2 i.phase if phase != 4
				matrix row1 = r(table)
				file write fh (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
				quietly meqrlogit prep_neonatal2 i.phase if phase != 4 || hospital: || anesthetist_id:, base or
				matrix row1 = r(table)
				file write fh (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
				}
			}
		else{
			file write fh "" _tab (r(p_exact)) _tab
			if r(p_exact) > .05 {
				continue
				}
			else {
				quietly logistic prep_neonatal2 i.phase if phase != 4
				matrix row1 = r(table)
				file write fh (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
				quietly meqrlogit prep_neonatal2 i.phase if phase != 4 || hospital: || anesthetist_id:, base or
				matrix row1 = r(table)
				file write fh (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
			}
		}
file close fh
		
/* repeat for adverse events, which did not need a new variable name (e.g. no adverse_loc2, just adverse_loc). will change the program. */

capture program drop comparetab_unrecodedvars
program define comparetab_unrecodedvars
	syntax varlist using[, replace append ]
	tempname fh
	file open `fh' `using', write `replace' `append'
	foreach i of local varlist{
		di "checking `i'"
		quietly tabulate `i' phase2, chi2 expected exact matcell(o)
		local name: variable label `i'
		file write `fh' _n "`i'" _tab "`name'" _tab (r(chi2)) _tab
		mata: o = st_matrix("o")
		mata: st_matrix("e", (rowsum(o)* colsum(o)) / sum(o)) 
		mata: mata clear
		if e[1,1] >7 & e[1,2] >7 & e[2,1] >7 & e[2,2] >7{
			file write `fh' (r(p)) _tab "" _tab
			if r(p) > .05{
				di "`i' is not significant"
				continue
				}
			else{
				di "regress `i'"
				quietly logistic `i' i.phase if phase != 4
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
				quietly melogit `i' i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
				}
			}
		else{
			file write `fh' "" _tab (r(p_exact)) _tab
			if r(p_exact) > .05 {
				di "`i' is not significant"
				continue
				}
			else {
				di "regress `i'"
				quietly logistic `i' i.phase if phase != 4
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
				quietly melogit `i' i.phase if phase != 4 || hospital: || anesthetist_id:, base or noasis
				matrix row1 = r(table)
				file write `fh' (row1[1,2]) _tab (row1[1,3]) _tab (row1[1,4]) _tab (row1[4,2]) _tab (row1[4,3]) _tab (row1[4,4]) _tab ///
				(row1[5,2]) _tab (row1[5,3]) _tab (row1[5,4]) _tab /// lower CI
				(row1[6,2]) _tab (row1[6,3]) _tab (row1[6,4]) _tab /* upper CI */
			}
		}
	}
	file close `fh'
end

comparetab_unrecodedvars adverse_failed_spinal adverse_loc-adverse_persistent_hypo adverse_major_hemorrhage using output2.txt, append
