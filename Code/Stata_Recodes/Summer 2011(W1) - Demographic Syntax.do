This Syntax Copies SummerSurvey11_RecodeALL-margaret Until line 2000
Three Additions: Recording rather than dropping duplicates
Making Sure Variable names have common stems with other waves
Making sure iamsomeonewho variables with r are actually recoded

//Summer Survey 2011 Recode (including labels, destringing, phone#fix)
ATTENTION: SEE ABOVE
insheet using "M:\Current Data\Mike's survey code - 5-13-2013\Summer 2011 - Demographic Data.csv"
set more off
rename namenetidsq001 FirstName
rename namenetidsq002 LastName
drop namenetidsq003
order netid, after(LastName)


tab1 hometown 
gen hometown1=.
replace hometown1=1 if hometown=="5 or less"
replace hometown1=2 if hometown=="6-10"
replace hometown1=3 if hometown=="11-50"
replace hometown1=4 if hometown=="51-100"
replace hometown1=5 if hometown=="101-500"
replace hometown1=6 if hometown=="Over 500"
label variable hometown1 "Hometown numeric"
label define Hometown 1 "1-5" 2 "6-10" 3 "11-50" 4 "51-100" 5 "101-500" 6 "Over 500"
drop hometown
rename hometown1 hometown
order hometown, before(residenthall)

tab1 ethnicity
encode ethnicity, generate(ethnicity1)
tab1 ethnicity ethnicity1, nolabel
drop ethnicity
rename ethnicity1 ethnicity
label variable ethnicity "Ethnicity (numeric)"
order ethnicity, before(residenthall)

tab1 gender
encode gender, generate(gender1)
tab1 gender gender1, nolabel
drop gender
rename gender1 gender
label variable gender "Gender (numeric)"
order gender, before(residenthall)

tab1 residenthall
encode residenthall, generate(reshall)
tab1 residenthall reshall, nolabel
drop residenthall
label variable reshall "Resident Hall"
order reshall, before(smartphone)

tab1 smartphone
encode smartphone, generate(smrtphone)
tab1 smartphone smrtphone, nolabel
drop smartphone
label variable smrtphone "Type of smartphone previously owned"
order smrtphone, before(cellularprovider)

tab1 cellularprovider
encode cellularprovider, generate(cellprovider)
tab1 cellularprovider cellprovider, nolabel
drop cellularprovider
label variable cellprovider "Cell phone provider of previous phone"
order cellprovider, before(typehighschool)

tab1 typehighschool
encode typehighschool, generate(hstype)
tab1 typehighschool hstype, nolabel mis
drop typehighschool
label variable hstype "Type of high school attended"
order hstype, before(typehighschoolother)
rename typehighschoolother hstypeother

tab1 samesex, mis
encode samesex, generate(hsgender)
tab1 samesex hsgender, nolabel mis
drop samesex
label variable hsgender "Gender makeup of High School"
order hsgender, before(hsgrade)

tab1 hsgrade
encode hsgrade, gen(hsgrade1)
tab1 hsgrade hsgrade1, nolabel mis
recode hsgrade1 1=4 2=3 3=1 4=2
label define grade 1 "B" 2 "B+" 3 "A-" 4 "A or A+"
label value hsgrade1 grade
tab1 hsgrade hsgrade1, mis
drop hsgrade
rename hsgrade1 hsgrade
order hsgrade, before(apcoursesapco1)

tab1 apcoursesapco1 apcoursesapco2
foreach var of varlist apcoursesapco1-apcoursesapco2 {
encode `var', gen(`var'a)
}
label define ap 0 "Not offered at my high school" 1 "None" 2 "1-2" 3 "3-4" 4 "5-9" 5 "10-14" 6 "15 or more"
recode apcoursesapco1a 1=5 2=6 3=2 4=3 5=4 6=1 7=0
recode apcoursesapco2a 1=5 2=2 3=3 4=4 5=1 6=0
label value apcoursesapco1a ap
label value apcoursesapco2a ap
tab1 apcoursesapco1-apcoursesapco2 apcoursesapco1a-apcoursesapco2a
order apcoursesapco1a-apcoursesapco2a, before(highestdegreesq001) 
drop apcoursesapco1-apcoursesapco2
rename apcoursesapco1a apcourses1
rename apcoursesapco2a apcourses2

tab1 highestdegreesq001
encode highestdegreesq001, gen(highestdegree)
label define highestdegree1 1 "Bachelor's Degree" 2 "Master's Degree" 3 "J.D. (Law)" 4 "M.D., D.O., D.D.S., or D.V.M.)" 5 "Ph.D. or Ed. D"
recode highestdegree 1=1 2=2 3=4 4=3 5=5
label value highestdegree highestdegree1
tab1 highestdegree highestdegreesq001, mis
order highestdegree, before(undergradmajor)
drop highestdegreesq001

tab1 undergradmajor
encode undergradmajor, gen(major)
order major, before(highschoolwork)
tab1 major, nolabel
drop undergradmajor

tab1 highschoolwork, nolabel
encode highschoolwork, gen(hswork)
label define hswork1 0 "None" 1 "0-4" 2 "5-10" 3 "11-15" 4 "16-20" 5 "21 or more"
recode hswork 1=1 2=2 3=3 4=4 5=5 6=0
label value hswork hswork1
tab1 hswork highschoolwork, mis
order hswork, before(clubsclu01)
drop highschoolwork

tab1 clubsclu01-clubsclu34
foreach var of varlist clubsclu01-clubsclu34 {
encode `var', generate (`var'1)
}
tab1 clubsclu011-clubsclu341, mis
foreach var of varlist clubsclu011-clubsclu341 {
recode `var' 1=0 2=1
}
tab1 clubsclu011-clubsclu341, mis
label define clubs 0 "No" 1 "Yes"
foreach var of varlist clubsclu011-clubsclu341 {
label values `var' clubs
}
tab1 clubsclu011-clubsclu341, mis
order clubsclu011-clubsclu341, before(clubsother)
drop clubsclu01-clubsclu34



tab1 relativesndrend1-relativesndrend5
foreach var of varlist relativesndrend1-relativesndrend5 {
encode `var', generate (`var'1)
}
tab1 relativesndrend11-relativesndrend51, mis nolabel
label define relatives 0 "No" 1 "Yes"
foreach var of varlist relativesndrend11-relativesndrend51 {
recode `var' 1=0 2=1
label values `var' relatives
}
tab1 relativesndrend11-relativesndrend51, mis nolabel
order relativesndrend11-relativesndrend51, before(relativesndother)
drop relativesndrend1-relativesndrend5


tab1 firstchoice
encode firstchoice, generate(fstchoice)
tab1 firstchoice fstchoice, nolabel
replace fstchoice=. if fstchoice==1
replace fstchoice=1 if fstchoice==3
replace fstchoice=0 if fstchoice==2
tab1 fstchoice firstchoice, nolabel
order fstchoice, before(wellbeingindexsq001)
drop firstchoice
label define choice 0 "No" 1 "Yes"
label values fstchoice choice

tab1 wellbeingindexsq001-wellbeingindexsq005
foreach var of varlist wellbeingindexsq001-wellbeingindexsq005 {
encode `var', generate (`var'x)
}
tab1 wellbeingindexsq001x-wellbeingindexsq005x, mis 
tab1 wellbeingindexsq001x-wellbeingindexsq005x, mis nolabel
label define wellbeing 0 "At no time" 1 "Some of the time" 2 "Less than half the time" 3 "More than half the time" 4 "Most of the time" 5 "All the time"
foreach v of varlist wellbeingindexsq001x wellbeingindexsq002x wellbeingindexsq005x {
recode `v' 1=5 2=2 3=3 4=4 5=1
label value `v' wellbeing
}
foreach v of varlist wellbeingindexsq003x wellbeingindexsq004x {
recode `v' 1=5 2=0 3=2 4=3 5=4 6=1
label value `v' wellbeing
}
tab1 wellbeingindexsq001x-wellbeingindexsq005x, mis

tab1 wellbeingindexsq001x-wellbeingindexsq005x, mis 
tab1 wellbeingindexsq001x-wellbeingindexsq005x, mis nolabel
order wellbeingindexsq001x-wellbeingindexsq005x, before(iamsomeonewho1)
drop wellbeingindexsq001-wellbeingindexsq005
rename wellbeingindexsq001x wellbeing1
rename wellbeingindexsq002x wellbeing2
rename wellbeingindexsq003x wellbeing3
rename wellbeingindexsq004x wellbeing4
rename wellbeingindexsq005x wellbeing5


tab1 iamsomeonewho1-iamsomeonewho44
/// only 4 categories 40 38 34 33 32 28 15 5 3 ///
/// only 3 categories 13 ///
foreach var of varlist iamsomeonewho1-iamsomeonewho44 {
encode `var', generate (`var'a)
}
tab1 iamsomeonewho1a-iamsomeonewho44a
order iamsomeonewho40a iamsomeonewho38a iamsomeonewho34a iamsomeonewho33a iamsomeonewho32a iamsomeonewho28a iamsomeonewho15a iamsomeonewho5a iamsomeonewho3a, before(iamsomeonewho1a)
order iamsomeonewho13a, before(iamsomeonewho40a)
/// recode 5 category iamsomeone variables
tab1 iamsomeonewho1a-iamsomeonewho44a
label define iam 1 "Strongly disagree" 2 "Disagree" 3 "Neither agree nor disagree" 4 "Agree" 5 "Strongly agree"
foreach var of varlist iamsomeonewho1a-iamsomeonewho44a {
recode `var' 1=4 2=2 3=3 4=5 5=1 .=.
label values `var' iam
}
tab1 iamsomeonewho1a-iamsomeonewho44a, mis
/// recode 4 category iamsomeone variables missing strongly disagree (all but 3a)
tab1 iamsomeonewho40a-iamsomeonewho5a
foreach var of varlist iamsomeonewho40a-iamsomeonewho5a {
recode `var' 1=4 2=2 3=3 4=5 .=.
label values `var' iam
}
tab1 iamsomeonewho40a-iamsomeonewho5a, mis
tab1 iamsomeonewho40a-iamsomeonewho5a, mis nolabel

//recode "R" questions
foreach v of varlist iamsomeonewho34a iamsomeonewho2a iamsomeonewho6a iamsomeonewho8a iamsomeonewho9a iamsomeonewho12a iamsomeonewho18a iamsomeonewho21a iamsomeonewho23a iamsomeonewho24a iamsomeonewho27a iamsomeonewho31a iamsomeonewho35a {
recode `v' 1=5 2=4 3=3 4=2 5=1
label value `v' iam
}

