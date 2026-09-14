//SummerSurvey2013-Demographic Codes
set more off
label drop _all

insheet using "M:\JoeWorkmanWork\Summer 2013 Demographic Survey.csv", clear comma

//rename name variables
rename namenetidsq001 FirstName
rename namenetidsq002 LastName
rename namenetidsq003 netid

//recode spring2013work
tab1 spring2013work
encode spring2013work, gen(spring2013workx)
label define spring2013work 1 "None" 2 "0-4" 3 "5-10" 4 "11-15" 5 "16-20" 6 "21 or more"
recode spring2013workx 1=2 2=4 3=3 4=1
label values spring2013workx spring2013work
order spring2013workx, after(spring2013work)
drop spring2013work
rename spring2013workx spring2013work
label variable spring2013work "Hours worked per week in 2nd semester of college"
tab1 spring2013work



// clubs 1-14 are open ended so no need to recode yet
// first sem classes are open ended, and we need to determine what to do with those that are not all numerical before coding them

//Undergrad Major
tab undergradmajor
encode undergradmajor, gen(undergradmajorx)
label define undermaj 0 "(Other Fields) Undecided" 1 "(Arts and Humanities)" 2 "(Arts and Humanities) Art, fine and applied" 3 "(Arts and Humanities) English (language and literature)" 4 "(Arts and Humanities) History" 5 "(Arts and Humanities) Journalism" 6 "(Arts and Humanities) Language and Literature (except English)" 7 "(Arts and Humanities) Music" 8 "(Arts and Humanities) Philosophy" 9 "(Arts and Humanities) Speech" 10 "(Arts and Humanities)Theatre or Drama" 11 "(Arts and Humanities)Theology or Religion" 12 "(Arts and Humanities)Other Arts and Humanities" 13 "(Biological Sciences)" 14 "(Biological Sciences)Biology(general)" 15 "(Biological Sciences)Biochemistry or Biophysics" 16 "(Biological Sciences)Botany" 17 "(Biological Sciences)Environmental Science" 18 "(Biological Sciences)Marine (Life) Science" 19 "(Biological Sciences)Microbiology or Bacteriology" 20 "(Biological Sciences)Zoology" 21 "(Biological Sciences) Other Biological Science" 22 "(Business)" 23 "(Business)Accounting" 24 "(Business)Business Admin (general)" 25 "(Business)Finance" 26 "(Business)International Business" 27 "(Business)Marketing" 28 "(Business)Management" 29 "(Business)Secretarial Studies" 30 "(Business)Other Business" 31 "(Education)" 32 "(Education)Business Education" 33 "(Education)Elementary Education" 34 "(Education)Music or Art Education" 35 "(Education)Physical Education or Recreation" 36 "(Education)Secondary Education" 37 "(Education)Special Education" 38 "(Education)Other Education" 39 "(Engineering)" 40 "(Engineering)Aeronautical or Astronautical Eng" 41 "(Engineering)Civil Engineering" 42 "(Engineering)Chemical Engineering" 43 "(Engineering)Computer Science & Engineering" 44 "(Engineering)Electrical or Electronic Engineering" 45 "(Engineering) Industrial Engineering" 46 "(Engineering) Mechanical Engineering" 47 "(Engineering) Other Engineering" 48 "(Physical Science)" 49 "(Physical Science) Astronomy" 50 "(Physical Science) Atmospheric Science (incl. Meteorology)" 51 "(Physical Science) Chemistry" 52 "(Physical Science) Earth Science" 53 "(Physical Science) Marine Science (incl. Oceanography)" 54 "(Physical Science) Mathematics" 55 "(Physical Science) Physics" 56 "(Physical Science) Other Physical Science" 57 "(Professional)" 58 "(Professional) Architecture or Urban Planning" 59 "(Professional) Family and Consumer Sciences" 60 "(Professional) Health Technology (medical, dental, laboratory)" 61 "(Professional) Library or Archival Science" 62 "(Professional) Medicine, Dentistry, Veterinary Medicine" 63 "(Professional) Nursing" 64 "(Professional) Pharmacy" 65 "(Professional) Therapy (occupational, physical, speech)" 66 "(Professional) Other Professional" 67 "(Social Science)" 68 "(Social Science) Anthropology" 69 "(Social Science) Economics" 70 "(Social Science) Ethnic Studies" 71 "(Social Science) Geography" 72 "(Social Science) Political Sciences ( gov’t., international relations)" 73 "(Social Science) Psychology" 74 "(Social Science) Public Policy" 75 "(Social Science) Social Work" 76 "(Social Science) Sociology" 77 "(Social Science) Women’s Studies" 78 "(Social Science) Other Social Science" 79 "(Technical)" 80 "(Technical) Building Trades" 81 "(Technical) Data Processing or Computer Programming" 82 "(Technical) Drafting or Design" 83 "(Technical) Electronics" 84 "(Technical) Mechanics" 85 "(Technical) Other Technical" 86 "(Other Fields)" 87 "(Other Fields) Agriculture" 88 "(Other Fields) Communications" 89 "(Other Fields) Forestry" 90 "(Other Fields) Kinesiology" 91 "(Other Fields) Law Enforcement" 92 "(Other Fields) Military Science" 
recode undergradmajorx 1=2 2=3 3=4 4=5 5=6 6=7 7=12 8=8 9=11 10=15 11=14 12=17 13=23 14=24 15=25 16=26 17=28 18=27 19=40 20=42 21=41 22=43 23=44 24=46 25=47 26=0 27=51 28=54 29=55 30=58 31=60 32=62 33=65 34=68 35=69 36=72 37=73 38=76
label values undergradmajorx undermaj
tab1 undergradmajorx, mis
order undergradmajorx, after(undergradmajor)
drop undergradmajor
rename undergradmajorx major 

