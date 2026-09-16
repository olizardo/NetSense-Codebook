



// WinterSurvey12 recodes
set more off
insheet using "M:\Current Data\Mike's survey code - 5-13-2013\Winter 2012 - Demographic Data.csv"

// rename name variables to something meaningful
rename namenetidsq001 FirstName
rename namenetidsq002 LastName
rename namenetidsq003 netid
// rename namenetidsq003corrected netidcorrected ;; variable namenetidsq003corrected not found

// leave phonenumber (from Z:\Student data\Quizzes and Survey results\Misc (pre 12-26-2011)) as is

// recode firstsemwork into numeric variable
tab1 firstsemwork
encode firstsemwork, gen(firstsemworkx)
tab1 firstsemwork*
tab1 firstsemwork*, nolabel
label define firstsemwork 1 "None" 2 "0-4" 3 "5-10" 4 "11-15"
recode firstsemworkx 1=2 2=3 3=4 4=1
label values firstsemworkx firstsemwork
tab1 firstsemwork*
tab1 firstsemwork*, nolabel
order firstsemworkx, after(firstsemwork)
drop firstsemwork
rename firstsemworkx firstsemwork
label variable firstsemwork "Hours worked per week in 1st semester of college"
tab firstsemwork


// clubs 1-10 are open ended so no need to recode yet

// first sem classes are open ended, and we need to determine what to do with those that are not all numerical before coding them

// rename firstsemgrade to firstsemgpa for intuativeness
rename firstsemgrade firstsemgpa

// undergradmajor rename to major, but the rest is left out for future coding
rename undergradmajor major

// disability, and contacts/glasses (all the same coding) recoding (N/A treated as missing because it is not a choice in the survey)
tab1 disabilitylearning-eyeglasses
foreach v of varlist disabilitylearning-eyeglasses {
encode `v', gen(`v'x)
}
label define yesno 0 "No" 1 "Yes"
foreach v of varlist disabilitylearningx-eyeglassesx {
recode `v' 1=. 2=0 3=1
label value `v' yesno
}
tab1 disabilitylearningx-eyeglassesx, mis
tab1 disabilitylearningx-eyeglassesx, mis nolabel
order disabilitylearningx-eyeglassesx, after(eyeglasses)
drop disabilitylearning-eyeglasses
rename disabilitylearningx disabilitylearning
rename disabilityphysicalx disabilityphysical
rename contactlensx contactlens
rename eyeglassesx eyeglasses


// Height: Feet to inches
tab1 height*
gen height=.
replace height=60 if heightsq001==5
//5.87 treated as missing as it is captured in the inches to inches below
replace height=72 if heightsq001==6
replace height=0 if heightsq001==.

// inches to inches
gen heightin=.
replace heightin=0 if heightsq002==""
replace heightin=0 if heightsq002=="0"
replace heightin=1 if heightsq002=="1"
replace heightin=10 if heightsq002=="10"
replace heightin=11 if heightsq002=="11"
replace heightin=2 if heightsq002=="2"
replace heightin=2.75 if heightsq002=="2 3/4"
replace heightin=2.5 if heightsq002=="2.5"
replace heightin=2.5 if heightsq002=="23"
replace heightin=3 if heightsq002=="3"
replace heightin=3.5 if heightsq002=="3.5"
replace heightin=4 if heightsq002=="4"
replace heightin=5 if heightsq002=="5"
replace heightin=6 if heightsq002=="6"
replace heightin=6.5 if heightsq002=="6.5"
replace heightin=66 if heightsq002=="66"
replace heightin=7 if heightsq002=="7"
replace heightin=7.5 if heightsq002=="7.5"
replace heightin=70.5 if heightsq002=="70.5"
replace heightin=8 if heightsq002=="8"
replace heightin=9 if heightsq002=="9"
tab1 height*

gen heighttotal=height+heightin
replace heighttotal=. if heighttotal==0
tab heighttotal
label variable heighttotal "Height in inches combined"
order height-heighttotal, after(heightsq002)
drop heightsq001-heightsq002
drop height-heightin

// weight is good as it is
tab1 weight
label variable weight "Weight in pounds"

// health
tab1 health
encode health, gen(healthx)
recode healthx 1=4 2=3 3=2 4=1
label define health 1 "Poor" 2 "Fair" 3 "Good" 4 "Excellent"
label value healthx health
label variable healthx "Would you say your own health in general is:"
tab1 healthx
order healthx, after(health)
drop health
rename healthx health

// happiness
tab1 happiness
encode happiness, gen(happinessx)
label define happy1 0 "Not sure" 1 "Not so happy" 2 "Pretty happy" 3 "Happy" 4 "Very happy" 
recode happinessx 1=3 2=1 3=0 4=2 5=4
label value happinessx happy1
label variable happinessx "Taken together, how would you say things are these days?"
tab1 happinessx
order happinessx, after(happiness)
drop happiness
rename happinessx happy

// I am someone who?
tab1 iamsomeonewho*
foreach v of varlist iamsomeonewho1-iamsomeonewho44 {
encode `v', gen(`v'x)
}
label define iam 1 "Strongly Disagree" 2 "Disagree" 3 "Neither agree or disagree" 4 "Agree" 5 "Strongly Agree"
foreach v of varlist iamsomeonewho1x-iamsomeonewho44x {
recode `v' 1=4 2=2 3=3 4=5 5=1
label value `v' iam
}
tab1 iamsomeonewho1x-iamsomeonewho44x
order iamsomeonewho1x-iamsomeonewho44x, after(iamsomeonewho44)
//*Recode R questions
foreach v of varlist iamsomeonewho2x iamsomeonewho6x iamsomeonewho8x iamsomeonewho9x iamsomeonewho12x iamsomeonewho18x iamsomeonewho21x iamsomeonewho23x iamsomeonewho24x iamsomeonewho27x iamsomeonewho31x iamsomeonewho34x iamsomeonewho35x {
recode `v' 1=5 2=4 3=3 4=2 5=1
label value `v' iam
}

drop iamsomeonewho1-iamsomeonewho44

