
(:ANTIGEN-SUPPORTING-DATA
 (:IMMUNITY NIL :CONTRAINDICATIONS
  (:VACCINE-GROUP
   (:CONTRAINDICATION
    (:OBSERVATION-CODE "080" :OBSERVATION-TITLE
     "Adverse reaction to vaccine component" :CONTRAINDICATION-TEXT
     "Do not vaccinate if the patient has had an adverse reaction to a vaccine component."
     :CONTRAINDICATION-GUIDANCE NIL :BEGIN-AGE NIL :END-AGE NIL)
    :CONTRAINDICATION
    (:OBSERVATION-CODE "113" :OBSERVATION-TITLE
     "Severe allergic reaction after previous dose of Rabies"
     :CONTRAINDICATION-TEXT
     "Do not vaccinate if the patient has had a severe allergic reaction after a previous dose of Rabies vaccine."
     :CONTRAINDICATION-GUIDANCE NIL :BEGIN-AGE NIL :END-AGE NIL)))
  :SERIES
  (:SERIES-NAME "Rabies risk 3-dose continuous series" :TARGET-DISEASE "Rabies"
   :VACCINE-GROUP "Rabies" :SERIES-ADMIN-GUIDANCE
   "The 6 month booster should only be given after a serum sample has been tested for rabies virus neutralizing antibody. The booster should be administered if the serum titer fails to maintain a value of at least complete neutralization of a 1:5 serum dilution by rapid fluorescent focus inhibition test."
   :SERIES-TYPE "Risk" :EQUIVALENT-SERIES-GROUPS NIL :REQUIRED-GENDER NIL
   :SELECT-SERIES
   (:DEFAULT-SERIES "No" :PRODUCT-PATH "No" :SERIES-GROUP-NAME "Increased Risk"
    :SERIES-GROUP "1" :SERIES-PRIORITY "A" :SERIES-PREFERENCE "1"
    :MIN-AGE-TO-START "0 days" :MAX-AGE-TO-START NIL)
   :INDICATION
   (:OBSERVATION-CODE (:TEXT "Rabies researchers" :CODE "053") :DESCRIPTION
    "Administer to Rabies researchers." :BEGIN-AGE "0 days" :END-AGE NIL
    :GUIDANCE NIL)
   :SERIES-DOSE
   (:DOSE-NUMBER "Dose 1" :AGE
    (:ABS-MIN-AGE "0 days" :MIN-AGE "0 days" :EARLIEST-REC-AGE "0 days"
     :LATEST-REC-AGE NIL :MAX-AGE NIL :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :INTERVAL NIL :ALLOWABLE-INTERVAL NIL :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, intramuscular injection" :CVX "18" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, unspecified formulation" :CVX "90" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :INADVERTENT-VACCINE NIL :CONDITIONAL-SKIP NIL :RECURRING-DOSE "No"
    :SEASONAL-RECOMMENDATION NIL)
   :SERIES-DOSE
   (:DOSE-NUMBER "Dose 2" :AGE
    (:ABS-MIN-AGE NIL :MIN-AGE NIL :EARLIEST-REC-AGE NIL :LATEST-REC-AGE NIL
     :MAX-AGE NIL :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :INTERVAL
    (:FROM-PREVIOUS "Y" :FROM-TARGET-DOSE NIL :FROM-MOST-RECENT NIL
     :FROM-RELEVANT-OBS NIL :ABS-MIN-INT "7 days" :MIN-INT "7 days"
     :EARLIEST-REC-INT "7 days" :LATEST-REC-INT NIL :INTERVAL-PRIORITY NIL
     :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :ALLOWABLE-INTERVAL NIL :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, intramuscular injection" :CVX "18" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, unspecified formulation" :CVX "90" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :INADVERTENT-VACCINE NIL :CONDITIONAL-SKIP NIL :RECURRING-DOSE "No"
    :SEASONAL-RECOMMENDATION NIL)
   :SERIES-DOSE
   (:DOSE-NUMBER "Dose 3" :AGE
    (:ABS-MIN-AGE NIL :MIN-AGE NIL :EARLIEST-REC-AGE NIL :LATEST-REC-AGE NIL
     :MAX-AGE NIL :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :INTERVAL
    (:FROM-PREVIOUS "Y" :FROM-TARGET-DOSE NIL :FROM-MOST-RECENT NIL
     :FROM-RELEVANT-OBS NIL :ABS-MIN-INT "14 days" :MIN-INT "14 days"
     :EARLIEST-REC-INT "14 days" :LATEST-REC-INT "21 days" :INTERVAL-PRIORITY
     NIL :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :ALLOWABLE-INTERVAL NIL :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, intramuscular injection" :CVX "18" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, unspecified formulation" :CVX "90" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :INADVERTENT-VACCINE NIL :CONDITIONAL-SKIP NIL :RECURRING-DOSE "No"
    :SEASONAL-RECOMMENDATION NIL)
   :SERIES-DOSE
   (:DOSE-NUMBER "Dose 4" :AGE
    (:ABS-MIN-AGE NIL :MIN-AGE NIL :EARLIEST-REC-AGE NIL :LATEST-REC-AGE NIL
     :MAX-AGE NIL :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :INTERVAL
    (:FROM-PREVIOUS "Y" :FROM-TARGET-DOSE NIL :FROM-MOST-RECENT NIL
     :FROM-RELEVANT-OBS NIL :ABS-MIN-INT "6 months" :MIN-INT "6 months"
     :EARLIEST-REC-INT "6 months" :LATEST-REC-INT NIL :INTERVAL-PRIORITY NIL
     :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :ALLOWABLE-INTERVAL NIL :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, intramuscular injection" :CVX "18" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, unspecified formulation" :CVX "90" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :INADVERTENT-VACCINE NIL :CONDITIONAL-SKIP NIL :RECURRING-DOSE "Yes"
    :SEASONAL-RECOMMENDATION NIL))
  :SERIES
  (:SERIES-NAME "Rabies risk 3-dose frequent series" :TARGET-DISEASE "Rabies"
   :VACCINE-GROUP "Rabies" :SERIES-ADMIN-GUIDANCE
   "The 2 year booster should only be given after a serum sample has been tested for rabies virus neutralizing antibody. The booster should be administered if the serum titer fails to maintain a value of at least complete neutralization of a 1:5 serum dilution by rapid fluorescent focus inhibition test."
   :SERIES-TYPE "Risk" :EQUIVALENT-SERIES-GROUPS NIL :REQUIRED-GENDER NIL
   :SELECT-SERIES
   (:DEFAULT-SERIES "No" :PRODUCT-PATH "No" :SERIES-GROUP-NAME "Increased Risk"
    :SERIES-GROUP "1" :SERIES-PRIORITY "B" :SERIES-PREFERENCE "1"
    :MIN-AGE-TO-START "0 days" :MAX-AGE-TO-START NIL)
   :INDICATION
   (:OBSERVATION-CODE (:TEXT "Veterinarians and their staff" :CODE "060")
    :DESCRIPTION "Administer to veterinarians and their staff." :BEGIN-AGE
    "0 days" :END-AGE NIL :GUIDANCE NIL)
   :INDICATION
   (:OBSERVATION-CODE (:TEXT "Animal handlers" :CODE "061") :DESCRIPTION
    "Administer to animal handlers." :BEGIN-AGE "0 days" :END-AGE NIL :GUIDANCE
    NIL)
   :INDICATION
   (:OBSERVATION-CODE
    (:TEXT
     "Persons whose activities bring them into frequent contact with rabies virus or potentially rabid animals"
     :CODE "062")
    :DESCRIPTION
    "Administer to persons whose activities bring them into frequent contact with rabies virus or potentially rabid animals."
    :BEGIN-AGE "0 days" :END-AGE NIL :GUIDANCE NIL)
   :INDICATION
   (:OBSERVATION-CODE
    (:TEXT
     "International travel with possible contact with animals in areas where rabies is enzootic and immediate access to appropriate medical care might be limited"
     :CODE "144")
    :DESCRIPTION
    "Administer to persons with plans for international travel with possible contact with animals in areas where rabies is enzootic and immediate access to appropriate medical care might be limited."
    :BEGIN-AGE "0 days" :END-AGE NIL :GUIDANCE NIL)
   :SERIES-DOSE
   (:DOSE-NUMBER "Dose 1" :AGE
    (:ABS-MIN-AGE "0 days" :MIN-AGE "0 days" :EARLIEST-REC-AGE "0 days"
     :LATEST-REC-AGE NIL :MAX-AGE NIL :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :INTERVAL NIL :ALLOWABLE-INTERVAL NIL :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, intramuscular injection" :CVX "18" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, unspecified formulation" :CVX "90" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :INADVERTENT-VACCINE NIL :CONDITIONAL-SKIP NIL :RECURRING-DOSE "No"
    :SEASONAL-RECOMMENDATION NIL)
   :SERIES-DOSE
   (:DOSE-NUMBER "Dose 2" :AGE
    (:ABS-MIN-AGE NIL :MIN-AGE NIL :EARLIEST-REC-AGE NIL :LATEST-REC-AGE NIL
     :MAX-AGE NIL :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :INTERVAL
    (:FROM-PREVIOUS "Y" :FROM-TARGET-DOSE NIL :FROM-MOST-RECENT NIL
     :FROM-RELEVANT-OBS NIL :ABS-MIN-INT "7 days" :MIN-INT "7 days"
     :EARLIEST-REC-INT "7 days" :LATEST-REC-INT NIL :INTERVAL-PRIORITY NIL
     :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :ALLOWABLE-INTERVAL NIL :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, intramuscular injection" :CVX "18" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, unspecified formulation" :CVX "90" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :INADVERTENT-VACCINE NIL :CONDITIONAL-SKIP NIL :RECURRING-DOSE "No"
    :SEASONAL-RECOMMENDATION NIL)
   :SERIES-DOSE
   (:DOSE-NUMBER "Dose 3" :AGE
    (:ABS-MIN-AGE NIL :MIN-AGE NIL :EARLIEST-REC-AGE NIL :LATEST-REC-AGE NIL
     :MAX-AGE NIL :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :INTERVAL
    (:FROM-PREVIOUS "Y" :FROM-TARGET-DOSE NIL :FROM-MOST-RECENT NIL
     :FROM-RELEVANT-OBS NIL :ABS-MIN-INT "14 days" :MIN-INT "14 days"
     :EARLIEST-REC-INT "14 days" :LATEST-REC-INT "21 days" :INTERVAL-PRIORITY
     NIL :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :ALLOWABLE-INTERVAL NIL :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, intramuscular injection" :CVX "18" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, unspecified formulation" :CVX "90" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :INADVERTENT-VACCINE NIL :CONDITIONAL-SKIP NIL :RECURRING-DOSE "No"
    :SEASONAL-RECOMMENDATION NIL)
   :SERIES-DOSE
   (:DOSE-NUMBER "Dose 4" :AGE
    (:ABS-MIN-AGE NIL :MIN-AGE NIL :EARLIEST-REC-AGE NIL :LATEST-REC-AGE NIL
     :MAX-AGE NIL :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :INTERVAL
    (:FROM-PREVIOUS "Y" :FROM-TARGET-DOSE NIL :FROM-MOST-RECENT NIL
     :FROM-RELEVANT-OBS NIL :ABS-MIN-INT "2 years" :MIN-INT "2 years"
     :EARLIEST-REC-INT "2 years" :LATEST-REC-INT NIL :INTERVAL-PRIORITY NIL
     :EFFECTIVE-DATE NIL :CESSATION-DATE NIL)
    :ALLOWABLE-INTERVAL NIL :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :PREFERABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL :TRADE-NAME NIL :MVX NIL :VOLUME "1"
     :FORECAST-VACCINE-TYPE "N")
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, intramuscular injection" :CVX "18" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies, unspecified formulation" :CVX "90" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM Diploid cell culture" :CVX "175" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :ALLOWABLE-VACCINE
    (:VACCINE-TYPE "Rabies - IM fibroblast culture" :CVX "176" :BEGIN-AGE
     "0 days" :END-AGE NIL)
    :INADVERTENT-VACCINE NIL :CONDITIONAL-SKIP NIL :RECURRING-DOSE "Yes"
    :SEASONAL-RECOMMENDATION NIL))))