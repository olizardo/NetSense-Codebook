
use "M:\JoeWorkmanWork\Demographic Surveys\Summer 2011(W1) - Demographic Survey - 2013_07_3.dta", clear

drop if duplicate==2
destring phonenumber, replace
sort phonenumber

save "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys .dta", 



use "M:\JoeWorkmanWork\Demographic Surveys\Winter 2012(W2) - Demographic Survey - 2013_08_2.dta", clear
drop if duplicate==2
rename sender phonenumber
tostring phonenumber, replace

sort phonenumber

merge 1:m phonenumber using "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys .dta",


*    Result                           # of obs.
*    -----------------------------------------
*    not matched                            29
*        from master                         3  (_merge==1)
*        from using                         26  (_merge==2)
*
*    matched                               175  (_merge==3)
*    -----------------------------------------

drop _merge
sort phonenumber

save "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys .dta", replace



use "M:\JoeWorkmanWork\Demographic Surveys\Summer 2012(W3) - Demographic Survey - 2013_8_3.dta", clear

drop if duplicate==2
rename sender phonenumber
tostring phonenumber, replace

sort phonenumber

drop _merge
*why has this data already been merged???
merge 1:m phonenumber using "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys .dta",


*  Result                           # of obs.
*    -----------------------------------------
*    not matched                            33
*        from master                         0  (_merge==1)
*        from using                         33  (_merge==2)
*
*    matched                               171  (_merge==3)
*    -----------------------------------------

drop _merge
sort phonenumber

save "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys .dta", replace




use "M:\JoeWorkmanWork\Demographic Surveys\Fall 2012(W4) - Demographic Survey - 2013_8_2.dta", clear

drop if duplicate==2
rename sender phonenumber
tostring phonenumber, replace


sort phonenumber


merge 1:m phonenumber using "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys .dta",

*  Result                           # of obs.
*    -----------------------------------------
*    not matched                            30
*        from master                         0  (_merge==1)
*        from using                         30  (_merge==2)
*
*    matched                               174  (_merge==3)
*    -----------------------------------------

drop _merge
sort phonenumber

save "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys .dta", replace



use "M:\JoeWorkmanWork\Demographic Surveys\Winter 2013(W5) - Demographic Survey - 2013_8_2.dta", clear

drop if duplicate==2
rename sender phonenumber
tostring phonenumber, replace


sort phonenumber


merge 1:m phonenumber using "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys .dta",

*   Result                           # of obs.
*    -----------------------------------------
*    not matched                            54
*        from master                         0  (_merge==1)
*        from using                         54  (_merge==2)
*
*    matched                               150  (_merge==3)
*    -----------------------------------------


drop _merge
sort phonenumber

save "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys .dta", replace



use "M:\JoeWorkmanWork\Demographic Surveys\Summer 2013(W6) - Demographic Survey - 2013_8_2.dta", clear


drop if duplicate==2
rename sender phonenumber
tostring phonenumber, replace


sort phonenumber


merge m:m phonenumber using "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys .dta",


*    Result                           # of obs.
*    -----------------------------------------
*    not matched                            68
*        from master                         0  (_merge==1)
*        from using                         68  (_merge==2)
*
*    matched                               137  (_merge==3)
*    -----------------------------------------



drop _merge
sort phonenumber

save "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys .dta", replace



replace phonenumber="nonum1" if LastName_1=="LaMagna"
replace phonenumber="nonum2" if LastName_1=="Fuller"
replace phonenumber="nonum3" if LastName_1=="Martinez-Palmer"
replace phonenumber="nonum4" if LastName_1=="Corish"
replace phonenumber="nonum5" if LastName_1=="Van Handel"
replace phonenumber="nonum6" if LastName_1=="Cornfield"
drop if LastName_2=="sdfas"

tostring clubs6_5, replace
tostring clubs7_5, replace
tostring clubs7_6, replace
tostring clubs8_4, replace
tostring clubs8_5, replace
tostring clubs8_6, replace
tostring clubs9_4, replace
tostring clubs9_5, replace
tostring clubs9_6, replace
tostring clubs10_4, replace
tostring clubs10_5, replace
tostring clubs10_6, replace
tostring semclasses2_6, replace
tostring semclasses5_6, replace
*this variable has no observations so it was set as byte *