rename iamsomeonewho1x iamsomeonewho1
rename iamsomeonewho2x iamsomeonewho2r
rename iamsomeonewho3x iamsomeonewho3
rename iamsomeonewho4x iamsomeonewho4
rename iamsomeonewho5x iamsomeonewho5
rename iamsomeonewho6x iamsomeonewho6r
rename iamsomeonewho7x iamsomeonewho7
rename iamsomeonewho8x iamsomeonewho8r
rename iamsomeonewho9x iamsomeonewho9r
rename iamsomeonewho10x iamsomeonewho10
rename iamsomeonewho11x iamsomeonewho11
rename iamsomeonewho12x iamsomeonewho12r
rename iamsomeonewho13x iamsomeonewho13
rename iamsomeonewho14x iamsomeonewho14
rename iamsomeonewho15x iamsomeonewho15
rename iamsomeonewho16x iamsomeonewho16
rename iamsomeonewho17x iamsomeonewho17
rename iamsomeonewho18x iamsomeonewho18r
rename iamsomeonewho19x iamsomeonewho19
rename iamsomeonewho20x iamsomeonewho20
rename iamsomeonewho21x iamsomeonewho21r
rename iamsomeonewho22x iamsomeonewho22
rename iamsomeonewho23x iamsomeonewho23r
rename iamsomeonewho24x iamsomeonewho24r
rename iamsomeonewho25x iamsomeonewho25
rename iamsomeonewho26x iamsomeonewho26
rename iamsomeonewho27x iamsomeonewho27r
rename iamsomeonewho28x iamsomeonewho28
rename iamsomeonewho29x iamsomeonewho29
rename iamsomeonewho30x iamsomeonewho30
rename iamsomeonewho31x iamsomeonewho31r
rename iamsomeonewho32x iamsomeonewho32
rename iamsomeonewho33x iamsomeonewho33
rename iamsomeonewho34x iamsomeonewho34r
rename iamsomeonewho35x iamsomeonewho35r
rename iamsomeonewho36x iamsomeonewho36
rename iamsomeonewho37x iamsomeonewho37r
rename iamsomeonewho38x iamsomeonewho38
rename iamsomeonewho39x iamsomeonewho39
rename iamsomeonewho40x iamsomeonewho40
rename iamsomeonewho41x iamsomeonewho41r
rename iamsomeonewho42x iamsomeonewho42
rename iamsomeonewho43x iamsomeonewho43r
rename iamsomeonewho44x iamsomeonewho44

label variable iamsomeonewho1 "I am someone who: Is talkative"
label variable iamsomeonewho2r "I am someone who: Tends to find fault with others"
label variable iamsomeonewho3 "I am someone who: Does a thorough job"
label variable iamsomeonewho4 "I am someone who: Is depressed, blue"
label variable iamsomeonewho5 "I am someone who: Is original, comes up with new ideas"
label variable iamsomeonewho6r "I am someone who: Is reserved"
label variable iamsomeonewho7 "I am someone who: Is helpful and unselfish with others"
label variable iamsomeonewho8r "I am someone who: Can be somewhat careless"
label variable iamsomeonewho9r "I am someone who: Is relaxed, handles stress well"
label variable iamsomeonewho10 "I am someone who: Is curious about many different things"
label variable iamsomeonewho11 "I am someone who: Is full of energy"
label variable iamsomeonewho12r "I am someone who: Starts quarrels with others"
label variable iamsomeonewho13 "I am someone who: Is a reliable worker"
label variable iamsomeonewho14 "I am someone who: Can be tense"
label variable iamsomeonewho15 "I am someone who: Is ingenious, a deep thinker"
label variable iamsomeonewho16 "I am someone who: Generates a lot of enthusiasm"
label variable iamsomeonewho17 "I am someone who: Has a forgiving nature"
label variable iamsomeonewho18r "I am someone who: Tends to be disorganized"
label variable iamsomeonewho19 "I am someone who: Worries a lot"
label variable iamsomeonewho20 "I am someone who: Has an active imagination"
label variable iamsomeonewho21r "I am someone who: Tends to be quiet"
label variable iamsomeonewho22 "I am someone who: Is generally trusting"
label variable iamsomeonewho23r "I am someone who: Tends to be lazy"
label variable iamsomeonewho24r "I am someone who: Is emotionally stable, not easily upset"
label variable iamsomeonewho25 "I am someone who: Is inventive"
label variable iamsomeonewho26 "I am someone who: Has an assertive personality"
label variable iamsomeonewho27r "I am someone who: Can be cold and aloof"
label variable iamsomeonewho28 "I am someone who: Perseveres until the task is finished"
label variable iamsomeonewho29 "I am someone who: Can be moody"
label variable iamsomeonewho30 "I am someone who: Values artistic, aesthetic experiences"
label variable iamsomeonewho31r "I am someone who: Is sometimes shy, inhibited"
label variable iamsomeonewho32 "I am someone who: Is considerate and kind to almost everyone"
label variable iamsomeonewho33 "I am someone who: Does things efficiently"
label variable iamsomeonewho34r "I am someone who: Remains calm in tense situations"
label variable iamsomeonewho35r "I am someone who: Prefers work that is routine"
label variable iamsomeonewho36 "I am someone who: Is outgoing, sociable"
label variable iamsomeonewho37r "I am someone who: Is sometimes rude to others"
label variable iamsomeonewho38 "I am someone who: Makes plans and follows through with them"
label variable iamsomeonewho39 "I am someone who: Gets nervous easily"
label variable iamsomeonewho40 "I am someone who: Likes to reflect, play with ideas"
label variable iamsomeonewho41r "I am someone who: Has few artistic interests"
label variable iamsomeonewho42 "I am someone who: Likes to cooperate with others"
label variable iamsomeonewho43r "I am someone who: Is easily distracted"
label variable iamsomeonewho44 "I am someone who: Is sophisticated in art, music, or literature"



// Well being index
tab1 wellbeing*
encode wellbeingindexsq001, gen(wellbeing1)
encode wellbeingindexsq002, gen( wellbeing2)
encode wellbeingindexsq003, gen( wellbeing3)
encode wellbeingindexsq004, gen( wellbeing4)
encode wellbeingindexsq005, gen( wellbeing5)
label define wellbeing 0 "At no time" 1 "Some of the time" 2 "Less than half the time" 3 "More than half the time" 4 "Most of the time" 5 "All the time"
foreach v of varlist wellbeing1 wellbeing2 wellbeing3 wellbeing5 {
recode `v' 1=5 2=2 3=3 4=4 5=1 
label value `v' wellbeing
}
tab1 wellbeing1 wellbeing2 wellbeing3 wellbeing5
recode wellbeing4 1=5 2=0 3=2 4=3 5=4 6=1
label value wellbeing4 wellbeing
tab1 wellbeing4
order wellbeing1-wellbeing5, after(wellbeingindexsq005)
drop wellbeingindexsq001-wellbeingindexsq005
label variable wellbeing1 "Well Being Index:I have felt cheerful and in good spirits"
label variable wellbeing2 "Well Being Index:I have felt calm and relaxed"
label variable wellbeing3 "Well Being Index:I have felt active and vigorous"
label variable wellbeing4 "Well Being Index:I woke up feeling fresh and rested"
label variable wellbeing5 "Well Being Index:My daily life has been filled with things that interest me"



// Activities in the first semester
tab1 activityfirstsem*
foreach v of varlist activityfirstsem1-activityfirstsem14 {
encode `v', gen(`v'x)
}
label define activities 0 "Not at all" 1 "Less than 1-2 Times a month"  2 "1-2 Times a month" 3 "1-2 Times a week" 4 "Everyday or almost everyday"
foreach v of varlist activityfirstsem1x-activityfirstsem12x activityfirstsem14x {
recode `v' 1=2 2=3 3=4 4=1 5=0
label value `v' activities
}
recode activityfirstsem13x 1=2 2=3 3=1 4=0
label value activityfirstsem13x activities
tab1 activityfirstsem1x-activityfirstsem14x
order activityfirstsem1x-activityfirstsem14x, after(activityfirstsem14)
drop activityfirstsem1-activityfirstsem14
rename activityfirstsem1x activityfirstsem1
rename activityfirstsem2x activityfirstsem2
rename activityfirstsem3x activityfirstsem3 
rename activityfirstsem4x activityfirstsem4
rename activityfirstsem5x activityfirstsem5
rename activityfirstsem6x activityfirstsem6
rename activityfirstsem7x activityfirstsem7
rename activityfirstsem8x activityfirstsem8
rename activityfirstsem9x activityfirstsem9
rename activityfirstsem10x activityfirstsem10
rename activityfirstsem11x activityfirstsem11
rename activityfirstsem12x activityfirstsem12
rename activityfirstsem13x activityfirstsem13
rename activityfirstsem14x activityfirstsem14
 