/// recode of 3a because of str dis
tab1 iamsomeonewho3a
recode iamsomeonewho3a 1=4 2=3 3=5 4=1
label values iamsomeonewho3a iamsomeone
tab1 iamsomeonewho3a, mis
tab1 iamsomeonewho3a, mis nolabel
/// redoce of 13a because 3 categories
tab1 iamsomeonewho13a
recode iamsomeonewho13a 1=4 2=3 3=5
label values iamsomeonewho13a iamsomeone
tab1 iamsomeonewho13a, mis
tab1 iamsomeonewho13a, mis nolabel
/// reorder
order iamsomeonewho1a-iamsomeonewho2a iamsomeonewho3a iamsomeonewho4a iamsomeonewho5a iamsomeonewho6a-iamsomeonewho12a iamsomeonewho13a iamsomeonewho14a iamsomeonewho15a iamsomeonewho16a-iamsomeonewho27a iamsomeonewho28a iamsomeonewho29a-iamsomeonewho31a iamsomeonewho34a-iamsomeonewho32a iamsomeonewho35a-iamsomeonewho37a iamsomeonewho38a iamsomeonewho39a iamsomeonewho40a iamsomeonewho41a-iamsomeonewho44a, before(happiness)
order iamsomeonewho32a, before(iamsomeonewho34a)
order iamsomeonewho32a, before(iamsomeonewho33a)
order iamsomeonewho34a, before(iamsomeonewho35a)
drop iamsomeonewho1-iamsomeonewho44


tab1 happiness
encode happiness, generate(happy)
recode happy 1=3 2=1 3=0 4=2 5=4
label define happy1 0 "Not sure" 1 "Not so happy" 2 "Pretty happy" 3 "Happy" 4 "Very happy" 
label values happy happy1
tab1 happiness happy,  mis
order happy, before(health)
drop happiness

tab1 health
encode health, generate(health1)
recode health1 1=4 2=3 3=2 4=1
label define health 1 "Poor" 2 "Fair" 3 "Good" 4 "Excellent"
label values health1 health
tab1 health health1, mis
order health1, before(weitht)
drop health
rename health1 health



tab1 weitht
rename weitht weight

tab1 heightsq001 heightsq002
///not sure what to do with these at this point; FIXED-margaret
tab1 height*
gen height=.

replace height=0 if heightsq001==""
replace height=48 if heightsq001=="4"
replace height=60 if heightsq001=="5'"
replace height=60 if heightsq001=="5"
replace height=72 if heightsq001=="6"

gen heightin=.
replace heightin=0 if heightsq002==""
replace heightin=0 if heightsq002=="0"
replace heightin=1 if heightsq002=="1"
replace heightin=2 if heightsq002=="2"
replace heightin=2.5 if heightsq002=="2.5"
replace heightin=3 if heightsq002=="3"
replace heightin=3.5 if heightsq002=="3 1/2"
replace heightin=3.5 if heightsq002=="3.5"
replace heightin=4 if heightsq002=="4"
replace heightin=4.5 if heightsq002=="4.5"
replace heightin=5 if heightsq002=="5"
replace heightin=5.5 if heightsq002=="5 1/2"
replace heightin=6 if heightsq002=="6"
replace heightin=6.5 if heightsq002=="6.5"
replace heightin=6.75 if heightsq002=="6.75"
replace heightin=7 if heightsq002=="7"
replace heightin=7.75 if heightsq002=="7 3/4"
replace heightin=8 if heightsq002=="8"
replace heightin=9 if heightsq002=="9"
replace heightin=9.5 if heightsq002=="9.5"
replace heightin=10 if heightsq002=="10''"
replace heightin=10 if heightsq002=="10"
replace heightin=11 if heightsq002=="11"
replace heightin=11.5 if heightsq002=="11 1/2"
replace heightin=11.5 if heightsq002=="11.5"
replace heightin=52.2 if heightsq002=="52.2"
replace heightin=63.78 if heightsq002=="63.78"
replace heightin=64.2 if heightsq002=="64.2"
replace heightin=70 if heightsq002=="70"

gen heighttotal=height+heightin
replace heighttotal=. if heighttotal==0
tab heighttotal
label variable heighttotal "Height in inches combined"
order height-heighttotal, after(heightsq002)
drop heightsq001-heightsq002
drop height-heightin



tab1 eyeglasses-disabilitylearning
foreach var of varlist eyeglasses-disabilitylearning {
encode `var', generate(`var'1)
}
label define glasses1 0 "No" 1 "Yes"
foreach var of varlist eyeglasses1-disabilitylearning1 {
recode `var' 1=. 2=0 3=1
label values `var' glasses1
}
tab1 eyeglasses eyeglasses1, mis
tab1 disabilityphysical disabilityphysical1, mis
order eyeglasses1-disabilitylearning1, before(activitypastyear1)
drop eyeglasses-disabilitylearning


tab1 activitypastyear1-activitypastyear14
/// missing everyday:2,3,13   missing not at all:6
/// starting with those with all
foreach var of varlist activitypastyear1-activitypastyear14 {
encode `var', generate(`var'a)
}
order activitypastyear2a activitypastyear3a activitypastyear13a activitypastyear6a, before(activitypastyear1a)
tab1 activitypastyear1a
label define activity 1 "Not at all" 2 "Less than 1-2 times a month" 3 "1-2 times a month" 4 "1-2 times a week" 5 "Everyday or almost everyday"
foreach var of varlist activitypastyear1a-activitypastyear14a {
recode `var' 1=3 2=4 3=5 4=2 5=1
label values `var' activity
}
tab1 activitypastyear1a-activitypastyear14a
tab1 activitypastyear1a activitypastyear1, mis
/// missing everyday variables
tab1 activitypastyear2a-activitypastyear13a
foreach var of varlist activitypastyear2a-activitypastyear13a {
recode `var' 1=3 2=4 3=2 4=1
label values `var' activity
}
tab1 activitypastyear2a-activitypastyear13a, mis
tab1 activitypastyear2-activitypastyear13, mis
/// missing not at all:6
tab1 activitypastyear6a
recode activitypastyear6a 1=3 2=4 3=5 4=2
label values activitypastyear6a activity
tab1 activitypastyear6a activitypastyear6, mis
order activitypastyear1a activitypastyear2a activitypastyear3a activitypastyear4a activitypastyear5a activitypastyear6a activitypastyear7a-activitypastyear12a activitypastyear13a activitypastyear14a, before(highschoolactivitya)
drop activitypastyear1-activitypastyear14




tab1 highschoolactivitya-highschoolactivityn
/// missing none:a,b    
/// missing 16-20 and over 20:d,f,
/// missing 16-20 only: l
/// missing Over 20 only: m
foreach var of varlist highschoolactivitya-highschoolactivityn {
encode `var', generate(`var'1)
}
order highschoolactivitya1 highschoolactivityb1 highschoolactivityd1 highschoolactivityf1  highschoolactivityl1 highschoolactivitym1, before(highschoolactivityc1)
/// starting with those var with all
tab1 highschoolactivityc1-highschoolactivityn1
label define hsact 1 "None" 2 "Less than an hour" 3 "1-2 Hours" 4 "3-5 Hours" 5 "6-10 Hours" 6 "11-15" 7 "16-20" 8 "Over 20 Hours"
foreach var of varlist highschoolactivityc1-highschoolactivityn1 {
recode `var' 1=5 2=6 3=7 4=3 5=4 6=2 7=1 8=8
label values `var' hsact
}
tab1 highschoolactivityc1-highschoolactivityn1
tab1 highschoolactivityc1 highschoolactivityc, mis
/// now missing none
tab1 highschoolactivitya1-highschoolactivityb1
foreach var of varlist highschoolactivitya1-highschoolactivityb1 {
recode `var' 1=5 2=6 3=7 4=3 5=4 6=2 7=8
label values `var' hsact
}
tab1 highschoolactivitya1-highschoolactivityb1 highschoolactivitya-highschoolactivityb, mis
/// 16-20 and over 20:d,f
tab1 highschoolactivityd1-highschoolactivityf1
foreach var of varlist highschoolactivityd1-highschoolactivityf1 {
recode `var' 1=5 2=6 3=3 4=4 5=2 6=1
label values `var' hsact
}
tab1 highschoolactivityd1-highschoolactivityf1 highschoolactivityd highschoolactivityf, mis
/// now missing 16-20 only: l
drop highschoolactivityl1
encode highschoolactivityl, generate(highschoolactivityl1)
tab1 highschoolactivityl1
recode highschoolactivityl1 1=5 2=6 3=3 4=4 5=2 6=1 7=8
label values highschoolactivityl1 hsact
tab1 highschoolactivityl1 highschoolactivityl
/// now missing Over 20 only: m
drop highschoolactivitym1
encode highschoolactivitym, generate(highschoolactivitym1)
tab1 highschoolactivitym1
recode highschoolactivitym1 1=5 2=6 3=7 4=3 5=4 6=2 7=1
label values highschoolactivitym1 hsact
tab1 highschoolactivitym1 highschoolactivitym
///order
order highschoolactivitya1 highschoolactivityb1 highschoolactivityc1 highschoolactivityd1 highschoolactivitye1 highschoolactivityf1 highschoolactivityg1-highschoolactivityk1 highschoolactivityl1 highschoolactivitym1 highschoolactivityn1, before(importance1)
drop highschoolactivitya-highschoolactivityn



tab1 importance1-importance16 
///all the same!
foreach var of varlist importance1-importance16 {
encode `var', generate(`var'a)
}
label define importance 1 "Not important" 2 "Somewhat important" 3 "Very Important" 4 "Essential"
foreach var of varlist importance1a-importance16a {
recode `var' 1=4 2=1 3=2 4=3
label values `var' importance
}
tab1 importance1a-importance16a, mis
tab1 importance1a importance1, mis
order importance1a-importance16a, before(guesschance1)
drop importance1-importance16



tab1 guesschance1-guesschance14
/// without nochance:11, 12 all else have 4 categories
foreach var of varlist guesschance1-guesschance14 {
encode `var', generate(`var'a)
}
order guesschance11a guesschance12a, before(guesschance1a)
/// variables with all
tab1 guesschance1a-guesschance14a, mis
label define guess 0 "No chance" 1 "Very little chance" 2 "Some chance" 3 "Very good chance"
foreach var of varlist guesschance1a-guesschance14a {
recode `var' 1=0 2=2 3=3 4=1
label values `var' guess
}
tab1 guesschance1a-guesschance14a
tab1 guesschance1a guesschance1
/// without nochance:11, 12 
tab1 guesschance11a-guesschance12a
foreach var of varlist guesschance11a-guesschance12a {
recode `var' 1=2 2=3 3=1
label values `var' guess
}
tab1 guesschance11a-guesschance12a guesschance11-guesschance12
order guesschance1a-guesschance10a guesschance11a-guesschance12a guesschance13a-guesschance14a, before( politicalscalesq001)
drop guesschance1-guesschance14