//Weight
tab1 weight
label variable weight "Weight in pounds"

//health
tab1 health
encode health, gen(healthx)
tab1 health healthx, nolab
recode healthx 1=4 2=3 3=2 4=1
tab1 health healthx, nolab
label define health 4 "Excellent" 3 "Good"  2 "Fair" 1 "Poor"
label value healthx health
label variable healthx "Would you say your own health in general is:"
tab1 health healthx
order healthx, after(health)
drop health
rename healthx health


// happiness
tab1 happiness
encode happiness, gen(happinessx)
label define happiness 5 "Very Happy" 4 "Pretty Happy" 3 "Happy" 2 "Not so happy" 1 "Not happy at all" 0 "Not sure"
recode happinessx 1=3 2=1 3=2 4=4 5=5
label value happinessx happiness
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
//*Recode R questions
foreach v of varlist iamsomeonewho2x iamsomeonewho6x iamsomeonewho8x iamsomeonewho9x iamsomeonewho12x iamsomeonewho18x iamsomeonewho21x iamsomeonewho23x iamsomeonewho24x iamsomeonewho27x iamsomeonewho31x iamsomeonewho34x iamsomeonewho35x {
recode `v' 1=5 2=4 3=3 4=2 5=1
label value `v' iam
}
order iamsomeonewho1x-iamsomeonewho44x, after(iamsomeonewho44)
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

//Well-being index
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




// Activities in the second semester
tab1 activityspring2013*
foreach v of varlist activityspring20131-activityspring201314{
encode `v', gen(`v'x)
}
label define activities 0 "Not at all" 1 "Less than 1-2 Times a month"  2 "1-2 Times a month" 3 "1-2 Times a week" 4 "Everyday or almost everyday"
foreach v of varlist activityspring20131x-activityspring201314x {
recode `v' 1=2 2=3 3=4 4=1 5=0
label value `v' activities
}
tab1 activityspring20131x-activityspring201314x
order activityspring20131x-activityspring201314x, after(activityspring201314)
drop activityspring20131-activityspring201314
rename activityspring20131x activityspring20131
rename activityspring20132x activityspring20132
rename activityspring20133x activityspring20133 
rename activityspring20134x activityspring20134
rename activityspring20135x activityspring20135
rename activityspring20136x activityspring20136
rename activityspring20137x activityspring20137
rename activityspring20138x activityspring20138
rename activityspring20139x activityspring20139
rename activityspring201310x activityspring201310
rename activityspring201311x activityspring201311
rename activityspring201312x activityspring201312
rename activityspring201313x activityspring201313
rename activityspring201314x activityspring201314
 