label variable activityfirstsem1	"Attended a religious service"
label variable activityfirstsem2	"Demonstrated for a cause"
label variable activityfirstsem3	"Smoked a cigarette"
label variable activityfirstsem4	"Drank beer"
label variable activityfirstsem5	"Drank wine or liquor"
label variable activityfirstsem6	"Exercised"
label variable activityfirstsem7	"Felt overwhelmed by all I had to do"
label variable activityfirstsem8	"Felt depressed"
label variable activityfirstsem9	"Performed volunteer work"
label variable activityfirstsem10	"Socialized with someone of another racial/ethnic group"
label variable activityfirstsem11	"Discussed religion"
label variable activityfirstsem12	"Discussed politics"
label variable activityfirstsem13	"Worked on a local, state, or national political campaign"
label variable activityfirstsem14	"Publicly communicated my opinion about a cause (blog, email, petition)"



// First semseter Activity
tab1 firstsemactivitya-firstsemactivityn
foreach v of varlist firstsemactivitya-firstsemactivityn {
encode `v', gen(`v'1)
}
label define firstsem 0 "None" 1 "Less than half an hour" 2 "1-2 hours" 3 "3-5 hours" 4 "6-10 hours" 5 "11-15 hours" 6 "16-20 hours" 7 "Over 20"
tab1 firstsemactivitya1
recode firstsemactivitya1 1=2 2=5 3=6 4=3 5=4 6=7
label value firstsemactivitya1 firstsem

tab1 firstsemactivityb1
recode firstsemactivityb1 1=2 2=5 3=6 4=3 5=4 6=1 7=7
label value firstsemactivityb1 firstsem

tab1 firstsemactivityc1 firstsemactivityg1 firstsemactivityi1 firstsemactivitym1 firstsemactivityn1
foreach v of varlist firstsemactivityc1 firstsemactivityg1 firstsemactivityi1 firstsemactivitym1 firstsemactivityn1 {
recode `v' 1=2 2=5 3=6 4=3 5=4 6=1 7=0 8=7
label value `v' firstsem
} 
tab1 firstsemactivityd1
recode firstsemactivityd1 1=2 2=5 3=3 4=4 5=1 6=0 7=7
label value firstsemactivityd1 firstsem

tab1 firstsemactivitye1 firstsemactivityh1 firstsemactivityk1
foreach v of varlist firstsemactivitye1 firstsemactivityh1 firstsemactivityk1  {
recode `v' 1=2 2=5 3=3 4=4 5=1 6=0
label value `v' firstsem 
}

tab1 firstsemactivityf1 firstsemactivityj1
foreach v of varlist firstsemactivityf1 firstsemactivityj1 {
recode `v' 1=2 2=3 3=4 4=1 5=0
label value `v' firstsem
}
tab1 firstsemactivityl1
recode firstsemactivityl1 1=2 2=6 3=3 4=4 5=1 6=0
label value firstsemactivityl1 firstsem

tab1 firstsemactivitya*
tab1 firstsemactivityb*
tab1 firstsemactivityc*
tab1 firstsemactivityd*
tab1 firstsemactivitye*
tab1 firstsemactivityf*
tab1 firstsemactivityg*
tab1 firstsemactivityh*
tab1 firstsemactivityi*
tab1 firstsemactivityj*
tab1 firstsemactivityk*
tab1 firstsemactivityl*
tab1 firstsemactivitym*
tab1 firstsemactivityn*
order firstsemactivitya1-firstsemactivityn1, after(firstsemactivityn)
drop firstsemactivitya-firstsemactivityn
rename firstsemactivitya1 timeperweekactivita
rename firstsemactivityb1 timeperweekactivitb
rename firstsemactivityc1 timeperweekactivitc
rename firstsemactivityd1 timeperweekactivitd
rename firstsemactivitye1 timeperweekactivite
rename firstsemactivityf1 timeperweekactivitf
rename firstsemactivityg1 timeperweekactivitg
rename firstsemactivityh1 timeperweekactivith
rename firstsemactivityi1 timeperweekactiviti
rename firstsemactivityj1 timeperweekactivitj
rename firstsemactivityk1 timeperweekactivitk
rename firstsemactivityl1 timeperweekactivitl
rename firstsemactivitym1 timeperweekactivitm
rename firstsemactivityn1 timeperweekactivitn
label variable timeperweekactivita	"Studying/homework during the last week"
label variable timeperweekactivitb	"Socializing with friends during the last week"
label variable timeperweekactivitc	"Exercise or sports during the last week"
label variable timeperweekactivitd	"Partying during the last week"
label variable timeperweekactivite	"Working (for pay) during the last week"
label variable timeperweekactivitf	"Volunteer work during the last week"
label variable timeperweekactivitg	"Student clubs/groups during the last week"
label variable timeperweekactivith	"Watching TV programs during the last week"
label variable timeperweekactiviti	"Listening to music during the last week"
label variable timeperweekactivitj	"Household/childcare duties during the last week"
label variable timeperweekactivitk	"Reading for pleasure during the last week"
label variable timeperweekactivitl	"Playing single player video/computer games during the last week"
label variable timeperweekactivitm	"Playing multiplayer video/computer games during the last week"
label variable timeperweekactivitn	"Online social networks (MySpace, Facebook, Google+, etc.) during the last week"
tab1 timeperweekactivita-timeperweekactivitn



// Importance variables
tab1 importance*
label define importance 1 "Not important" 2 "Somewhat important" 3 "Very Important" 4 "Essential"
foreach v of varlist importance* {
encode `v', gen(`v'x)
}
foreach v of varlist importance1x-importance16x {
recode `v' 1=4 2=1 3=2 4=3
label value `v' importance 
}
order importance1x-importance16x, after(importance16)
drop importance1-importance16

rename importance1x	importance1
rename importance2x	importance2
rename importance3x	importance3
rename importance4x	importance4
rename importance5x	importance5
rename importance6x	importance6
rename importance7x	importance7
rename importance8x	importance8
rename importance9x	importance9
rename importance10x importance10
rename importance11x importance11
rename importance12x importance12
rename importance13x importance13
rename importance14x importance14
rename importance15x importance15
rename importance16x importance16