tab1 politicalscalesq001
encode politicalscalesq001, gen(political)
tab1 political
label define polit 0 "Not sure" 1 "Extremely liberal" 2 "Liberal" 3 "Slightly liberal" 4 "Moderate" 5 "Slightly conservative" 6 "Conservative" 7 "Extremely conservative"
recode political 1=6 2=7 3=1 4=2 5=4 6=0 7=5 8=3
label values political polit
tab1 politicalscalesq001 political, mis
order political, before(deathpenalty)
drop politicalscalesq001

tab1 deathpenalty, mis
encode deathpenalty, gen(deathpen)
tab1 deathpen deathpenalty, nolabel
order deathpen, before(marijuanalegal)
drop deathpenalty

tab1 marijuanalegal, mis
encode marijuanalegal, gen(marijuana)
recode marijuana 2=3 3=2
label define marijuanal 1 "Legal" 2 "Not Sure" 3 "Not Legal"
label values marijuana marijuanal
tab1 marijuanalegal marijuana
order marijuana, before(abortionlegal)
drop marijuanalegal

tab1 abortionlegal, mis
encode abortionlegal, gen(abortion)
label define abort 1 "By law, abortion should never be permitted" 2 "Law should permit only in rape, incest, or woman's life in danger" 3 "Law should permited in other cases, but only after need is established" 4 "By law, should always be able to obtain abortion" 5 "Not sure"
recode abortion 1=4 2=1 3=5 4=3 5=2
label values  abortion abort
tab1 abortionlegal abortion, mis
order abortion, before(homosexual)
drop abortionlegal

tab1 homosexual  premaritalsex, mis
order homosexual, before(premaritalsex)
foreach var of varlist homosexual-premaritalsex {
encode `var', generate(`var'1)
}
tab1 homosexual1-premaritalsex1
label define homopre 1 "Always wrong" 2 "Almost always wrong" 3 "Sometimes wrong" 4 "Not wrong at all" 5 "Not sure"
foreach var of varlist homosexual1-premaritalsex1 {
recode `var' 1=2 2=1 3=5 4=4 5=3
label values `var' homopre
}
tab1 homosexual1-premaritalsex1 homosexual-premaritalsex
order homosexual1-premaritalsex1, before(drendlife)
drop homosexual-premaritalsex


tab1 homomarriage, mis
encode homomarriage, gen(gaymarriage)
label define gaymar 0 "Not Sure" 1 "Strongly diisagree" 2 "Disagree" 3 "Neither agree nor disagree" 4 "Agree" 5 "Strongly agree"
recode gaymarriage 1=4 2=2 3=3 4=0 5=5 6=1
label values gaymarriage gaymar
tab1 homomarriage gaymarriage, mis
order gaymarriage, before(premaritalsex1)
drop homomarriage


tab1 drendlife, mis
encode drendlife, gen(euthanasia)
tab1 drendlife euthanasia, nolabel
order euthanasia, before(fswelfare)
drop drendlife


tab1 fswelfare-fssocsec
foreach var of varlist fswelfare-fssocsec {
encode `var', gen(`var'1)
}
label define spending 0 "Not sure" 1 "Decrease" 2 "Be kept the same" 3 "Increase"
foreach var of varlist fswelfare1-fssocsec1 {
recode `var' 1=2 2=1 3=3 4=0
label values `var' spending
}
tab1 fswelfare1-fssocsec1 fswelfare-fssocsec, mis
order fswelfare1-fssocsec1, before(healthins1)
drop fswelfare-fssocsec


tab1 healthins1
encode healthins1, gen(healthins)
label drop healthins
label define healthins 1 "Govt. Insurance Plan" 7 "Private Insurance Plan"
recode healthins 1=2 2=3 3=4 4=5 5=6 6=1 7=. 8=7
label value healthins healthins
tab1 healthins1 healthins, mis
order healthins, before(jobguar1)
drop healthins1


tab1 jobguar1
encode jobguar1, gen(jobguar)
label drop jobguar
label define jobguar 1 "Govt. See to Job/Living" 7 "Each Person on Own"
recode jobguar 1=2 2=3 3=4 4=5 5=6 6=7 7=1 8=.
label value jobguar jobguar
tab1 jobguar1 jobguar, mis
order jobguar, before(govnservicessq001)
drop jobguar1


tab1 govnservicessq001
encode govnservicessq001, gen(govnservices)
label drop govnservices
label define govnservices 1 "Cut Services/Spending" 7 "More Services/Spending"
recode govnservices 1=2 2=3 3=4 4=5 5=6 6=1 7=7 8=.
label value govnservices govnservices
tab1 govnservicessq001 govnservices, mis
order govnservices, before(toomucheqrights)
drop govnservicessq001


tab1 toomucheqrights-lesseq
foreach var of varlist toomucheqrights-lesseq {
encode `var', gen(`var'1)
}
label define likert 0 "Not Sure" 1 "Strongly diisagree" 2 "Disagree" 3 "Neither agree nor disagree" 4 "Agree" 5 "Strongly agree"
foreach var of varlist toomucheqrights1-lesseq1 {
recode `var' 1=4 2=2 3=3 4=0 5=5 6=1
label values `var' likert
}
tab1 toomucheqrights1 toomucheqrights, mis
order toomucheqrights1-lesseq1, before(discriminationrace)
drop toomucheqrights-lesseq


tab1 discriminationrace
encode discriminationrace, gen(racediscrim)
label define racediscrim1 0 "Not sure" 1 "Strongly oppose" 2 "Oppose" 3 "Favor" 4 "Strongly favor"
recode racediscrim 1=3 2=0 3=2 4=4 5=1
label values racediscrim racediscrim1
tab1 discriminationrace racediscrim, mis
order racediscrim, before(musicpref1)
drop discriminationrace


tab1 musicpref1-musicpref22, mis
foreach var of varlist musicpref1-musicpref22 {
encode `var', gen(`var'a)
}
label define noyes 0 "No" 1 "Yes"
foreach var of varlist musicpref1a-musicpref22a {
recode `var' 1=0 2=1
label values `var' noyes
}
tab1 musicpref1 musicpref1a, mis nolabel
order musicpref1a-musicpref22a, before(musicprefother)
drop musicpref1-musicpref22


tab1 culturalevents1-culturalevents12
foreach var of varlist culturalevents1-culturalevents12 {
encode `var', gen(`var'a)
}
foreach var of varlist culturalevents1a-culturalevents12a {
recode `var' 1=0 2=1
label values `var' noyes
}
tab1 culturalevents1 culturalevents1a,  mis
order culturalevents1a-culturalevents12a, before(booksread)
drop culturalevents1-culturalevents12


tab1 typebookread1-typebookread9
foreach var of varlist typebookread1-typebookread9 {
encode `var', gen(`var'a)
}
foreach var of varlist typebookread1a-typebookread9a {
recode `var' 1=0 2=1
label values `var' noyes
}
tab1 typebookread1a typebookread1, nolabel mis
order typebookread1a-typebookread9a, before(typebookreadother)
drop typebookread1-typebookread9


tab1 musiccollection
encode musiccollection, gen(music)
label define musicc 0 "None" 1 "1-99" 2 "100-499" 3 "500-999" 4 "1000-4999" 5 "5000-9999" 6 "10000 or more"
recode music 1=4 2=6 3=2 4=5 5=3 6=1 7=0
label values music musicc
tab1 musiccollection music, mis
order music, before(landmarkssq001)
drop musiccollection
rename music musiccollection


tab1 outus
encode outus, gen(outus1)
recode outus1 1=. 2=0 3=1
tab1 outus1, nolabel mis
label values outus1 noyes
tab1 outus outus1, mis 
order outus1, before(whereoutussq001)
drop outus


tab1 whereoutussq001-whereoutussq011
foreach var of varlist whereoutussq001-whereoutussq011 {
encode `var', gen(`var'a)
}
foreach var of varlist whereoutussq001a-whereoutussq011a {
recode `var' 1=0 2=1
label values `var' noyes
}
tab1 whereoutussq001a whereoutussq001, nolabel mis
order whereoutussq001a-whereoutussq011a, before(whereoutusother)
drop whereoutussq001-whereoutussq011

 
tab1 interestitemssq001-interestitemssq006
/// all the same but the first and last so I'm starting with 2-5
foreach var of varlist  interestitemssq002-interestitemssq005 {
encode `var', gen(`var'a)
}
label define interest 0 "Not Sure" 1 "Not at all" 2 "Not that much" 3 "Somewhat" 4 "Very Much"
foreach var of varlist interestitemssq002a-interestitemssq005a {
label values `var' interest
}
tab1 interestitemssq002 interestitemssq002a, mis
/// 1 and 6 now
order interestitemssq001 interestitemssq006, before(interestitemssq002)
foreach var of varlist interestitemssq001-interestitemssq006 {
encode `var', gen(`var'a)
}
tab1 interestitemssq001a-interestitemssq006a, mis
foreach var of varlist interestitemssq001a-interestitemssq006a {
recode `var' 1=0
label values `var' interest
}
tab1 interestitemssq001-interestitemssq006 interestitemssq001a-interestitemssq006a, mis nolabel
order interestitemssq001a interestitemssq002a-interestitemssq005a interestitemssq006a, before(cell)
drop interestitemssq001-interestitemssq006
drop interestitemssq002-interestitemssq005


tab1 cell
encode cell, gen(cellular)
recode cellular 1=. 2=0 3=1
label values cellular noyes
tab1 cell cellular, mis
order cellular, before(maker)
drop cell


tab1 planpurchasingsq001-planpurchasingsq008
foreach var of varlist planpurchasingsq001-planpurchasingsq008 {
encode `var', gen(`var'a)
}
foreach var of varlist planpurchasingsq001a-planpurchasingsq008a {
recode `var' 1=0 2=1
label values `var' noyes
}
tab1 planpurchasingsq001 planpurchasingsq001a, nolabel mis
order planpurchasingsq001a-planpurchasingsq008a,  before(computerusesq001)
drop planpurchasingsq001-planpurchasingsq008


tab1 program
encode program, gen(program1)
recode program1 1=. 2=0 3=1
label values program1 noyes
tab1 program program1, mis nolabel
order program1, before(programwhichsq001)
drop program


tab1 programwhichsq001-programwhichsq011
/// 6, 8, 11 all are no, but will all be 1 so no big deal
foreach var of varlist programwhichsq001-programwhichsq011 {
encode `var', gen(`var'a)
}
foreach var of varlist programwhichsq001a-programwhichsq011a {
recode `var' 1=0 2=1
label values `var' noyes
}
tab1 programwhichsq001 programwhichsq001a programwhichsq006a programwhichsq006, nolabel mis
order programwhichsq001a-programwhichsq011a, before(programwhichother)
drop programwhichsq001-programwhichsq011


