use vote.dta

reg cvote clinexp clchexp cincshr

gen votediff = vote90 - vote88
gen incshrdiff = inchshr90 - incshr88
gen linexpdiff = linexp90 - linexp88
gen lchexpeiff = lchexp90 - lchexp88


reg votediff linexpdiff lchexpdiff incshrdiff

test linexpdiff lchexpdiff

reg votediff incshrdiff

reg votediff incshrdiff if rptchall == 1

clear 

use countymurders.dta

sum murdrate

reg murdrate execs l.execs percblack percmale perc1019 perc2029

reg d.murdrate d.execs d.l.execs d.percblack d.percmale d.perc1019 d.perc2029, cluster(countyid)

clear 

use crime4.dta

xtset county year

xtreg lcrmrte d82-d87 lprbarr lprbconv lprbpris lavgsen lpolpc, fe

xtreg lcrmrte d82-d87 lprbarr lprbconv lprbpris lavgsen lpolpc lwcon lwfed lwfir lwloc lwmfg lwser lwsta lwtrd lwtuc, fe

test lwcon lwfed lwfir lwloc lwmfg lwser lwsta lwtrd lwtuc

clear

use AIRFARE.dta

reg lfare i.year concen c.ldist##c.ldist

reg lfare i.year concen c.ldist##c.ldist, cluster(id)

xtreg lfare i.year concen c.ldist##c.ldist

xtreg lfare i.year concen c.ldist##c.ldist, fe

clear 

use 401ksubs.dta

reg pira p401k c.inc##c.inc c.age##c.age

reg p401k e401k c.inc##c.inc c.age##c.age, robust

ivregress 2sls pira c.inc##c.inc c.age##c.age (p401k = e401k), robust

predict residuals, residuals
reg pira p401k residuals c.inc##c.inc c.age##c.age, robust

clear

use Catholic.dta

count
count if cathhs == 1

reg math12 cathhs lfaminc motheduc fatheduc

reg cathhs parcath lfaminc motheduc fatheduc

ivreg math12 lfaminc motheduc fatheduc (cathhs = parcath)

gen cathmoth = cathhs * motheduc

reg cathmoth parcath#c.motheduc lfaminc motheduc fatheduc

reg cathhs parcath lfaminc motheduc fatheduc

predict residuals, residuals

reg math12 cathhs residuals lfaminc motheduc fatheduc

egen mothmean = mean(motheduc)
gen cathmom = cathhs * (motheduc - mothmean)
gen parmom = parcath * (motheduc - mothmean)

ivreg math12 lfaminc motheduc fatheduc (cathmom cathhs = parmom parcath)

clear

use mroz.dta

ivreg lwage exper expersq (educ = motheduc fatheduc)

reg educ motheduc fatheduc exper expersq if lwage != .

predict residuals, residuals
reg lwage educ residuals exper expersq

ivreg lwage exper expersq (educ = motheduc fatheduc)

reg residuals motheduc fatheduc exper expersq