label variable importance1 "Important personally: 	Becoming accomplished in one of the performing arts"
label variable importance2 "Important personally: 	Becoming an authority in my field"
label variable importance3 "Important personally: 	Obtaining recognition from my colleagues for contributions to my special field"
label variable importance4 "Important personally: 	Influencing the political structure"
label variable importance5 "Important personally: 	Influencing social values"
label variable importance6 "Important personally: 	Raising a family"
label variable importance7 "Important personally: 	Being very well off financially"
label variable importance8 "Important personally: 	Helping promote understanding between groups"
label variable importance9 "Important personally: 	Making a theoretical contribution to science"
label variable importance10	"Important personally: 	Writing original works (poems, novels, etc.)"
label variable importance11	"Important personally: 	Creating artistic works (painting, sculpture, etc.)"
label variable importance12	"Important personally: 	Becoming involved in programs to clean up the environment"
label variable importance13	"Important personally: 	Keeping up to date with political affairs"
label variable importance14	"Important personally: 	Becoming a community leader"
label variable importance15	"Important personally: 	Improving my understanding of other groups and cultures"
label variable importance16	"Important personally: 	Adopting “green” practices to protect the environment"



// Guess chance variables
tab1 guesschance*
label define guess 0 "No chance" 1 "Very little chance" 2 "Some chance" 3 "Very good chance"
foreach v of varlist guesschance* {
encode `v', gen(`v'x)
}
foreach v of varlist guesschance1x-guesschance14x {
recode `v' 1=0 2=2 3=3 4=1
label value `v' guess
}
order guesschance1x-guesschance14x, after(guesschance14)
drop guesschance1-guesschance14

rename guesschance1x guesschance1
rename guesschance2x guesschance2
rename guesschance3x guesschance3
rename guesschance4x guesschance4
rename guesschance5x guesschance5
rename guesschance6x guesschance6
rename guesschance7x guesschance7
rename guesschance8x guesschance8
rename guesschance9x guesschance9
rename guesschance10x guesschance10
rename guesschance11x guesschance11
rename guesschance12x guesschance12
rename guesschance13x guesschance13
rename guesschance14x guesschance14
label variable guesschance1	"Chance you will: 	Change major field?"
label variable	guesschance2	"Chance you will: 	Change career choice?" 
label variable	guesschance3	"Chance you will: 	Participate in student government?"
label variable	guesschance4	"Chance you will: 	Get a job to help pay for college expenses?"
label variable	guesschance5	"Chance you will: 	Play club, intramural or recreational sports?"
label variable	guesschance6	"Chance you will: 	Play intercollegiate athletics (e.g., NCAA or NAIA-sponsored)?"
label variable	guesschance7	"Chance you will: 	Participate in student protests or demonstrations?"
label variable	guesschance8	"Chance you will: 	Transfer to another college before graduating?"
label variable	guesschance9	"Chance you will: 	Participate in volunteer or community service work?"
label variable	guesschance10	"Chance you will: 	Seek personal counseling?"
label variable	guesschance11	"Chance you will: 	Socialize with someone of another racial/ethnic group?"
label variable	guesschance12	"Chance you will: 	Participate in student clubs/groups?"
label variable	guesschance13	"Chance you will: 	Participate in a study abroad program?"
label variable	guesschance14	"Chance you will: 	Work on a professor's research project?"



// attitudes

tab1 politicalscalesq001
encode politicalscalesq001, gen(political)
tab1 political
label define polit 0 "Not sure" 1 "Extremely liberal" 2 "Liberal" 3 "Slightly liberal" 4 "Moderate" 5 "Slightly conservative" 6 "Conservative" 7 "Extremely conservative"
recode political 1=6 2=7 3=2 4=4 5=0 6=5 7=3
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
rename homosexual1 homosexual
rename premaritalsex1 premaritalsex


tab1 homomarriage, mis
encode homomarriage, gen(gaymarriage)
label define gaymar 0 "Not Sure" 1 "Strongly diisagree" 2 "Disagree" 3 "Neither agree nor disagree" 4 "Agree" 5 "Strongly agree"
recode gaymarriage 1=4 2=2 3=3 4=0 5=5 6=1
label values gaymarriage gaymar
tab1 homomarriage gaymarriage, mis
order gaymarriage, before(premaritalsex)
drop homomarriage

tab major
encode major, gen(undergradmajor)
label define undermaj 0 "(Other Fields) Undecided" 1 "(Arts and Humanities)" 2 "(Arts and Humanities) Art, fine and applied" 3 "(Arts and Humanities) English (language and literature)" 4 "(Arts and Humanities) History" 5 "(Arts and Humanities) Journalism" 6 "(Arts and Humanities) Language and Literature (except English)" 7 "(Arts and Humanities) Music" 8 "(Arts and Humanities) Philosophy" 9 "(Arts and Humanities) Speech" 10 "(Arts and Humanities)Theatre or Drama" 11 "(Arts and Humanities)Theology or Religion" 12 "(Arts and Humanities)Other Arts and Humanities" 13 "(Biological Sciences)" 14 "(Biological Sciences)Biology(general)" 15 "(Biological Sciences)Biochemistry or Biophysics" 16 "(Biological Sciences)Botany" 17 "(Biological Sciences)Environmental Science" 18 "(Biological Sciences)Marine (Life) Science" 19 "(Biological Sciences)Microbiology or Bacteriology" 20 "(Biological Sciences)Zoology" 21 "(Biological Sciences) Other Biological Science" 22 "(Business)" 23 "(Business)Accounting" 24 "(Business)Business Admin (general)" 25 "(Business)Finance" 26 "(Business)International Business" 27 "(Business)Marketing" 28 "(Business)Management" 29 "(Business)Secretarial Studies" 30 "(Business)Other Business" 31 "(Education)" 32 "(Education)Business Education" 33 "(Education)Elementary Education" 34 "(Education)Music or Art Education" 35 "(Education)Physical Education or Recreation" 36 "(Education)Secondary Education" 37 "(Education)Special Education" 38 "(Education)Other Education" 39 "(Engineering)" 40 "(Engineering)Aeronautical or Astronautical Eng" 41 "(Engineering)Civil Engineering" 42 "(Engineering)Chemical Engineering" 43 "(Engineering)Computer Science & Engineering" 44 "(Engineering)Electrical or Electronic Engineering" 45 "(Engineering) Industrial Engineering" 46 "(Engineering) Mechanical Engineering" 47 "(Engineering) Other Engineering" 48 "(Physical Science)" 49 "(Physical Science) Astronomy" 50 "(Physical Science) Atmospheric Science (incl. Meteorology)" 51 "(Physical Science) Chemistry" 52 "(Physical Science) Earth Science" 53 "(Physical Science) Marine Science (incl. Oceanography)" 54 "(Physical Science) Mathematics" 55 "(Physical Science) Physics" 56 "(Physical Science) Other Physical Science" 57 "(Professional)" 58 "(Professional) Architecture or Urban Planning" 59 "(Professional) Family and Consumer Sciences" 60 "(Professional) Health Technology (medical, dental, laboratory)" 61 "(Professional) Library or Archival Science" 62 "(Professional) Medicine, Dentistry, Veterinary Medicine" 63 "(Professional) Nursing" 64 "(Professional) Pharmacy" 65 "(Professional) Therapy (occupational, physical, speech)" 66 "(Professional) Other Professional" 67 "(Social Science)" 68 "(Social Science) Anthropology" 69 "(Social Science) Economics" 70 "(Social Science) Ethnic Studies" 71 "(Social Science) Geography" 72 "(Social Science) Political Sciences ( gov’t., international relations)" 73 "(Social Science) Psychology" 74 "(Social Science) Public Policy" 75 "(Social Science) Social Work" 76 "(Social Science) Sociology" 77 "(Social Science) Women’s Studies" 78 "(Social Science) Other Social Science" 79 "(Technical)" 80 "(Technical) Building Trades" 81 "(Technical) Data Processing or Computer Programming" 82 "(Technical) Drafting or Design" 83 "(Technical) Electronics" 84 "(Technical) Mechanics" 85 "(Technical) Other Technical" 86 "(Other Fields)" 87 "(Other Fields) Agriculture" 88 "(Other Fields) Communications" 89 "(Other Fields) Forestry" 90 "(Other Fields) Kinesiology" 91 "(Other Fields) Law Enforcement" 92 "(Other Fields) Military Science" 
recode undergradmajor 1=2 2=3 3=4 4=5 5=6 6=7 7=12 8=8 9=13 10=15 11=14 12=17 13=23 14=24 15=25 16=28 17=27 18=30 19=33 20=40 21=42 22=41 23=43 24=44 25=46 26=0 27=51 28=54 29=55 30=58 31=62 32=68 33=69 34=72 35=73 36=82
label values undergradmajor undermaj
tab major undergradmajor, mis
order undergradmajor, after(major)
drop major
rename undergradmajor major


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
rename fswelfare1 fswelfare
rename fssocsec1 fssocsec