tab1 usefacebooksq001-usefacebooksq008
foreach var of varlist usefacebooksq001-usefacebooksq008 {
encode `var', gen(`var'a)
}
foreach var of varlist usefacebooksq001a-usefacebooksq008a {
recode `var' 1=0 2=1
label values `var' noyes
}
tab1 usefacebooksq001a usefacebooksq001, nolabel mis
order usefacebooksq001a-usefacebooksq008a, before(usefacebookother)
drop usefacebooksq001-usefacebooksq008


tab1 privacyfacebook
encode privacyfacebook, gen(fbprivacy)
label define facebook 1 "No one can see my posts unless I say otherwise" 2 "Only some of my friends can see my posts" 3 "All my friends can see my posts" 4 "My posts on Facebook are public"
recode fbprivacy 1=3 2=4 3=1 4=2
label values fbprivacy facebook
tab1 privacyfacebook fbprivacy, mis
order fbprivacy, before(activityfun01)
drop privacyfacebook


tab1 activityfun01-activityfun11
/// Has all 8: All but 2
/// Missing once a month or less: 2
order activityfun02, before(activityfun01)
foreach var of varlist activityfun01-activityfun11 {
encode `var', gen(`var'a)
}
label define act 1 "Cell lacks ability" 2 "Don't use function" 3 "Once a month or less" 4 "A few times a month" 5 "A few times a week" 6 "About once a day" 7 "A few times a day" 8 "Throughout most of the day" 
foreach var of varlist activityfun01a-activityfun11a {
recode `var' 1=7 2=4 3=5 4=6 5=1 6=2 7=2 8=8
label values `var' act
}
tab1 activityfun01 activityfun01a, mis 
/// for 2
tab1 activityfun02
encode activityfun02, gen(activityfun02a)
recode activityfun02a 1=7 2=4 3=5 4=6 5=1 6=2 7=8
label values activityfun02a act
tab1 activityfun02 activityfun02a
order activityfun02a, before(activityfun03a)
order activityfun01a-activityfun11a, before(talk)
order activityfun02, before(activityfun03)
drop activityfun01-activityfun11


tab1 englishnative
encode englishnative, gen(engnative)
recode engnative 1=. 2=0 3=1
label values engnative noyes
tab1 englishnative engnative, mis
order engnative, before(citizenship)
drop englishnative


tab1 citizenship
encode citizenship, gen(citizen)
label define citizenl 1 "US Citizen" 2 "Permanent Resident (green card)" 3 "Neither"
recode citizen 1=3 2=2 3=1
label values citizen citizenl
tab1 citizenship citizen, mis nolabel
order citizen, before(parentsmarriage)
drop citizenship


tab1 parentsmarriage
encode parentsmarriage, gen(pmarriage)
label define marriage 1 "Alive and living together" 2 "Alive, but divorced or living apart" 3 "One of them deceased" 4 "Both deceased"
recode pmarriage 1=1 2=2 3=3
label values pmarriage marriage
tab1 parentsmarriage pmarriage, mis
order pmarriage, before(parentsincome)
drop parentsmarriage
rename pmarriage parentsmarriage



tab1 parentsincome
encode parentsincome, gen(pincome)
label define parentsincome 1 "less than 10k" 2 "10000-14999" 3 "15000-19999" 4 "20000-24999" 5 "25000-29999" 6 "30000-39999" 7 "40000-49999" 8 "50000-59999" 9 "60000-74999" 10 "75000-99999" 11 "100000-149999" 12 "150000-199999" 13 "200000-249999" 14 "250000 or more" -1 "Not sure"
recode pincome 1=2 2=11 3=3 4=12 5=4 6=13 7=5 8=14 9=6 10=7 11=8 12=9 13=10 14=-1 15=1
label values pincome parentsincome
tab1 parentsincome pincome, mis 
order pincome, before(leveledu1)
drop parentsincome


tab1 leveledu1-leveledu2
encode leveledu1, gen(momed)
label define ed 1 "Junior High/middle school or less" 2 "Some high school" 3 "High school Graduate" 4 "Postsecondary school other than college" 5 "Some college" 6 "College Degree" 7 "Some graduate school" 8 "Graduate degree" -1 "Not sure" 
recode momed 1=6 2=8 3=3 4=-1 5=4 6=5 7=7 8=2
label values momed ed
tab1 leveledu1 momed, mis
tab1 leveledu2, mis
encode leveledu2, gen(daded)
recode daded 1=6 2=8 3=3 4=1 5=-1 6=4 7=5 8=7 9=2
label values daded ed
tab1 leveledu2 daded, mis
order momed-daded, before(occupations1)
drop leveledu1-leveledu2


tab1 religiouspref1-religiouspref3
/// all different
label define religious 1 "Baptist" 2 "Buddhist" 3 "Church of Christ" 4 "Eastern Orthodox" 5 "Episcopalian" 6 "Hindu" 7 "Jewish" 8 "LDS (Mormon)" 9 "Lutheran" 10 "Methodist" 11 "Muslim" 12 "Presbyterian" 13 "Quaker" 14 "Roman Catholic" 15 "7th Day Adventist" 16 "United Church of Crhist/Congregational" 17 "Other Christian" 18 "Other religion" 19 "Atheist" 20 "Agnostic" 21 "None" 22 "Not Sure" 23 "Not applicable"
encode religiouspref1, gen (momrelig)
recode momrelig 1=20 2=19 3=1 4=2 5=6 6=7 7=8 8=9 9=10 10=21 11=23 12=22 13=17 14=12 15=14 16=16
label values momrelig religious
tab1 religiouspref1 momrelig, mis
tab1 religiouspref2
encode religiouspref2, gen (dadrelig)
recode dadrelig 1=20 2=19 3=1 4=2 5=3 6=4 7=5 8=6 9=8 10=9 11=10 12=11 13=21 14=23 15=22 16=17 17=12 18=14 19=16
label values dadrelig religious
tab1 religiouspref2 dadrelig, mis
tab1 religiouspref3, mis
encode religiouspref3, gen (selfrelig)
recode selfrelig 1=20 2=19 3=1 4=3 5=6 6=7 7=10 8=21 9=23 10=22 11=17 12=12 13=14 14=16
label values selfrelig religious
tab1 religiouspref3 selfrelig, mis
order momrelig-selfrelig, before(militarystatus)
drop religiouspref1-religiouspref3


//Putting Religion into Categories!//
gen religcateg=selfrelig
label define rcategories 1 "Roman Catholic" 2 "Other" 3 "None"
recode religcateg 1=2 3=2 6=2 7=2 10=2 12=2 14=1 16=2 17=2 19=3 20=3 21=3 22=3 23=3
label values religcateg rcategories
tab1 religcateg
order religcateg, after(selfrelig)


tab1 militarystatus
encode militarystatus, gen(military)
label define rotc 0 "None" 1 "ROTC, Cadet, or misdhipman at a service academy"
recode military 1=0 2=1
label values military rotc
tab1 militarystatus military, mis
order military, before(familymilitary)
drop militarystatus


tab1 familymilitary-closemilitary
foreach var of varlist familymilitary-closemilitary {
encode `var', gen(`var'1)
}
foreach var of varlist familymilitary1-closemilitary1 {
recode `var' 1=. 2=0 3=1
label values `var' noyes
}
tab1 familymilitary-closemilitary familymilitary1-closemilitary1, mis
order familymilitary1-closemilitary1, before(firstname)
drop familymilitary-closemilitary


//Cellphone Maker and related questions
tab1 maker
encode maker, gen (makerx)
label define phone 1 "Apple" 2 "Blackberry" 3 "HTC" 4 "LG" 5 "Motorola" 6 "Nokia" 7 "Palm" 8 "Pantech" 9 "Samsung" 10 "Sanyo" 11 "Sony Ericsson" 12 "Don't Know" 13 "Other"
recode makerx 1=1 2=2 3=12 4=3 5=4 6=5 7=6 8=13 9=7 10=8 11=9 12=10 13=11
label values makerx phone
tab1 makerx 
tab1 maker
drop maker
rename makerx phonemaker
order phonemaker, after(cellular)

tab1 period
encode period, gen (periodx)
label define phonetime 1 "Less than three months" 2 "More than three months but less than six months" 3 "More than six months but less than a year" 4 "More than a year but less than two years" 5 "More than two years" 
recode periodx 1=1 2=4 3=3 4=2 5=5
label values periodx phonetime
tab1 period periodx, mis
drop period
rename periodx period
order period, after (model)

tab1 carrier
encode carrier, gen (carrierx)
label define phonecarrier 1 "AT&T (formerly Cingular)" 2 "Sprint-Nextel" 3 "T-mobile" 4 "Verizon Wireless" 5 "Other"
recode carrierx 1=1 2=5 3=2 4=3 5=4
label values carrierx phonecarrier
tab1 carrier carrierx, mis
drop carrier
rename carrierx carrier
order carrier, after (period)


//Professions
tab1 occupations1-occupations3
foreach v of varlist occupations1-occupations3 {
encode `v', gen(`v'x)
}
label define work 1 "Accountant or actuary" 2 "Actor or entertainer" 3 "Architect or urban planner" 4 "Artist" 5 "Business(clerical)" 6 "Business executive(management, administrator" 7 "Business owner or proprietor" 8 "Business salesperson or buyer" 9 "Clergy(minister, priest)" 10 "Clergy(other religious)" 11 "Clinical psychologist" 12 "College administrator/staff" 13 "College teacher" 14 "Computer programmer or analyst" 15 "Conservationest or forester" 16 "Dentists(including orthodontist)" 17 "Dietitian or nutritionist" 18 "Engineer" 19 "Farmer or rancher" 20 "Foreign service worker(including diplomat)" 21 "Homemaker(full-time)" 22 "Interior decorator(including designer)" 23 "Lab technician or hygienist" 24 "Law enforcement officer" 25 "Lawyer(attorney) or judge" 26 "Military service(career)" 27 "Nurse" 28 "Optometrist" 29 "Pharmacist" 30 "Physician" 31 "Policymaker/government" 32 "School counselor" 33 "School principal or superintendent" 34 "Scientific researcher" 35 "Social, welfare, or recreation worker" 36 "Therapist(physical, occupational, speech)" 37 "Teacher or administrator(elementary)" 38 "Teacher or administrator(secondary)" 39 "Veterinarian" 40 "Writer or journalist" 41 "Skilled trades" 42 "Laborer(unskilled)" 43 "Unemployed" 44 "Other" 45 "Undecided" 46 "Not sure" 47 "Not applicable"