label variable activityspring20131	"Attended a religious service"
label variable activityspring20132	"Demonstrated for a cause"
label variable activityspring20133	"Smoked a cigarette"
label variable activityspring20134	"Drank beer"
label variable activityspring20135	"Drank wine or liquor"
label variable activityspring20136	"Exercised"
label variable activityspring20137	"Felt overwhelmed by all I had to do"
label variable activityspring20138	"Felt depressed"
label variable activityspring20139	"Performed volunteer work"
label variable activityspring201310	"Socialized with someone of another racial/ethnic group"
label variable activityspring201311	"Discussed religion"
label variable activityspring201312	"Discussed politics"
label variable activityspring201313	"Worked on a local, state, or national political campaign"
label variable activityspring201313	"Publicly communicated my opinion about a cause (blog, email, petition)"


// Second semester Activity
tab1 spring2013hractivita-spring2013hractivitn
foreach v of varlist spring2013hractivita-spring2013hractivitn {
encode `v', gen(`v'1)
}
label define spring2013act 0 "None" 1 "Less than half an hour" 2 "1-2 hours" 3 "3-5 hours" 4 "6-10 hours" 5 "11-15 hours" 6 "16-20 hours" 7 "Over 20"
tab1 spring2013hractivita1
recode spring2013hractivita1 1=2 2=5 3=6 4=3 5=4 6=7
label value spring2013hractivita1 spring2013act

tab1 spring2013hractivitb1
recode spring2013hractivitb1 1=2 2=5 3=6 4=3 5=4 6=1 7=7
label value spring2013hractivitb1 spring2013act

tab1 spring2013hractivitc1 spring2013hractiviti1 spring2013hractivitm1 spring2013hractivitn1
foreach v of varlist spring2013hractivitc1 spring2013hractiviti1 spring2013hractivitm1 spring2013hractivitn1 {
recode `v' 1=2 2=5 3=6 4=3 5=4 6=1 7=0 8=7
label value `v' spring2013act
} 

tab1 spring2013hractivitd1 spring2013hractivitg1
foreach v of varlist spring2013hractivitd1 spring2013hractivitg1 {
recode `v' 1=2 2=5 3=6 4=3 5=4 6=1 7=0
label value `v' spring2013act
}

tab1 spring2013hractivite1 spring2013hractivitf1 spring2013hractivith1 spring2013hractivitk1
foreach v of varlist spring2013hractivite1 spring2013hractivitf1 spring2013hractivith1 spring2013hractivitk1  {
recode `v' 1=2 2=5 3=3 4=4 5=1 6=0
label value `v' spring2013act 
}

tab1 spring2013hractivitj1
recode spring2013hractivitj1 1=2 2=3 3=1 4=0
label value spring2013hractivitj1 spring2013act
 
tab1 spring2013hractivitl1
recode spring2013hractivitl1 1=2 2=5 3=3 4=4 5=1 6=0
label value spring2013hractivitl1 spring2013act