*** Working on Reshaping ***


reshape long FirstName_ LastName_ id_ semwork_ clubs1_ clubs2_ clubs3_ clubs4_ clubs5_ ///
clubs6_ clubs7_ clubs8_ clubs9_ clubs10_ major_ semclasses1_ semclasses2_ semclasses3_ ///
semclasses4_ semclasses5_ semclasses6_ semclasses7_ weight_ ///
health_ happy_ iamsomeonewho1_ iamsomeonewho2r_ iamsomeonewho3_ iamsomeonewho4_ iamsomeonewho5_ ///
iamsomeonewho6r_ iamsomeonewho7_ iamsomeonewho8r_ iamsomeonewho9r_ iamsomeonewho10_ iamsomeonewho11_ ///
iamsomeonewho12r_ iamsomeonewho13_ iamsomeonewho14_ iamsomeonewho15_ iamsomeonewho16_ iamsomeonewho17_ ///
iamsomeonewho18r_ iamsomeonewho19_ iamsomeonewho20_ iamsomeonewho21r_ iamsomeonewho22_ iamsomeonewho23r_ ///
iamsomeonewho24r_ iamsomeonewho25_ iamsomeonewho26_ iamsomeonewho27r_ iamsomeonewho28_ iamsomeonewho29_ ///
iamsomeonewho30_ iamsomeonewho31r_ iamsomeonewho32_ iamsomeonewho33_ iamsomeonewho34r_ iamsomeonewho35r_ ///
iamsomeonewho36_ iamsomeonewho37r_ iamsomeonewho38_ iamsomeonewho39_ iamsomeonewho40_ iamsomeonewho41r_ iamsomeonewho42_ ///
iamsomeonewho43r_ iamsomeonewho44_ wellbeing1_ wellbeing2_ wellbeing3_ wellbeing4_ wellbeing5_ ///
activity1_ activity2_ activity3_ activity4_ activity5_ activity6_ activity7_ activity8_ ///
activity9_ activity10_ activity11_ activity12_ activity13_ activity14_ timeperweekactivea_ ///
timeperweekactiveb_ timeperweekactivec_ timeperweekactived_ timeperweekactivee_ timeperweekactivef_ ///
timeperweekactiveg_ timeperweekactiveh_ timeperweekactivei_ timeperweekactivej_ timeperweekactivek_ ///
timeperweekactivel_ timeperweekactivem_ timeperweekactiven_ importance1_ importance2_ importance3_ ///
importance4_ importance5_ importance6_ importance7_ importance8_ importance9_ importance10_ importance11_ ///
importance12_ importance13_ importance14_ importance15_ importance16_ guesschance1_ guesschance2_ ///
guesschance3_ guesschance4_ guesschance5_ guesschance6_ guesschance7_ guesschance8_ guesschance9_ ///
guesschance10_ guesschance11_ guesschance12_ guesschance13_ guesschance14_ political_ deathpen_ ///
marijuana_ abortion_ homosexual_ gaymarriage_ premaritalsex_ euthanasia_ fswelfare_ fssocsec_ ///
healthins_ jobguar_ govnservices_ toomucheqrights_ eqchances_ lesseq_ racediscrim_ musicpref1_ ///
musicpref2_ musicpref3_ musicpref4_ musicpref5_ musicpref6_ musicpref7_ musicpref8_ musicpref9_ ///
musicpref10_ musicpref11_ musicpref12_ musicpref13_ musicpref14_ musicpref15_ musicpref16_ ///
musicpref17_ musicpref18_ musicpref19_ musicpref20_ musicpref21_ musicpref22_ musicprefother_ ///
booksread_ typebookread1_ typebookread2_ typebookread3_ typebookread4_ typebookread5_ typebookread6_ ///
typebookread7_ typebookread8_ typebookread9_ typebookreadother_ interestitems1_ interestitems2_ ///
interestitems3_ interestitems4_ interestitems5_ interestitems6_ selfrelig_ occupationmom_ ///
occupationdad_ occupationstudent_ parentsmarriage_ emailaddress_ extraversion_ agreeableness_ ///
conscientiousness_ neuroticism_ openness_ culturalevents1_ culturalevents2_ culturalevents3_ ///
culturalevents4_ culturalevents5_ culturalevents6_ culturalevents7_ culturalevents8_ ///
culturalevents9_ culturalevents10_ culturalevents11_ culturalevents12_, i(phonenumber) j(wave)