recode occupations1x 1=1 2=3 3=5 4=6 5=7 6=8 7=11 8=12 9=13 10=14 11=16 12=18 13=20 14=21 15=42 16=47 17=46 18=27 19=44 20=29 21=30 22=31 23=32 24=34 25=41 26=38 27=37 28=36 29=43 30=40 
label values occupations1x work
tab1 occupations1x
order occupations1x, after(occupations1)
drop occupations1
rename occupations1x occupationmom

recode occupations2x 1=1 2=3 3=5 4=6 5=7 6=8 7=10 8=11 9=14 10=16 11=18 12=19 13=20 14=21 15=23 16=42 17=24 18=25 19=26 20=47 21=46 22=44 23=30 24=31 25=33 26=41 27=35 28=38 29=43 30=40 
label values occupations2x work
tab1 occupations2x
order occupations2x, after(occupations2)
drop occupations2
rename occupations2x occupationdad

recode occupations3x 1=1 2=6 3=7 4=8 5=11 6=13 7=14 8=18 9=20 10=42 11=25 12=47 13=46 14=44 15=30 16=31 17=34 18=41 19=35 20=38 21=37 22=36 23=45 
label values occupations3x work
tab1 occupations3x
order occupations3x, after(occupations3)
drop occupations3
rename occupations3 occupationstudent


label variable studyid "Id (Mapped from Phone Number 12_5)"
label variable deathpen "Do you favor or oppose the death penalty for persons convicted of murder? (Q27)"
label variable marijuana "Do you think the use of marijuana should be made legal or not? (Q28)"
label variable abortion "Which agrees with view of abortion? (Q29)"
label variable homosexual1 "Thoughts about consensual sexual relations between 2 adults of same same sex Q30"
label variable gaymarriage "Do you agree homosexual couples have right to marry? Q31 "
label variable premaritalsex1 "Thoughts about premarital sex Q32"
label variable euthanasia "Should euthanasia be allowed? Q33"
label variable fswelfare1 "Do you think federal speding on welfare should... Q34"
label variable fssocsec1 "Do you think federal spending on social security should... Q35"
label variable healthins "Health Insurance: Govt Insurance=1 Private Insurance=7 Q36"
label variable jobguar "Job Guarantee: Govt. See to Job/Living=1 Each person on own=7 Q37"
label variable govnservices "Govt Services/Spending: 1=Cut 7=Increase Q38"
label variable toomucheqrights1 "We have gone too far in pushing equal rights in this country Q39"
label variable eqchances1 "One of the big problems in country is not all have equal chance Q40"
label variable moreeqchances1 "Not really a big problem if some ppl have more chance in life than others Q41"
label variable lesseq1 "Country would be better off if we worried less about how equal ppl are Q42"
label variable racediscrim "Do you favor favor preferential hiring and promotion of Blacks Q43"

label variable dropped "1=dropped"
label variable age "Age"
label variable hometown "Hometown distance"
label variable ethnicity "Ethnicity"
label variable gender "Gender"
label variable highestdegree "What is the highest academic degree you intended to obtain? Q6"
label variable apcourses1 "How many AP courses did you take in HS? Q5"
label variable apcourses2 "How many AP exams did you take in HS?Q5"
label variable hsgrade "What was your average grade in HS? Q4"
label variable hsgender "Gender makeup of High School Q3"
label variable hstype "Type of high school graduated from Q2"
label variable hstypeother "Type.highschool [other] Q2"
label variable major "Probable Undergrad major Q7"
label variable hswork "During senior year, hour/wk worked for pay Q8"
label variable clubsclu011 "Clubs: Language Club Q9"
label variable clubsclu021 "Clubs: Book Club Q9"
label variable clubsclu031 "Clubs: Computer Club Q9"
label variable clubsclu041 "Clubs: Debate Team Q9"
label variable clubsclu051 "Clubs: Theatre/Drama Club Q9"
label variable clubsclu061 "Clubs: Future Farmers of America Q9"
label variable clubsclu071 "Clubs: History Club Q9"
label variable clubsclu081 "Clubs: Math Club Q9"
label variable clubsclu091 "Clubs: Science Club Q9"
label variable clubsclu101 "Clubs: Business Club Q9"
label variable clubsclu111 "Clubs: Community Service Club Q9"
label variable clubsclu121 "Clubs: Band Q9"
label variable clubsclu131 "Clubs: Cheerleading/Dance team Q9"
label variable clubsclu141 "Clubs: Chorus or choir Q9"
label variable clubsclu151 "Clubs: Orchestra Q9"
label variable clubsclu161 "Clubs: Other Club or organization Q9"
label variable clubsclu171 "Clubs: Basketball/Softball Q9"
label variable clubsclu181 "Clubs: Basketball Q9"
//clean up the spacing later
. label variable clubsclu191 "Clubs: Field Hockey Q9"

. label variable clubsclu201 "Clubs: Football Q9"

. label variable clubsclu211 "Clubs: Ice Hockey Q9"

. label variable clubsclu221 "Clubs: Lacrosse Q9"

. label variable clubsclu231 "Clubs: Soccer Q9"

. label variable clubsclu241 "Clubs: Swimming Q9"

. label variable clubsclu251 "Clubs: Tennis Q9"

. label variable clubsclu261 "Clubs: Track Q9"

. label variable clubsclu271 "Clubs: Volleyball Q9"

. label variable clubsclu281 "Clubs: Wrestling Q9"

. label variable clubsclu291 "Clubs: Other sport team Q9"

. label variable clubsclu301 "Clubs: Newspaper Q9"

. label variable clubsclu311 "Clubs: Honor Society Q9"

. label variable clubsclu321 "Clubs: Student Council Q9"

. label variable clubsclu331 "Clubs: Yearbook Q9"

. label variable clubsclu341 "Clubs: Arts/Literature Club Q9"

. label variable clubsother "Clubs: Other/Please Specify Q9"

. label variable relativesndrend11 "Parent Attended ND Q10"

. label variable relativesndrend21 "Grandparent Attended ND Q10"

. label variable relativesndrend31 "Brother or sister attended ND Q10"

. label variable relativesndrend41 "Uncle or aunt attended ND Q10"

. label variable relativesndrend51 "Cousin attended ND Q10"

. label variable relativesndother "Other Attended ND Q10"

. label variable relativesndrend11 "Parent Attended ND Q10"

. label variable relativesndrend21 "Grandparent Attended ND Q10"

. label variable relativesndrend31 "Brother or sister attended ND Q10"

. label variable relativesndrend41 "Uncle or aunt attended ND Q10"

. label variable relativesndrend51 "Cousin attended ND Q10"

. label variable relativesndother "Other Attended ND Q10"

. label variable wellbeing1 "In last two weeks: Felt cheerful and in good spirits Q12"

. label variable wellbeing2 "In last two weeks: Felt calm and relaxed Q12"

. label variable wellbeing3 "In last two weeks: Felt active and vigorous Q12"

. label variable wellbeing4 "In last two weeks: Woke up feeling fresh and rested Q12"

. label variable wellbeing5 "In last two weeks: Daily life filled with things that interest me Q12"



. label variable iamsomeonewho1a "I am someone who is talkative Q13"

. label variable iamsomeonewho2a "I am someone who tends to find fault with others Q13"

. label variable iamsomeonewho3a "I am someone who does a thorough job Q13"

. label variable iamsomeonewho4a "I am someone who is depressed, blue Q13"

. label variable iamsomeonewho5a "I am someone who is original, comes up with new ideas Q13"

. label variable iamsomeonewho6a "I am someone who is reserved Q13"

. label variable iamsomeonewho7a "I am someone who is helpful and unselfish with others Q13"

. label variable iamsomeonewho8a "I am someone who can be somewhat careless Q13"

. label variable iamsomeonewho9a "I am someone who is relaxed, handles stress well Q13"

. label variable iamsomeonewho10a "I am someone who is curious about many different things Q13"

. label variable iamsomeonewho11a "I am someone who is full of energy Q13"

. label variable iamsomeonewho12a "I am someone who starts quarrels with others Q13"

. label variable iamsomeonewho13a "I am someone who is a reliable worker Q13"

. label variable iamsomeonewho14a "I am someone who can be tense Q13"

. label variable iamsomeonewho15a "I am someone who is ingenious, a deep thinker Q13"

. label variable iamsomeonewho16a "I am someone who generates a lot of enthusiasm Q13"

. label variable iamsomeonewho17a "I am someone who has a forgiving nature Q13"

. label variable iamsomeonewho18a "I am someone who tends to be disorganized Q13"

. label variable iamsomeonewho19a "I am someone who worries a lot Q13"

. label variable iamsomeonewho20a "I am someone whohas an active imagination Q13"

. label variable iamsomeonewho21a "I am someone who tends to be quiet Q13"

. label variable iamsomeonewho22a "I am someone who is generally trusting Q13"

. label variable iamsomeonewho23a "I am someone who tends to be lazy Q13"

. label variable iamsomeonewho24a "I am someone who is emotionally stable, not easily upset Q13"

. label variable iamsomeonewho25a "I am someone who is inventive Q13"

. label variable iamsomeonewho26a "I am someone who has an assertive personality Q13"

. label variable iamsomeonewho27a "I am someone who can be cold and aloof Q13"

. label variable iamsomeonewho28a "I am someone who perseveres until the task is finished Q13"

. label variable iamsomeonewho29a "I am someone who can be moody Q13"

. label variable iamsomeonewho30a "I am someone who values artistic, aesthetic experiences Q13"

. label variable iamsomeonewho31a "I am someone who is sometimes shy, inhibited Q13"

. label variable iamsomeonewho32a "I am someone who is considerate and kind to almost everyone Q13"

. label variable iamsomeonewho33a "I am someone who does things efficiently Q13"

. label variable iamsomeonewho34a "I am someone who remains calm in tense situations Q13"

. label variable iamsomeonewho35a "I am someone who Prefers work that is routine Q13"

. label variable iamsomeonewho36a "I am someone who is outgoing, sociable Q13"

. label variable iamsomeonewho37a "I am someone who is sometimes rude to others Q13"

. label variable iamsomeonewho38a "I am someone who makes plans and follows through with them Q13"

. label variable iamsomeonewho39a "I am someone who gets nervous easily Q13"

. label variable iamsomeonewho40a "I am someone who likes to reflect, play with ideas Q13"

. label variable iamsomeonewho41a "I am someone who has few artistic interests Q13"

. label variable iamsomeonewho42a "I am someone who likes to cooperate with others Q13"

. label variable iamsomeonewho43a "I am someone who is easily distracted Q13"

. label variable iamsomeonewho44a "I am someone who is sophisticated in art, music, or literature Q13"

. label variable weight "Weight in pounds Q16"
//height redone in terms of inches, a la Winter Survey-Margaret
. //label variable heightsq001 "Height in feet Q17"

. //label variable heightsq002 "Height inches pass the feet Q17"

. label variable eyeglasses1 "Do you wear glasses? Q18"

