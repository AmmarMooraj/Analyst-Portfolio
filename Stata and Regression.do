*The below file demonstrates my familiarity with Stata, regressions, and hypothesis testing. 

use "C:\Users\ammar\Downloads\PSIDextract.dta"

*Summary statistics
summarize
describe

*Rename your variables
rename ed education
rename wks weeks
rename ms married
label variable union "=1 if wage set by a union contract"

* Tabulate the variable education
tabulate education

*keep individuals that are older than 17 and younger than 66
keep if age>17 & age<66

*Transform some of my variables
gen lwage=log(wage)
gen exp2=exp^2

*Estimate a Mincer equation
regress lwage exp exp2 education
regress lwage exp exp2 education ind occ south  

*Test if married men have higher wages
generate male=1-fem
tab male fem
gen marriedmale=male*married

regress lwage exp exp2 education married male marriedmale
estimates store ols, title(OLS)
test married + marriedmale=0


*Use robust standard errors

regress lwage exp exp2 education married male marriedmale, vce(robust)
estimates store olsRobust, title(OLSRobust)