tab1 healthins1
encode healthins1, gen(healthins)
label drop healthins
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
rename toomucheqrights1 toomucheqrights
rename eqchances1 eqchances
rename moreeqchances1 moreeqchances
rename lesseq1 lesseq


tab1 discriminationrace
encode discriminationrace, gen(racediscrim)
label define racediscrim1 0 "Not sure" 1 "Strongly oppose" 2 "Oppose" 3 "Favor" 4 "Strongly favor"
recode racediscrim 1=3 2=0 3=2 4=4 5=1
label values racediscrim racediscrim1
tab1 discriminationrace racediscrim, mis
order racediscrim, before(musicpref1)
drop discriminationrace



// music
tab1 music*
label define noyes 0 "No" 1 "Yes"
foreach v of varlist musicpref1-musicpref22 {
encode `v', gen(`v'x)
}
foreach v of varlist musicpref1x-musicpref22x {
recode `v' 1=0 2=1
label value `v' noyes
}
order musicpref1x-musicpref22x, after(musicpref22)
drop musicpref1-musicpref22

rename musicpref1x musicpref1
rename musicpref2x musicpref2
rename musicpref3x musicpref3
rename musicpref4x musicpref4
rename musicpref5x musicpref5
rename musicpref6x musicpref6
rename musicpref7x musicpref7
rename musicpref8x musicpref8
rename musicpref9x musicpref9
rename musicpref10x	musicpref10
rename musicpref11x	musicpref11
rename musicpref12x	musicpref12
rename musicpref13x	musicpref13
rename musicpref14x	musicpref14
rename musicpref15x	musicpref15
rename musicpref16x	musicpref16
rename musicpref17x	musicpref17
rename musicpref18x	musicpref18
rename musicpref19x	musicpref19
rename musicpref20x	musicpref20
rename musicpref21x	musicpref21
rename musicpref22x	musicpref22

label variable musicpref1	"Listen to:	Big band"
label variable musicpref2	"Listen to:	Bluegrass"
label variable musicpref3	"Listen to:	Blues or rhythm & blues"
label variable musicpref4	"Listen to:	Broadway musicals or show tunes"
label variable musicpref5	"Listen to:	Choral or glee club"
label variable musicpref6	"Listen to:	Classic rock or oldies"
label variable musicpref7	"Listen to:	Classical or chamber music"
label variable musicpref8	"Listen to:	Country"
label variable musicpref9	"Listen to:	Dance music"
label variable musicpref10	"Listen to:	Ethnic or national"
label variable musicpref11	"Listen to:	Folk music"
label variable musicpref12	"Listen to:	Hymns or gospel music"
label variable musicpref13	"Listen to:	Jazz"
label variable musicpref14	"Listen to:	Latin, Spanish or Salsa"
label variable musicpref15	"Listen to:	Mood or easy listening"
label variable musicpref16	"Listen to:	New age music"
label variable musicpref17	"Listen to:	Opera"
label variable musicpref18	"Listen to:	Operetta or musicals"
label variable musicpref19	"Listen to:	Parade or marching band"
label variable musicpref20	"Listen to:	Rap or hip-hop"
label variable musicpref21	"Listen to:	Reggae"
label variable musicpref22	"Listen to:	Rock or heavy metal"



// Cultural events
tab1 culturalevents*
foreach v of varlist culturalevents* {
encode `v', gen (`v'x)
}
foreach v of varlist culturalevents1x-culturalevents12x {
recode `v' 1=0 2=1
label value `v' noyes
}
order culturalevents1x-culturalevents12x, after(culturalevents12)
drop culturalevents1-culturalevents12

rename culturalevents1x culturalevents1
rename culturalevents2x culturalevents2
rename culturalevents3x culturalevents3
rename culturalevents4x culturalevents4
rename culturalevents5x culturalevents5
rename culturalevents6x culturalevents6
rename culturalevents7x culturalevents7
rename culturalevents8x culturalevents8
rename culturalevents9x culturalevents9
rename culturalevents10x culturalevents10
rename culturalevents11x culturalevents11
rename culturalevents12x culturalevents12

label variable culturalevents1 "Event attended:	Jazz performance"
label variable culturalevents2	"Event attended:	Latin/Spanish/Salsa performance"
label variable culturalevents3 "Event attended:	Classical Music performance"
label variable culturalevents4 "Event attended:	Opera"
label variable culturalevents5		"Event attended:	Musical stage play"
label variable culturalevents6		"Event attended:	Non-musical stage play"
label variable culturalevents7		"Event attended:	Ballet/Dance"
label variable culturalevents8		"Event attended:	Outdoor performance"
label variable culturalevents9		"Event attended:	Art museum"
label variable culturalevents10	"Event attended:	Science museum"
label variable culturalevents11	"Event attended:	Other type of museum"
label variable culturalevents12	"Event attended:	Craft fair/Arts festival"



// type book read
tab1 typebook*
foreach v of varlist typebookread1-typebookread9 {
encode `v', gen(`v'x)
}
foreach v of varlist typebookread1x-typebookread9x {
recode `v' 1=0 2=1 
label value `v' noyes
}
order typebookread1x-typebookread9x, after(typebookread9)
drop typebookread1-typebookread9
// all below; unrecognized command: """"
rename typebookread1x typebookread1
rename typebookread2x typebookread2
rename typebookread3x typebookread3
rename typebookread4x typebookread4
rename typebookread5x typebookread5
rename typebookread6x typebookread6
rename typebookread7x typebookread7
rename typebookread8x typebookread8
rename typebookread9x typebookread9