. label variable contactlens1 "Do you wear contact lenses? Q19"

. label variable disabilityphysical1 "Do you have a physical disability? Q20"

. label variable disabilitylearning1 "Do you have a learning disability? Q21"


. label variable activitypastyear1a "Past year: Attended a religious service Q22"

. label variable activitypastyear2a "Past year: Demonstrated for a cause Q22"

. label variable activitypastyear3a "Past year: Smoked a cigarette Q22"

. label variable activitypastyear4a "Past year: Drank beer Q22"

. label variable activitypastyear5a "Past year: Drank wine or liquor Q22"

. label variable activitypastyear6a "Past year: Exercised Q22"

. label variable activitypastyear7a "Past year: Felt overwhelmed by all I had to do Q22"

. label variable activitypastyear8a "Past year: Felt depressed Q22"

. label variable activitypastyear9a "Past year: Performed volunteer work Q22"

. label variable activitypastyear10a "Past year: Socialized with someone of another racial/ethnic group Q22"

. label variable activitypastyear11a "Past year: Discussed Religion Q22"

. label variable activitypastyear12a "Past year: Discussed politics Q22"

. label variable activitypastyear13a "Past year: Worked on a politcal campaign Q22"

. label variable activitypastyear14a "Past year: Publically communicated by opinion about a cause Q22"

. label variable highschoolactivitya1 "HS hours/wk: Studying/homework Q23"

. label variable highschoolactivityb1 "HS hours/wk: socializing with friends Q23"

. label variable highschoolactivityc1 "HS hours/wk: exercise or sports Q23"

. label variable highschoolactivityd1 "HS hours/wk: Partying Q23"

. label variable highschoolactivitye1 "HS hours/wk: Working for pay Q23"

. label variable highschoolactivityf1 "HS hours/wk: Volunteer work Q23"

. label variable highschoolactivityg1 "HS hours/wk: Student clubs/groups Q23"

. label variable highschoolactivityh1 "HS hours/wk: watching TV programs  Q23"

. label variable highschoolactivityi1 "HS hours/wk: Listening to Music Q23"

. label variable highschoolactivityj1 "HS hours/wk: Household/childcare duties Q23"

. label variable highschoolactivityk1 "HS hours/wk: Reading for pleasure Q23"

. label variable highschoolactivityl1 "HS hours/wk: Playing single player video/computer games Q23"

. label variable highschoolactivitym1 "HS hours/wk: Playing multiplayer video/computer games Q23"

. label variable highschoolactivityn1 "HS hours/wk: Online social networks  Q23"

. label variable importance1a "Importance: Becoming accomplished in performing arts Q24"

. label variable importance2a "Importance: Becoming an authority in my field  Q24"

. label variable importance3a "Importance: Obtaining recognition from colleagues for contributions Q24"

. label variable importance4a "Importance: Influencing the political structure Q24"

. label variable importance5a "Importance: Influencing social values Q24"

. label variable importance6a "Importance: Raising a family Q24"

. label variable importance7a "Importance: Being very well of financially Q24"

. label variable importance8a "Importance: Helping promote understanding between groups Q24"

. label variable importance9a "Importance: Making a theoretical contribution to science Q24"

. label variable importance10a "Importance: Writing original works Q24"

. label variable importance11a "Importance: Creating artistic works Q24"

. label variable importance12a "Importance: Becoming involved in programs to clean up environment Q24"

. label variable importance13a "Importance: Keeping up to date with political affairs Q24"

. label variable importance14a "Importance: Becoming a community leader Q24"

. label variable importance15a "Importance: Improving my understanding of other groups/cultures Q24"

. label variable importance16a "Importance: Adopting green practices to protect environment Q24"

. label variable guesschance1a "Chance you will: Change major field Q25"

. label variable guesschance2a "Chance you will: Change career choice Q25"

. label variable guesschance3a "Chance you will: Participate in student government Q25"

. label variable guesschance4a "Chance you will: Get a job to help pay college expenses Q25"

. label variable guesschance5a "Chance you will: Play club, intramural, or recreational sports Q25"

. label variable guesschance6a "Chance you will: Play intercollegiate athletics Q25"

. label variable guesschance7a "Chance you will: Participate in student protests or demonstrations Q25"

. label variable guesschance8a "Chance you will: Transfer to another college before graduating Q25"

. label variable guesschance9a "Chance you will: Participate in volunteer work Q25"

. label variable guesschance10a "Chance you will: Seek personal counseling Q25"

. label variable guesschance11a "Chance you will: Socialize with someone of another racial/ethnic group Q25"

. label variable guesschance12a "Chance you will: Participate in student clubs/groups  Q25"

. label variable guesschance13a "Chance you will: Participate in study abroad program Q25"

. label variable guesschance14a "Chance you will: Work on a professors research project Q25"

. label variable musicpref1a "Listen to: Big Band Q44"

. label variable musicpref2a "Listen to: Bluegrass Q44"

. label variable musicpref3a "Listen to: Blues or R&B Q44"

. label variable musicpref4a "Listen to: Broadway musicals or show tunes Q44"

. label variable musicpref5a "Listen to: Choral or glee club Q44"

. label variable musicpref6a "Listen to: Classic rock or oldies Q44"

. label variable musicpref7a "Listen to: Classical or chamber music Q44"

. label variable musicpref8a "Listen to: Country Q44"

. label variable musicpref9a "Listen to: Dance music Q44"

. label variable musicpref10a "Listen to: Ethnic or national Q44"

. label variable musicpref11a "Listen to: Folk music Q44"

. label variable musicpref12a "Listen to: Hymns or gospel music Q44"

. label variable musicpref13a "Listen to: Jazz Q44"

. label variable musicpref14a "Listen to: Latin, Spanish or salsa Q44"

. label variable musicpref15a "Listen to: Mood or easy listening Q44"

. label variable musicpref16a "Listen to: New age music Q44"

. label variable musicpref17a "Listen to: Opera Q44"

. label variable musicpref18a "Listen to: Operetta or musicals Q44"

. label variable musicpref19a "Listen to: Parade or marching band Q44"

. label variable musicpref20a "Listen to: Rap or hip-hop Q44"

. label variable musicpref21a "Listen to: Raggae Q44"

. label variable musicpref22a "Listen to: Rock or heavy metal Q44"

. label variable musicprefother "Listen to: Other- please specify Q44"

. label variable culturalevents1a "Cultural Events: Jazz performance Q45"

. label variable culturalevents2a "Cultural Events: Latin/Spanish/Salsa Q45"

. label variable culturalevents3a "Cultural Events: Classical music performance Q45"

. label variable culturalevents4a "Cultural Events: Opera Q45"

. label variable culturalevents5a "Cultural Events: Musical stage play Q45"

. label variable culturalevents6a "Cultural Events: Non-musical stage play Q45"

. label variable culturalevents7a "Cultural Events: Ballet/Dance Q45"

. label variable culturalevents8a "Cultural Events: Outdoor performance Q45"

. label variable culturalevents9a "Cultural Events: Art museum Q45"

. label variable culturalevents10a "Cultural Events: Science museum Q45"

. label variable culturalevents11a "Cultural Events: Other type of museum Q45"

. label variable culturalevents12a "Cultural Events: Craft fair/Arts festival Q45"

. label variable booksread "Books read in past year Q46"

. label variable typebookread1a "Type of book read: Mysteries Q47"

. label variable typebookread2a "Type of book read: Thrillers Q47"

. label variable typebookread3a "Type of book read: Romance Q47"

. label variable typebookread4a "Type of book read: Science fiction/Fantasy Q47"

. label variable typebookread5a "Type of book read: Other fiction Q47"

. label variable typebookread6a "Type of book read: Health/Fitness/Self-Improvement Q47"

. label variable typebookread7a "Type of book read: History/Political  Q47"

. label variable typebookread8a "Type of book read: Biographies/Memoirs Q47"

. label variable typebookread9a "Type of book read: Other non-fiction Q47"

. label variable typebookreadother "Type of book read: Other-please specify Q47"

. label variable musiccollection "How many songs are in your music collection? Q48"

. 
. label variable landmarkssq001 "Landmarks or place visited since age of 10:1 Q49"

. label variable landmarkssq002 "Landmarks or place visited since age of 10:2 Q49"

. label variable landmarkssq003 "Landmarks or place visited since age of 10:3 Q49"

. label variable landmarkssq004 "Landmarks or place visited since age of 10:4 Q49"

. label variable landmarkssq005 "Landmarks or place visited since age of 10:5 Q49"

. label variable outus1 "Have you been out of the US? Q50"

. label variable whereoutussq001a "Where out us: Mexico Q51"

. label variable whereoutussq002a "Where out us: Canada Q51"

. label variable whereoutussq003a "Where out us: Caribbean Q51"

. label variable whereoutussq004a "Where out us: Central America Q51"

. label variable whereoutussq005a "Where out us: Latin America Q51"

. label variable whereoutussq006a "Where out us: Europe Q51"

. label variable whereoutussq007a "Where out us: Middle East Q51"

. label variable whereoutussq008a "Where out us: Africa Q51"

. label variable whereoutussq009a "Where out us: Asia Q51"

. label variable whereoutussq010a "Where out us: Far east- China, Japan, etc Q51"

. label variable whereoutussq011a "Where out us: Australia/New Zealand Q51"

. label variable whereoutusother "Where out us: Other- Please specify Q51"


. label variable interestitemssq001a "Enjoy doing: Music Q53"

. label variable interestitemssq002a "Enjoy doing: Movies Q53"

. label variable interestitemssq003a "Enjoy doing: Books Q53"

. label variable interestitemssq004a "Enjoy doing: Following Sports Q53"

. label variable interestitemssq005a "Enjoy doing: Playing Games Q53"

. label variable interestitemssq006a "Enjoy doing: Outdoor activities Q53"

. label variable cellular "Do you use a cell phone Q54"

. label variable maker "Maker of current cell phone Q55"

. label variable model "Model of cell phone Q56"

. label variable period "How long have you been using your cell phone Q57"

. label variable carrier "Cell phone carrier Q58"

. label variable usagedegreesq001 "Degree of cell phone usage Q59"

. label variable planpurchasingsq001a "Own or plan on purchasing: Decktop computer Q60"

. label variable planpurchasingsq002a "Own or plan on purchasing: Lapton computer Q60"

. label variable planpurchasingsq003a "Own or plan on purchasing: iPad Q60"

. label variable planpurchasingsq004a "Own or plan on purchasing: Other tablet Q60"

. label variable planpurchasingsq005a "Own or plan on purchasing: Ebook reader Q60"

. label variable planpurchasingsq006a "Own or plan on purchasing: Mp3 player Q60"

. label variable planpurchasingsq007a "Own or plan on purchasing: Game system Q60"