tab1 spring2013hractivita*
tab1 spring2013hractivitb*
tab1 spring2013hractivitc*
tab1 spring2013hractivitd*
tab1 spring2013hractivite*
tab1 spring2013hractivitf*
tab1 spring2013hractivitg*
tab1 spring2013hractivith*
tab1 spring2013hractiviti*
tab1 spring2013hractivitj*
tab1 spring2013hractivitk*
tab1 spring2013hractivitl*
tab1 spring2013hractivitm*
tab1 spring2013hractivitn*
order spring2013hractivita1-spring2013hractivitn1, after(spring2013hractivitn)
drop spring2013hractivita-spring2013hractivitn
rename spring2013hractivita1 timeperweekactivita
rename spring2013hractivitb1 timeperweekactivitb
rename spring2013hractivitc1 timeperweekactivitc
rename spring2013hractivitd1 timeperweekactivitd
rename spring2013hractivite1 timeperweekactivite
rename spring2013hractivitf1 timeperweekactivitf
rename spring2013hractivitg1 timeperweekactivitg
rename spring2013hractivith1 timeperweekactivith
rename spring2013hractiviti1 timeperweekactiviti
rename spring2013hractivitj1 timeperweekactivitj
rename spring2013hractivitk1 timeperweekactivitk
rename spring2013hractivitl1 timeperweekactivitl
rename spring2013hractivitm1 timeperweekactivitm
rename spring2013hractivitn1 timeperweekactivitn
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
label define importance 0 "Not Important" 1 "Somewhat important" 2 "Very important" 3 "Essential"
foreach v of varlist importance* {
encode `v', gen(`v'x)
}
foreach v of varlist importance1x-importance16x {
recode `v' 1=3 2=0 3=1 4=2
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
label define guess 0 "No chance" 1 "Very little chance" 2 "Some chance" 3 "Very good chance" 4 "Have already done"
foreach v of varlist guesschance* {
encode `v', gen(`v'x)
}
foreach v of varlist guesschance1x-guesschance14x {
recode `v' 1=4 2=0 3=2 4=3 5=1
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

// attitudes START HERE MARGARET :)

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
label define gaymar 0 "Not Sure" 1 "Strongly disagree" 2 "Disagree" 3 "Neither agree nor disagree" 4 "Agree" 5 "Strongly agree"
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


//Cultural Events Was Here in SummerSurvey12

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

// Interest items
tab1 interestitemssq001-interestitemssq006
// 2 and 5 are different than rest
foreach v of varlist interestitemssq001-interestitemssq006 {
encode `v', gen(`v'x)
}
label define interest 0 "Not Sure" 1 "Not at all" 2 "Not that much" 3 "Somewhat" 4 "Very much"
foreach v of varlist interestitemssq001x interestitemssq003x interestitemssq004x interestitemssq006x {
label value `v' interest
}
recode interestitemssq002x 1=2 2=3 3=4
label value interestitemssq002x interest

recode interestitemssq005x 1=1 2=0 3=2 4=3 5=4
label value interestitemssq005x interest
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



//Use Facebook info was here in SummerSurvey2012

//NetSense Quizzes was here in SummerSurvey2012

//Religious Pref
tab1 religiouspref3
encode religiouspref3, gen(religiouspref3x)
label define religion 1 "Baptist" 2 "Buddhist" 3 "Church of Christ" 4 "Eastern Orthodox" 5 "Epicsopalian" 6 "Hindu" 7 "Jewish" 8 "LDS(Mormon" 9 "Lutheran" 10 "Methodist" 11 "Muslim" 12 "Presbyterian" 13 "Quaker" 14 "Roman Catholic" 15 "Seventh Day Adventist" 16 "United Church of Christ/Congregational" 17 "Other Christian" 18 "Other Religion" 19 "Atheist" 20 "Agnostic" 21 "None" 22 "Not Sure" 23 "Not applicable"
recode religiouspref3x 1=20 2=19 3=1 4=2 5=6 6=10 7=21 8=23 9=22 10=17 11=18 12=14 
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


order netid _merge sender



replace sender=5743671665 if netid=="mchang2"
*double*
replace sender=5743671907 if netid=="mrauh1"
replace sender=5745407545 if netid=="jschne11"
replace sender=5743671693 if netid=="mmcnanna"
replace sender=5743671738 if netid=="jschult6"
replace sender=5745407541 if netid=="abarnes4"
replace sender=5743671896 if netid=="thosty"
replace sender=5743671793 if netid=="cshort1"
replace sender=5743671513 if netid=="mconlin"
* These are carried over from Margaret's Earlier work *
replace sender=5745407540 if netid=="twoodcoc"
replace sender=5745407557 if netid=="aboehm"
replace sender=5745407105 if netid=="abogucki"
replace sender=5743671729 if netid=="csyta"

replace sender=5743671935 if netid=="mbuche"
replace sender=5743671544 if netid=="sdriscol"
replace sender=5745406425 if netid=="bmille16"
replace sender=5743671732 if netid=="Gdenis"
replace sender=5743671873 if netid=="espesia"
*double*
replace sender=5743671855 if netid=="amendoz3"
replace sender=5743671704 if netid=="tklinker"
replace sender=5745143925 if netid=="cmccart9"
replace sender=5743671869 if netid=="aregalbu"
replace sender=5743671670 if netid=="ksievers"
replace sender=5745407566 if netid=="jzhang10"
replace sender=5745407563 if netid=="Mholsin1"
replace sender=5745407536 if netid=="iamegash"
replace sender=5745407589 if netid=="bstalcup"


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


//*Add Suffix to Variables**//
foreach var of varlist id-token _merge-openness {
rename `var' `var'_6
}