label variable typebookread1 "Type of book read: 	Mysteries"
label variable typebookread2 "Type of book read: 	Thrillers"
label variable typebookread3 "Type of book read: 	Romance"
label variable typebookread4 "Type of book read: 	Science fiction/Fantasy"
label variable typebookread5 "Type of book read: 	Other fiction"
label variable typebookread6 "Type of book read: 	Health/Fitness/Self-improvement books"
label variable typebookread7 "Type of book read: 	History/Political books"
label variable typebookread8 "Type of book read: 	Biographies/Memoirs"
label variable typebookread9 "Type of book read: 	Other non-fiction"



// music collection recode
tab musiccollection
encode musiccollection, gen(musiccollection1)
label define musiccollect 0 "None" 1 "1-99" 2 "100-499" 3 "500-999" 4 "1000-4999" 5 "5000-9999" 6 "100000 and more" 
recode musiccollection1 1=4 2=1 3=6 4=2 5=5 6=3 7=0
label value musiccollection1 musiccollect
tab musiccollection1
order musiccollection1, after(musiccollection)
drop musiccollection
rename musiccollection1 musiccollection



// Landmarks are open ended

rename landmarkssq001 landmarks1
rename landmarkssq002 landmarks2
rename landmarkssq003 landmarks3
rename landmarkssq004 landmarks4
rename landmarkssq005 landmarks5

// Out US
tab1 outus 
encode outus, gen(outus1)
recode outus1 1=. 2=0 3=1
label value outus1 noyes
tab1 outus1, mis
order outus1, after(outus)
drop outus
rename outus1 outus



// where out of US
tab1 whereoutus*
foreach v of varlist whereoutussq* {
encode `v', gen(`v'x)
}
foreach v of varlist whereoutussq001x-whereoutussq011x {
recode `v' 1=0 2=1
label value `v' noyes
}

rename whereoutussq001x	 whereoutus1
rename whereoutussq002x	 whereoutus2
rename whereoutussq003x	 whereoutus3
rename whereoutussq004x	 whereoutus4
rename whereoutussq005x	 whereoutus5
rename whereoutussq006x	 whereoutus6
rename whereoutussq007x	 whereoutus7
rename whereoutussq008x	 whereoutus8
rename whereoutussq009x	 whereoutus9
rename whereoutussq010x	 whereoutus10
rename whereoutussq011x	 whereoutus11

label variable whereoutus1		"Where have you been:Mexico"
label variable whereoutus2		"Where have you been:Canada"
label variable whereoutus3		"Where have you been:The Caribbean"
label variable whereoutus4		"Where have you been:Central America"
label variable whereoutus5		"Where have you been:Latin America"
label variable whereoutus6		"Where have you been:Europe (including England)"
label variable whereoutus7		"Where have you been:The Middle East"
label variable whereoutus8		"Where have you been:Africa"
label variable whereoutus9		"Where have you been:Asia"
label variable whereoutus10	"Where have you been:The Far East (China, Japan, etc.)"
label variable whereoutus11	"Where have you been:Australia (New Zealand)"
order whereoutus1-whereoutus11, after(whereoutussq011)
drop whereoutussq001-whereoutussq011



// Interest items
tab1 interestitemssq001-interestitemssq006
// 2 is different than rest
foreach v of varlist interestitemssq001-interestitemssq006 {
encode `v', gen(`v'x)
}
label define interest 1 "Not at all" 2 "Not that much" 3 "Somewhat" 4 "Very much"
foreach v of varlist interestitemssq001x interestitemssq003x interestitemssq004x interestitemssq005x interestitemssq006x {
label value `v' interest
}
recode interestitemssq002x 1=2 2=3 3=4
label value interestitemssq002x interest
tab1 interestitemssq001x-interestitemssq006x

rename interestitemssq001x interestitems1
rename interestitemssq002x interestitems2
rename interestitemssq003x interestitems3
rename interestitemssq004x interestitems4
rename interestitemssq005x interestitems5
rename interestitemssq006x interestitems6

label variable interestitems1	"How much you enjoy doing:Music"
label variable interestitems2	"How much you enjoy doing:Movies"
label variable interestitems3	"How much you enjoy doing:Books"
label variable interestitems4	"How much you enjoy doing:Following Sports"
label variable interestitems5	"How much you enjoy doing:Playing Games"
label variable interestitems6	"How much you enjoy doing:Outdoor Activities"
order interestitems1-interestitems6, after(interestitemssq006)
drop interestitemssq001-interestitemssq006
tab1 interestitems*



// usage degree
tab1 usagedegreesq001
rename usagedegreesq001 usagedegree
label variable usagedegree "Overall how would you characterize your use of your cell phone?"



// Plan purchasing
tab1 planpurchasingsq001-planpurchasingsq008
foreach v of varlist planpurchasingsq001-planpurchasingsq008 {
encode `v', gen(`v'x)
}
foreach v of varlist planpurchasingsq001x-planpurchasingsq008x {
recode `v' 1=0 2=1
label value `v' noyes
}

rename planpurchasingsq001x	 planpurchasing1
rename planpurchasingsq002x	 planpurchasing2
rename planpurchasingsq003x	 planpurchasing3
rename planpurchasingsq004x	 planpurchasing4
rename planpurchasingsq005x	 planpurchasing5
rename planpurchasingsq006x	 planpurchasing6
rename planpurchasingsq007x	 planpurchasing7
rename planpurchasingsq008x	 planpurchasing8
 
label variable planpurchasing1	"Do you own or plan on purchasing soon:Desktop computer"
label variable planpurchasing2	"Do you own or plan on purchasing soon:Laptop computer"
label variable planpurchasing3	"Do you own or plan on purchasing soon:iPad"
label variable planpurchasing4	"Do you own or plan on purchasing soon:Other tablet (e.g., Samsung Galaxy, Motorola Xoom, etc.)"
label variable planpurchasing5	"Do you own or plan on purchasing soon:EBook reader (e.g., Kindle, Nook, etc.)"
label variable planpurchasing6	"Do you own or plan on purchasing soon:Mp3 player (e.g., iPod, Zune, etc.)"
label variable planpurchasing7	"Do you own or plan on purchasing soon:Game system (e.g., Xbox, Wii, PlayStation, etc.)"
label variable planpurchasing8	"Do you own or plan on purchasing soon:Television"
order planpurchasing1-planpurchasing8, after(planpurchasingsq008)
drop planpurchasingsq001-planpurchasingsq008



// Computer use
tab1 computerusesq001
rename computerusesq001 computeruse



// Social Network
tab1 usefacebooksq001-usefacebooksq008
foreach v of varlist usefacebooksq001-usefacebooksq008 {
encode `v', gen(`v'x)
}
foreach v of varlist usefacebooksq001x-usefacebooksq008x {
recode `v' 1=0 2=1
label value `v' noyes
}

rename usefacebooksq001x usesocnetwork1
rename usefacebooksq002x usesocnetwork2
rename usefacebooksq003x usesocnetwork3
rename usefacebooksq004x usesocnetwork4
rename usefacebooksq005x usesocnetwork5
rename usefacebooksq006x usesocnetwork6
rename usefacebooksq007x usesocnetwork7
rename usefacebooksq008x usesocnetwork8