. label variable planpurchasingsq008a "Own or plan on purchasing: TV Q60"

. label variable computerusesq001 "Degree of computer use Q61"

. label variable program1 "Know any computer languages Q62"

. label variable programwhichsq001a "Which Programing language: Java Q63"

. label variable programwhichsq002a "Which Programing language: C Q63"

. label variable programwhichsq003a "Which Programing language: C++ Q63"

. label variable programwhichsq004a "Which Programing language: PHP Q63"

. label variable programwhichsq005a "Which Programing language: Visual Basic Q63"

. label variable programwhichsq006a "Which Programing language: Perl Q63"

. label variable programwhichsq007a "Which Programing language: Python Q63"

. label variable programwhichsq008a "Which Programing language: C# Q63"

. label variable programwhichsq009a "Which Programing language: Ajax Q63"

. label variable programwhichsq010a "Which Programing language: JavaScript Q63"

. label variable programwhichsq011a "Which Programing language: Ruby Q63"

. label variable programwhichother "Which Programing language: Other-please specify  Q63"


. label variable usefacebooksq001a "Social Network Use: Facebook Q64"

. label variable usefacebooksq002a "Social Network Use: Twitter Q64"

. label variable usefacebooksq003a "Social Network Use: Google+ Q64"

. label variable usefacebooksq004a "Social Network Use: MySpace Q64"

. label variable usefacebooksq005a "Social Network Use: Spotify Q64"

. label variable usefacebooksq006a "Social Network Use: LindedIn Q64"

. label variable usefacebooksq007a "Social Network Use: Delicious Q64"

. label variable usefacebooksq008a "Social Network Use: Tumblr Q64"

. label variable usefacebookother "Social Network Use: Other- please specify Q64"

. label variable fbprivacy "Do you restrict who can see posts on Facebook? Q65"

. label variable activityfun01a "Cell Use: Make voice calls Q66"

. label variable activityfun02a "Cell Use: Sending texts Q66"

. label variable activityfun03a "Cell Use: Reading or sending emails Q66"

. label variable activityfun04a "Cell Use: Posting on Facebook or other networks Q66"

. label variable activityfun05a "Cell Use: Reading or sending tweets on twitter Q66"

. label variable activityfun06a "Cell Use: Shooting still pictures Q66"

. label variable activityfun07a "Cell Use: Taking videos Q66"

. label variable activityfun08a "Cell Use: Listening to music Q66"

. label variable activityfun09a "Cell Use: Viewing videos/TV Q66"

. label variable activityfun10a "Cell Use: Playing games Q66"

. label variable activityfun11a "Cell Use: Consulting a map or finding directions Q66"

. label variable talk "Minutes/Day talking on cell Q67"


 
. label variable sendsms "Texts/typical day Q68"

. label variable receivesms "Texts received/typical day Q69"

. label variable contacts "Number of contacts in phone Q70"

. label variable engnative "Is English your native language? Q71"

. label variable citizen "What is your citizenship status? Q72"

. label variable parentsmarriage "Parents marriage Q73"

. label variable pincome "Estimate of parents' total yearly income Q74"

. label variable momed "Mom's highest level of education Q75"

. label variable daded "Dad's highest level of education Q75"

. label variable occupationmom "Mother's Occupation Q76"

. label variable occupationdad "Dad's Occupation Q76"

. label variable occupationstudent "Respondents probable career Q76"

. label variable momrelig "Mom's Religious preference Q77"

. label variable dadrelig "Dad's Religious preference Q77"

. label variable selfrelig "Respondent's Religious preference Q77"

label variable phonemaker "Maker of current cell phone"
label variable period "How long have you been using your current cell phone?"
label variable carrier "Who is your cell phone carrier?"
 label variable military "What is your military status? Q78"

. label variable familymilitary1 "Family in the military Q79"

. label variable closemilitary "Non-Family know anyone fairly well in military? Q80"


//**RENAMING**//

/* Changing variables so they aren't annoying */

. rename clubsclu011 clubsclu01

. rename clubsclu021 clubsclu02

. rename clubsclu031 clubsclu03

. rename clubsclu041 clubsclu04

. rename clubsclu051 clubsclu05

. rename clubsclu061 clubsclu06

. rename clubsclu071 clubsclu07

. rename clubsclu081 clubsclu08

. rename clubsclu091 clubsclu09

. rename clubsclu101 clubsclu10

. rename clubsclu111 clubsclu11

. rename clubsclu121 clubsclu12

. rename clubsclu131 clubsclu13

. rename clubsclu141 clubsclu14

. rename clubsclu151 clubsclu15

. rename clubsclu161 clubsclu16

. rename clubsclu171 clubsclu17

. rename clubsclu181 clubsclu18

. rename clubsclu191 clubsclu19

. rename clubsclu201 clubsclu20

. rename clubsclu211 clubsclu21

. rename clubsclu221 clubsclu22

. rename clubsclu231 clubsclu23

. rename clubsclu241 clubsclu24

. rename clubsclu251 clubsclu25

. rename clubsclu261 clubsclu26

. rename clubsclu271 clubsclu27

. rename clubsclu281 clubsclu28

. rename clubsclu291 clubsclu29

. rename clubsclu301 clubsclu30

. rename clubsclu311 clubsclu31

. rename clubsclu321 clubsclu32

. rename clubsclu331 clubsclu33

. rename clubsclu341 clubsclu34

. rename relativesndrend11 relativesndrend1

. rename relativesndrend21 relativesndrend2

. rename relativesndrend31 relativesndrend3

. rename relativesndrend41 relativesndrend4

. rename relativesndrend51 relativesndrend5

. rename iamsomeonewho1a iamsomeonewho1

. rename iamsomeonewho2a iamsomeonewho2r

. rename iamsomeonewho3a iamsomeonewho3

. rename iamsomeonewho4a iamsomeonewho4

. rename iamsomeonewho5a iamsomeonewho5

. rename iamsomeonewho6a iamsomeonewho6r

. rename iamsomeonewho7a iamsomeonewho7

. rename iamsomeonewho8a iamsomeonewho8r

. rename iamsomeonewho9a iamsomeonewho9r

. rename iamsomeonewho10a iamsomeonewho10

. rename iamsomeonewho11a iamsomeonewho11

. rename iamsomeonewho12a iamsomeonewho12r

. rename iamsomeonewho13a iamsomeonewho13

. rename iamsomeonewho14a iamsomeonewho14

. rename iamsomeonewho15a iamsomeonewho15

. rename iamsomeonewho16a iamsomeonewho16

. rename iamsomeonewho17a iamsomeonewho17

. rename iamsomeonewho18a iamsomeonewho18r

. rename iamsomeonewho19a iamsomeonewho19

. rename iamsomeonewho20a iamsomeonewho20

. rename iamsomeonewho21a iamsomeonewho21r

. rename iamsomeonewho22a iamsomeonewho22

. rename iamsomeonewho23a iamsomeonewho23r

. rename iamsomeonewho24a iamsomeonewho24r

. rename iamsomeonewho25a iamsomeonewho25

. rename iamsomeonewho26a iamsomeonewho26

. rename iamsomeonewho27a iamsomeonewho27r

. rename iamsomeonewho28a iamsomeonewho28

. rename iamsomeonewho29a iamsomeonewho29

. rename iamsomeonewho30a iamsomeonewho30

. rename iamsomeonewho31a iamsomeonewho31r

. rename iamsomeonewho32a iamsomeonewho32

. rename iamsomeonewho33a iamsomeonewho33

. rename iamsomeonewho34a iamsomeonewho34r

. rename iamsomeonewho35a iamsomeonewho35r

. rename iamsomeonewho36a iamsomeonewho36

. rename iamsomeonewho37a iamsomeonewho37r

. rename iamsomeonewho38a iamsomeonewho38

. rename iamsomeonewho39a iamsomeonewho39

. rename iamsomeonewho40a iamsomeonewho40

. rename iamsomeonewho41a iamsomeonewho41r

. rename iamsomeonewho42a iamsomeonewho42

. rename iamsomeonewho43a iamsomeonewho43r

. rename iamsomeonewho44a iamsomeonewho44


. rename eyeglasses1 eyeglasses

. rename contactlens1 contactlens

. rename disabilityphysical1 disabilityphysical

. rename disabilitylearning1 disabilitylearning

. rename activitypastyear1a activitypastyear1

. rename activitypastyear2a activitypastyear2

. rename activitypastyear3a activitypastyear3

. rename activitypastyear4a activitypastyear4

. rename activitypastyear5a activitypastyear5

. rename activitypastyear6a activitypastyear6

. rename activitypastyear7a activitypastyear7

. rename activitypastyear8a activitypastyear8

. rename activitypastyear9a activitypastyear9

. rename activitypastyear10a activitypastyear10

. rename activitypastyear11a activitypastyear11

. rename activitypastyear12a activitypastyear12

. rename activitypastyear13a activitypastyear13

. rename activitypastyear14a activitypastyear14

. rename highschoolactivitya1 highschoolactivitya

. rename highschoolactivityb1 highschoolactivityb

. rename highschoolactivityc1 highschoolactivityc

. rename highschoolactivityd1 highschoolactivityd

. rename highschoolactivitye1 highschoolactivitye

. rename highschoolactivityf1 highschoolactivityf

. rename highschoolactivityg1 highschoolactivityg

. rename highschoolactivityh1 highschoolactivityh

. rename highschoolactivityi1 highschoolactivityi

. rename highschoolactivityj1 highschoolactivityj

. rename highschoolactivityk1 highschoolactivityk

. rename highschoolactivityl1 highschoolactivityl

. rename highschoolactivitym1 highschoolactivitym

. rename highschoolactivityn1 highschoolactivityn

. rename importance1a importance1

. rename importance2a importance2

. rename importance3a importance3

. rename importance4a importance4

. rename importance5a importance5

. rename importance6a importance6

. rename importance7a importance7

. rename importance8a importance8

. rename importance9a importance9

. rename importance10a importance10

. rename importance11a importance11

. rename importance12a importance12

. rename importance13a importance13

. rename importance14a importance14

. rename importance15a importance15

. rename importance16a importance16

. rename guesschance1a guesschance1

. rename guesschance2a guesschance2

. rename guesschance3a guesschance3

. rename guesschance4a guesschance4

. rename guesschance5a guesschance5

. rename guesschance6a guesschance6

. rename guesschance7a guesschance7

. rename guesschance8a guesschance8

. rename guesschance9a guesschance9

. rename guesschance10a guesschance10

. rename guesschance11a guesschance11

. rename guesschance12a guesschance12

. rename guesschance13a guesschance13

. rename guesschance14a guesschance14

. rename fssocsec1 fssocsec

. rename homosexual1 homosexual

. rename premaritalsex1 premaritalsex