** Consider adding: completed 
** hswork_1 and semwork; semclasses (doesn't fit for hs); also summer2012work_4
** grades is also a mess;
** get rid of the 1 at the end of toomucheqrights eqchances and moreeqchances (3-6)
** Some variables have 1 at the end but it is consistent for all waves; do we want this?)
  * premaritalsex fswelfare fssocsec lesseq 
** Waves 5,6 seem to be missing culturalevents landmarks usesocnetwork
  
  
*tab1 clubs1_6- clubs10_6
* There might be a problem with extraversion agreeableness conscientiousness neuroticism openness *
* I don't believe that they were assigned _# values for each wave *

* Problem 1: all stems would be stuck with _ at the end *
* Problem 2: phonenumber does not uniquely identify rows *
* Problem 3: clubs6_5, semclasses2_6 type mismatch with other variables *
* Problem 4: some iamsomewho... variables have an r at the end *
* Problem 5: 



save "M:\JoeWorkmanWork\Demographic Surveys\Merged Demographic Surveys  Long Form.dta", replace

*** Not Founds ***

rename homosexual1_3-6* (have to be changed in the command to move to longform)
rename premarital1_3-6*
rename fswelfare1_3-6*
rename fssocsec1_3-6*
rename lesseq_3-6*
rename toomucheqrights1_3-6
rename eqchances1_3-6
fix timeperweekactivitm_2
hswork1 & summer2012work_4 (ask Hachen whether to leave these as they are)

(note: j = 1 2 3 4 5 6)
(note: id_1 not found)
(note: semwork_1 not found)
(note: clubs1_1 not found)
(note: clubs2_1 not found)
(note: clubs3_1 not found)
(note: clubs4_1 not found)
(note: clubs5_1 not found)
(note: clubs6_1 not found)
(note: clubs7_1 not found)
(note: clubs8_1 not found)
(note: clubs9_1 not found)
(note: clubs10_1 not found)
(note: semclasses1_1 not found)
(note: semclasses2_1 not found)
(note: semclasses3_1 not found)
(note: semclasses4_1 not found)
(note: semclasses5_1 not found)
(note: semclasses6_1 not found)
(note: semclasses7_1 not found)
(note: timeperweekactivem_2 not found)
(note: semwork_4 not found)
(note: semclasses1_4 not found)
(note: semclasses2_4 not found)
(note: semclasses3_4 not found)
(note: semclasses4_4 not found)
(note: semclasses5_4 not found)
(note: semclasses6_4 not found)
(note: semclasses7_4 not found)
(note: culturalevents1_5 not found)
(note: culturalevents2_5 not found)
(note: culturalevents3_5 not found)
(note: culturalevents4_5 not found)
(note: culturalevents5_5 not found)
(note: culturalevents6_5 not found)
(note: culturalevents7_5 not found)
(note: culturalevents8_5 not found)
(note: culturalevents9_5 not found)
(note: culturalevents10_5 not found)
(note: culturalevents11_5 not found)
(note: culturalevents12_5 not found)
(note: culturalevents1_6 not found)
(note: culturalevents2_6 not found)
(note: culturalevents3_6 not found)
(note: culturalevents4_6 not found)
(note: culturalevents5_6 not found)
(note: culturalevents6_6 not found)
(note: culturalevents7_6 not found)
(note: culturalevents8_6 not found)
(note: culturalevents9_6 not found)
(note: culturalevents10_6 not found)
(note: culturalevents11_6 not found)
(note: culturalevents12_6 not found)

























































