label variable usesocnetwork1	"Social networking services do you use:Facebook"
label variable usesocnetwork2	"Social networking services do you use:Twitter"
label variable usesocnetwork3	"Social networking services do you use:Google+"
label variable usesocnetwork4	"Social networking services do you use:MySpace"
label variable usesocnetwork5	"Social networking services do you use:Spotify"
label variable usesocnetwork6	"Social networking services do you use:LinkedIn"
label variable usesocnetwork7	"Social networking services do you use:Delicious"
label variable usesocnetwork8	"Social networking services do you use:Tumblir"
order usesocnetwork1-usesocnetwork8, after(usefacebooksq008)
drop usefacebooksq001-usefacebooksq008
rename usefacebookother usesocnetworkother

tab1 privacyfacebook
rename privacyfacebook fbprivacy


//Phone Functions
tab1 activityfun01-activityfun11
foreach v of varlist activityfun01-activityfun11 {
encode `v', gen(`v'x)
}
label define phonefunction 1 "Cell phone lacks the ability" 2 "Don't use this function" 3 "Once a month or less" 4 "A few times a month" 5 "A few times a week" 6 "About once a day" 7 "A few times a day" 8 "Throughout most of the day"
foreach v of varlist activityfun01x-activityfun11x {
recode `v' 1=7 2=4 3=5 4=6 5=1 6=2 7=3 8=8
label values `v' phonefunction
}
tab1 activityfun01x-activityfun11x

rename activityfun01x phoneuse1
rename activityfun02x phoneuse2
rename activityfun03x phoneuse3
rename activityfun04x phoneuse4
rename activityfun05x phoneuse5
rename activityfun06x phoneuse6
rename activityfun07x phoneuse7
rename activityfun08x phoneuse8
rename activityfun09x phoneuse9
rename activityfun10x phoneuse10
rename activityfun11x phoneuse11

label variable phoneuse1 "Making voice calls"
label variable phoneuse2 "Sending or replying to text messages"
label variable phoneuse3 "Reading or sending e-mails"
label variable phoneuse4 "Posting on Facebook or another social networking site(s)"
label variable phoneuse5 "Reading or sending tweets on Twitter"
label variable phoneuse6 "Shooting still pictures"
label variable phoneuse7 "Taking videos"
label variable phoneuse8 "Listening to music you have on your cell phone"
label variable phoneuse9 "Viewing videos (eg Youtube videos, TV programs"
label variable phoneuse10 "Playing games"
label variable phoneuse11 "Consulting a map or finding directions"
order phoneuse1-phoneuse11, after(activityfun11)
drop activityfun01-activityfun11
tab1 phoneuse1-phoneuse11

//Netsense Quiz Reactions

tab1 netsensequizzessq001
encode netsensequizzessq001, gen(netsensequizzessq001x)
label define quizreaction 1 "annoying" 2 "slightly annoying" 3 "no preference" 4 "slightly enjoyable" 5 "enjoyable"
recode netsensequizzessq001x 1=1 2=5 3=3 4=2 5=4
label values netsensequizzessq001x quizreaction
order netsensequizzessq001x, after(netsensequizzessq001)
rename netsensequizzessq001x quizreaction
drop netsensequizzessq001


//Religious Pref
tab1 religiouspref3
encode religiouspref3, gen(religiouspref3x)
label define religion 1 "Baptist" 2 "Buddhist" 3 "Church of Christ" 4 "Eastern Orthodox" 5 "Epicsopalian" 6 "Hindu" 7 "Jewish" 8 "LDS(Mormon" 9 "Lutheran" 10 "Methodist" 11 "Muslim" 12 "Presbyterian" 13 "Quaker" 14 "Roman Catholic" 15 "Seventh Day Adventist" 16 "United Church of Christ/Congregational" 17 "Other Christian" 18 "Other Religion" 19 "Atheist" 20 "Agnostic" 21 "None" 22 "Not Sure" 23 "Not applicable"
recode religiouspref3x 1=20 2=19 3=1 4=3 5=6 6=10 7=21 8=23 9=22 10=17 11=18 12=12 13=14
label values religiouspref3x religion
tab1 religiouspref3x
order religiouspref3x, after(religiouspref3)
drop religiouspref3
rename religiouspref3x selfrelig


//Professions
tab1 occupations1-occupations3
foreach v of varlist occupations1-occupations3 {
encode `v', gen(`v'x)
}
label define work 1 "Accountant or actuary" 2 "Actor or entertainer" 3 "Architect or urban planner" 4 "Artist" 5 "Business(clerical)" 6 "Business executive(management, administrator" 7 "Business owner or proprietor" 8 "Business salesperson or buyer" 9 "Clergy(minister, priest)" 10 "Clergy(other religious)" 11 "Clinical psychologist" 12 "College administrator/staff" 13 "College teacher" 14 "Computer programmer or analyst" 15 "Conservationest or forester" 16 "Dentists(including orthodontist)" 17 "Dietitian or nutritionist" 18 "Engineer" 19 "Farmer or rancher" 20 "Foreign service worker(including diplomat)" 21 "Homemaker(full-time)" 22 "Interior decorator(including designer)" 23 "Lab technician or hygienist" 24 "Law enforcement officer" 25 "Lawyer(attorney) or judge" 26 "Military service(career)" 27 "Nurse" 28 "Optometrist" 29 "Pharmacist" 30 "Physician" 31 "Policymaker/government" 32 "School counselor" 33 "School principal or superintendent" 34 "Scientific researcher" 35 "Social, welfare, or recreation worker" 36 "Therapist(physical, occupational, speech)" 37 "Teacher or administrator(elementary)" 38 "Teacher or administrator(secondary)" 39 "Veterinarian" 40 "Writer or journalist" 41 "Skilled trades" 42 "Laborer(unskilled)" 43 "Unemployed" 44 "Other" 45 "Undecided" 46 "Not sure" 47 "Not applicable"

recode occupations1x 1=1 2=4 3=5 4=6 5=7 6=8 7=11 8=12 9=13 10=14 11=16 12=18 13=21 14=22 15=23 16=42 17=25 18=47 19=46 20=27 21=44 22=29 23=30 24=31 25=32 26=34 27=38 28=37 29=36 30=43 31=40
label values occupations1x work
tab1 occupations1x
order occupations1x, after(occupations1)
drop occupations1
rename occupations1x occupationmom

recode occupations2x 1=1 2=3 3=5 4=6 5=7 6=8 7=9 8=10 9=11 10=13 11=14 12=16 13=18 14=19 15=20 16=21 17=23 18=42 19=25 20=26 21=47 22=46 23=44 24=30 25=31 26=33 27=34 28=41 29=35 30=37 31=45 32=43 33=40
label values occupations2x work
tab1 occupations2x
order occupations2x, after(occupations2)
drop occupations2
rename occupations2x occupationdad