duplicates tag sender if sender!=., gen(duplicate)

tab duplicate

order completed_6 FirstName_6 LastName_6 duplicate id_6
sort duplicate sender
edit 

replace duplicate=2 if id_6==58
replace duplicate=2 if id_6==52
replace duplicate=2 if id_6==74
replace duplicate=2 if id_6==109
replace duplicate=2 if id_6==40
replace duplicate=2 if id_6==148
replace duplicate=2 if id_6==35
replace duplicate=2 if id_6==63
replace duplicate=2 if id_6==161
replace duplicate=2 if id_6==51
* Both observations for Erica Mitchell are complete; I designated the first one to be dropped *
replace duplicate=2 if id_6==53
replace duplicate=2 if id_6==89
replace duplicate=2 if id_6==27
replace duplicate=1 if id_6==81



*** Add in Stems for wave 6 ***
rename spring2013work_6 semwork_6

rename fourthsemclasses1_6 semclasses1_6
rename fourthsemclasses2_6 semclasses2_6
rename fourthsemclasses3_6 semclasses3_6
rename fourthsemclasses4_6 semclasses4_6
rename fourthsemclasses5_6 semclasses5_6
rename fourthsemclasses6_6 semclasses6_6
rename fourthsemclasses7_6 semclasses7_6

rename activityspring20131_6 activity1_6
rename activityspring20132_6 activity2_6
rename activityspring20133_6 activity3_6
rename activityspring20134_6 activity4_6
rename activityspring20135_6 activity5_6
rename activityspring20136_6 activity6_6
rename activityspring20137_6 activity7_6
rename activityspring20138_6 activity8_6
rename activityspring20139_6 activity9_6
rename activityspring201310_6 activity10_6
rename activityspring201311_6 activity11_6
rename activityspring201312_6 activity12_6
rename activityspring201313_6 activity13_6
rename activityspring201314_6 activity14_6

rename timeperweekactivita_6 timeperweekactivea_6
rename timeperweekactivitb_6 timeperweekactiveb_6
rename timeperweekactivitc_6 timeperweekactivec_6
rename timeperweekactivitd_6 timeperweekactived_6
rename timeperweekactivite_6 timeperweekactivee_6
rename timeperweekactivitf_6 timeperweekactivef_6
rename timeperweekactivitg_6 timeperweekactiveg_6
rename timeperweekactivith_6 timeperweekactiveh_6
rename timeperweekactiviti_6 timeperweekactivei_6
rename timeperweekactivitj_6 timeperweekactivej_6
rename timeperweekactivitk_6 timeperweekactivek_6
rename timeperweekactivitl_6 timeperweekactivel_6
rename timeperweekactivitm_6 timeperweekactivem_6
rename timeperweekactivitn_6 timeperweekactiven_6

rename extraversion extraversion_6
rename agreeableness agreeableness_6
rename conscientiousness conscientiousness_6
rename neuroticism neuroticism_6
rename openness openness_6

rename homosexual1_6 homosexual_6
rename premaritalsex1_6 premaritalsex_6
rename fswelfare1_6 fswelfare_6
rename fssocsec1_6 fssocsec_6
rename lesseq1_6 lesseq_6
rename toomucheqrights1_6 toomucheqrights_6
rename eqchances1_6 eqchances_6


save "M:\JoeWorkmanWork\Demographic Surveys\Summer 2013(W6) - Demographic Survey - 2014_01_31.dta", replace