. rename fswelfare1 fswelfare

. rename toomucheqrights1 toomucheqrights

. rename eqchances1 eqchances

. rename moreeqchances1 moreeqchances

. rename lesseq1 lesseq

. rename musicpref1a musicpref1

. rename musicpref2a musicpref2

. rename musicpref3a musicpref3

. rename musicpref4a musicpref4

. rename musicpref5a musicpref5

. rename musicpref6a musicpref6

. rename musicpref7a musicpref7

. rename musicpref8a musicpref8

. rename musicpref9a musicpref9

. rename musicpref10a musicpref10

. rename musicpref11a musicpref11

. rename musicpref12a musicpref12

. rename musicpref13a musicpref13

. rename musicpref14a musicpref14

. rename musicpref15a musicpref15

. rename musicpref16a musicpref16

. rename musicpref17a musicpref17

. rename musicpref18a musicpref18

. rename musicpref19a musicpref19

. rename musicpref20a musicpref20

. rename musicpref21a musicpref21

. rename musicpref22a musicpref22

. rename culturalevents1a culturalevents1

. rename culturalevents2a culturalevents2

. rename culturalevents3a culturalevents3

. rename culturalevents4a culturalevents4

. rename culturalevents5a culturalevents5

. rename culturalevents6a culturalevents6

. rename culturalevents7a culturalevents7

. rename culturalevents8a culturalevents8

. rename culturalevents9a culturalevents9

. rename culturalevents10a culturalevents10

. rename culturalevents11a culturalevents11

. rename culturalevents12a culturalevents12

. rename typebookread1a typebookread1

. rename typebookread2a typebookread2

. rename typebookread3a typebookread3

. rename typebookread4a typebookread4

. rename typebookread5a typebookread5

. rename typebookread6a typebookread6

. rename typebookread7a typebookread7

. rename typebookread8a typebookread8

. rename typebookread9a typebookread9

. rename landmarkssq001 landmarks1

. rename landmarkssq002 landmarks2

. rename landmarkssq003 landmarks3

. rename landmarkssq004 landmarks4

. rename landmarkssq005 landmarks5

. rename outus1 outus

. rename whereoutussq001a whereoutus1

. rename whereoutussq002a whereoutus2

. rename whereoutussq003a whereoutus3

. rename whereoutussq004a whereoutus4

. rename whereoutussq005a whereoutus5

. rename whereoutussq006a whereoutus6

. rename whereoutussq007a whereoutus7

. rename whereoutussq008a whereoutus8

. rename whereoutussq009a whereoutus9

. rename whereoutussq010a whereoutus10

. rename whereoutussq011a whereoutus11

. rename interestitemssq001a interestitems1

. rename interestitemssq002a interestitems2

. rename interestitemssq003a interestitems3

. rename interestitemssq004a interestitems4

. rename interestitemssq005a interestitems5

. rename interestitemssq006a interestitems6

. rename usagedegreesq001 usagedegree

. rename planpurchasingsq001a planpurchasing

. rename planpurchasing planpurchasing1

. rename planpurchasingsq002a planpurchasing2

. rename planpurchasingsq003a planpurchasing3

. rename planpurchasingsq004a planpurchasing4

. rename planpurchasingsq005a planpurchasing5

. rename planpurchasingsq006a planpurchasing6

. rename planpurchasingsq007a planpurchasing7

. rename planpurchasingsq008a planpurchasing8

. rename computerusesq001 computeruse1

. rename computeruse1 computeruse

. rename program1 program

. rename programwhichsq001a programwhich1

. rename programwhichsq002a programwhich2

. rename programwhichsq003a programwhich3

. rename programwhichsq004a programwhich4

. rename programwhichsq005a programwhich5

. rename programwhichsq006a programwhich6

. rename programwhichsq007a programwhich7

. rename programwhichsq008a programwhich8

. rename programwhichsq009a programwhich9

. rename programwhichsq010a programwhich10

. rename programwhichsq011a programwhich11

. rename usefacebooksq001a usesocnetwork1

. rename usefacebooksq002a usesocnetwork2

. rename usefacebooksq003a usesocnetwork3

. rename usefacebooksq004a usesocnetwork4

. rename usefacebooksq005a usesocnetwork5

. rename usefacebooksq006a usesocnetwork6

. rename usefacebooksq007a usesocnetwork7

. rename usefacebooksq008a usesocnetwork8

. rename usefacebookother usesocnetwork9

. rename activityfun01a phoneuse1

. rename activityfun02a phoneuse2

. rename activityfun03a phoneuse3

. rename activityfun04a phoneuse4

. rename activityfun05a phoneuse5

. rename activityfun06a phoneuse6

. rename activityfun07a phoneuse7

. rename activityfun08a phoneuse8

. rename activityfun09a phoneuse9

. rename activityfun10a phoneuse10

. rename activityfun11a phoneuse11


. rename familymilitary1 familymilitary

. rename closemilitary1 closemilitary


///**PHONENUMBER FIX**////

merge m:1 FirstName LastName using "M:\PentaWork\Data\filter files\student data file to merge - for margarets code.dta"
sort _merge
replace sender=5745407562 if netid=="yshen2"
replace sender=5745407529 if netid=="oeyeguok"
replace sender=5743671670 if netid=="ksievers"
replace sender=5745407589 if netid=="bstalcup"
replace sender=5743671513 if netid=="mconlin"
replace sender=5743671965 if netid=="ahill12"
replace sender=5745407105 if netid=="abogucki"
replace sender=5745407578 if netid=="mzhao1"
replace sender=5743671738 if netid=="jschult6"
replace sender=5745407545 if netid=="jschne11"
replace sender=5743671950 if netid=="gliu2"
replace sender=5745407540 if netid=="twoodcoc"
replace sender=5745403482 if netid=="cfiessin"
replace sender=5745407565 if netid=="mvonder1"
replace sender=5745407093 if netid=="mmarti25"
replace sender=5743671748 if netid=="bthoma11"
replace sender=5743671544 if netid=="sdriscol"
replace sender=5745407557 if netid=="aboehm"
replace sender=5745407143 if netid=="whallas"
replace sender=5743671679 if netid=="cchval"
replace sender=5745407586 if netid=="wstith"
replace sender=5745407541 if netid=="abarnes4"
replace sender=5743671764 if netid=="gadegbit"


drop if _merge==2



** Reverse Coding R variables for iamsomeonewho variables **
local vars iamsomeonewho2r iamsomeonewho6r iamsomeonewho8r iamsomeonewho9r ///
iamsomeonewho12r iamsomeonewho18r iamsomeonewho21r iamsomeonewho23r iamsomeonewho24r ///
 iamsomeonewho27r iamsomeonewho31r iamsomeonewho34r iamsomeonewho35r iamsomeonewho37r ///
 iamsomeonewho41r iamsomeonewho43r

 foreach x of local vars {
 replace `x'= 6-`x'
 
 }

//separate into categories (Extraversion, Agreeableness, Conscientiousness, Neuroticism, Openness)
gen extraversion=  (iamsomeonewho1 +  iamsomeonewho6r +  iamsomeonewho11 +  iamsomeonewho16 +  iamsomeonewho21r +  iamsomeonewho26 +  iamsomeonewho31r +  iamsomeonewho36)/8
tab1 extraversion
mean extraversion

gen agreeableness= (iamsomeonewho2r + iamsomeonewho7 + iamsomeonewho12r + iamsomeonewho17 + iamsomeonewho22 + iamsomeonewho27r + iamsomeonewho32 + iamsomeonewho37r + iamsomeonewho42)/ 9
tab1 agreeableness
mean agreeableness

gen conscientiousness= (iamsomeonewho3 + iamsomeonewho8r + iamsomeonewho13 + iamsomeonewho18r + iamsomeonewho23r + iamsomeonewho28 + iamsomeonewho33 + iamsomeonewho38 + iamsomeonewho43r)/9
tab1 conscientiousness
mean conscientiousness

gen neuroticism= (iamsomeonewho4 + iamsomeonewho9r + iamsomeonewho14 + iamsomeonewho19 + iamsomeonewho24r + iamsomeonewho29 + iamsomeonewho34r + iamsomeonewho39)/8
tab1 neuroticism
mean neuroticism

gen openness= (iamsomeonewho5 + iamsomeonewho10 + iamsomeonewho15 + iamsomeonewho20 + iamsomeonewho25 + iamsomeonewho30 + iamsomeonewho35r + iamsomeonewho40 + iamsomeonewho41r + iamsomeonewho44)/10
tab1 openness
mean openness

//**Add Suffix to Variables**//
foreach var of varlist completed-dropped studyid-emailaddress _merge-openness {
rename `var' `var'_1
}


* This part is unique *
duplicates tag sender if sender!=., gen(duplicate)

tab duplicate

replace duplicate=2 if sender==5745407579 & completed_1==""


* Coding Scheme *
* 0 No Duplicate
* 1 Duplicate- Most Complete Record 
* 2 Duplicate- Least Complete Record 



** See "M:\Current Data\Mike's survey code - 5-13-2013\SummerSurvey11_RecodeALL-margaret.do" for information on how this data was created

rename activitypastyear1_1 activity1_1
rename activitypastyear2_1 activity2_1
rename activitypastyear3_1 activity3_1
rename activitypastyear4_1 activity4_1
rename activitypastyear5_1 activity5_1
rename activitypastyear6_1 activity6_1
rename activitypastyear7_1 activity7_1
rename activitypastyear8_1 activity8_1
rename activitypastyear9_1 activity9_1
rename activitypastyear10_1 activity10_1
rename activitypastyear11_1 activity11_1
rename activitypastyear12_1 activity12_1
rename activitypastyear13_1 activity13_1
rename activitypastyear14_1 activity14_1

rename highschoolactivitya_1 timeperweekactivea_1
rename highschoolactivityb_1 timeperweekactiveb_1
rename highschoolactivityc_1 timeperweekactivec_1
rename highschoolactivityd_1 timeperweekactived_1
rename highschoolactivitye_1 timeperweekactivee_1
rename highschoolactivityf_1 timeperweekactivef_1
rename highschoolactivityg_1 timeperweekactiveg_1
rename highschoolactivityh_1 timeperweekactiveh_1
rename highschoolactivityi_1 timeperweekactivei_1
rename highschoolactivityj_1 timeperweekactivej_1
rename highschoolactivityk_1 timeperweekactivek_1
rename highschoolactivityl_1 timeperweekactivel_1
rename highschoolactivitym_1 timeperweekactivem_1
rename highschoolactivityn_1 timeperweekactiven_1




save "M:\JoeWorkmanWork\Demographic Surveys\Summer 2011(W1) - Demographic Survey - 2014_01_31.dta", replace 
** Professor Hachen said not to save over existing files; storing in the folder for my work **
