recode occupations3x 1=1 2=3 3=5 4=6 5=7 6=11 7=12 8=14 9=18 10=19 11=23 12=42 13=25 14=47 15=46 16=44 17=30 18=31 19=33 20=34 21=38 22=45 23=43 24=40
label values occupations3x work
tab1 occupations3x
order occupations3x, after(occupations3)
drop occupations3
rename occupations3x occupationstudent


//Parents Marriage
tab1 parentsmarriage
encode parentsmarriage, gen(parentsmarriagex)
label define marriage 1 "Alive and living together" 2 "Alive, but divorced or living apart" 3 "One of them deceased" 4 "Both deceased"
recode parentsmarriagex 1=1 2=2 3=3
tab1 parentsmarriagex
order parentsmarriagex, after(parentsmarriage)
drop parentsmarriage
rename parentsmarriagex parentsmarriage


merge m:1 FirstName LastName using "M:\PentaWork\Data\filter files\student data file to merge - for margarets code.dta"
sort _merge

replace sender=5743671953 if netid=="ggonzal2"
replace sender=5743671670 if netid=="ksievers"
replace sender=5745407135 if netid=="jjenkin9"
replace sender=5743671896 if netid=="thosty"
replace sender=5743671908 if netid=="spaulso2"
replace sender=5745406660 if netid=="kdoughe2"
replace sender=5745143925 if netid=="cmccart9"
replace sender=5745407578 if netid=="mzhao1"
replace sender=5743671944 if netid=="ofurman"
replace sender=5743671944 if id==210
//^^Why isn't ln 16 working??
replace sender=5745403337 if netid=="mbuss1"
replace sender=5745407585 if netid=="mspear"
replace sender=5743671644 if netid=="bshanno2"
replace sender=5743671748 if netid=="bthoma11"
replace sender=5745407548 if netid=="ljosephs"
replace sender=5743671967 if netid=="vlam2"
replace sender=5745407529 if netid=="oeyeguok"
replace sender=5745407105 if netid=="abogucki"
replace sender=5745403495 if netid=="cwade@nd.edu"
replace sender=5745407143 if netid=="whallas"
replace sender=5745406891 if netid=="mkennell"
replace sender=5745407540 if netid=="twoodcoc"
replace sender=5745407531 if netid=="jronayne"
replace sender=5745407558 if netid=="mmurph33"
replace sender=5743671771 if netid=="avarela1"
replace sender=5745407589 if netid=="901702168"
replace sender=5743671702 if netid=="jrangel2"
replace sender=5745407554 if netid=="nbranch"
replace sender=5745407586 if netid=="901684343"
replace sender=5743671665 if netid=="mchang2"
replace sender=5743671703 if netid=="equinn5"
replace sender=5745407589 if netid=="bstalcup"
replace sender=5743671930 if netid=="tbowen1"
replace sender=5743671738 if netid=="jschult6"
replace sender=5745407567 if netid=="xlin3"
replace sender=5745407565 if netid=="mvonder1"
replace sender=5745407114 if netid=="Khoyer"
replace sender=5743671869 if netid=="aregalbu"
replace sender=5745407093 if netid=="mmarti25"
replace sender=5743671768 if netid=="jadams7"
replace sender=5745407557 if netid=="aboehm"
replace sender=5745407561 if netid=="akimbal1"
replace sender=5743671700 if netid=="stan3"

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
foreach var of varlist id-token _merge-openness {
rename `var' `var'_2
}




* This part is unique *
duplicates tag sender if sender!=., gen(duplicate)

tab duplicate

order completed_2 FirstName_2 LastName_2 duplicate
sort duplicate sender
edit 

replace duplicate=2 if id_2==99
replace duplicate=2 if id_2==112
replace duplicate=2 if id_2==55
replace duplicate=2 if id_2==100
replace duplicate=2 if id_2==145
replace duplicate=2 if id_2==14
replace duplicate=2 if id_2==190
replace duplicate=2 if id_2==105
replace duplicate=2 if id_2==51
replace duplicate=2 if id_2==84
replace duplicate=2 if id_2==210
replace duplicate=2 if id_2==88
replace duplicate=2 if id_2==109
replace duplicate=2 if id_2==128
replace duplicate=2 if id_2==91
replace duplicate=2 if id_2==165
replace duplicate=2 if id_2==189
*For Jackie Ronayne both observations are basically empty *
replace duplicate=2 if id_2==28
replace duplicate=2 if id_2==85
replace duplicate=2 if id_2==164
replace duplicate=2 if id_2==141
replace duplicate=2 if id_2==135
replace duplicate=2 if id_2==193
replace duplicate=2 if id_2==78
replace duplicate=2 if id_2==173 | id_2==161
replace duplicate=2 if id_2==198 | id_2==60 | id_2==205
replace duplicate=2 if id_2==57 | id_2==54 | id_2==160
replace duplicate=2 if id_2==167
replace duplicate=2 if id_2==19

replace duplicate=1 if id_2==207
replace duplicate=1 if id_2==214


* Coding Scheme *
* 0 No Duplicate
* 1 Duplicate- Most Complete Record 
* 2 Duplicate- Least Complete Record 




rename firstsemwork_2 semwork_2

rename firstsemclasses1_2 semclasses1_2
rename firstsemclasses2_2 semclasses2_2
rename firstsemclasses3_2 semclasses3_2
rename firstsemclasses4_2 semclasses4_2
rename firstsemclasses5_2 semclasses5_2
rename firstsemclasses6_2 semclasses6_2
rename firstsemclasses7_2 semclasses7_2

rename activityfirstsem1_2 activity1_2
rename activityfirstsem2_2 activity2_2
rename activityfirstsem3_2 activity3_2
rename activityfirstsem4_2 activity4_2
rename activityfirstsem5_2 activity5_2
rename activityfirstsem6_2 activity6_2
rename activityfirstsem7_2 activity7_2
rename activityfirstsem8_2 activity8_2
rename activityfirstsem9_2 activity9_2
rename activityfirstsem10_2 activity10_2
rename activityfirstsem11_2 activity11_2
rename activityfirstsem12_2 activity12_2
rename activityfirstsem13_2 activity13_2
rename activityfirstsem14_2 activity14_2

rename timeperweekactivita_2 timeperweekactivea_2
rename timeperweekactivitb_2 timeperweekactiveb_2
rename timeperweekactivitc_2 timeperweekactivec_2
rename timeperweekactivitd_2 timeperweekactived_2
rename timeperweekactivite_2 timeperweekactivee_2
rename timeperweekactivitf_2 timeperweekactivef_2
rename timeperweekactivitg_2 timeperweekactiveg_2
rename timeperweekactivith_2 timeperweekactiveh_2
rename timeperweekactiviti_2 timeperweekactivei_2
rename timeperweekactivitj_2 timeperweekactivej_2
rename timeperweekactivitk_2 timeperweekactivek_2
rename timeperweekactivitl_2 timeperweekactivel_2
rename timeperweekactivitm_2 timeperweekactivem_2
rename timeperweekactivitn_2 timeperweekactiven_2

save "M:\JoeWorkmanWork\Demographic Surveys\Winter 2012(W2) - Demographic Survey - 2014_01_31.dta", replace










