agedataset<-read.csv("AgeSTBforR.csv")
edudataset<-read.csv("EduSTBforR.csv")
unitdataset<-read.csv("UnitSTBforR.csv", sep = ",")

econdemographic<-read.csv("econdemographic.csv")
econdemographic = subset(econdemographic, Year != "2008" &  Year != "2009" & Year != "2010" & Year != "2011" & Year != "2012" & Year != "2013")

names(agedataset)[1] = "Year"
names(unitdataset)[1] = "Year"
agemerged = merge(agedataset, econdemographic, by = c("Year", "Province"))
edumerged = merge(edudataset, econdemographic, by = c("Year", "Province"))
unitmerged = merge(unitdataset, econdemographic, by = c("Year", "Province"))

#write.csv(agemerged, "AgeEconforTableau.csv")
#write.csv(edumerged, "EduEconforTableau.csv")
#write.csv(unitmerged, "UnitEconforTableau.csv")

ageunder30 = plm(age.30.or..below ~ urbanarea+No.of.above.size.industrial.companies+public.expenditure + GDP + GDPperCapita,
              data = agemerged, index = c("Year", "Province"), 
              model="within", effect="twoway")
age3035 = plm(agemerged$X30.35 ~ agemerged$urbanarea+agemerged$No.of.above.size.industrial.companies+agemerged$public.expenditure + agemerged$GDP + agemerged$GDPperCapita,
                 data = agemerged, index = c("Year", "Province"), 
                 model="within", effect="twoway")
age3640 = plm(agemerged$X36.40 ~ agemerged$urbanarea+agemerged$No.of.above.size.industrial.companies+agemerged$public.expenditure + agemerged$GDP + agemerged$GDPperCapita,
                 data = agemerged, index = c("Year", "Province"), 
                 model="within", effect="twoway")
age4145 = plm(agemerged$X41.45 ~ agemerged$urbanarea+agemerged$No.of.above.size.industrial.companies+agemerged$public.expenditure + agemerged$GDP + agemerged$GDPperCapita,
                 data = agemerged, index = c("Year", "Province"), 
                 model="within", effect="twoway")
age4650 = plm(agemerged$X46.50 ~ agemerged$urbanarea+agemerged$No.of.above.size.industrial.companies+agemerged$public.expenditure + agemerged$GDP + agemerged$GDPperCapita,
                 data = agemerged, index = c("Year", "Province"), 
                 model="within", effect="twoway")
age5154 = plm(agemerged$X51.54 ~ agemerged$urbanarea+agemerged$No.of.above.size.industrial.companies+agemerged$public.expenditure + agemerged$GDP + agemerged$GDPperCapita,
              data = agemerged, index = c("Year", "Province"), 
              model="within", effect="twoway")
age5559 = plm(agemerged$X55.59 ~ agemerged$urbanarea+agemerged$No.of.above.size.industrial.companies+agemerged$public.expenditure + agemerged$GDP + agemerged$GDPperCapita,
              data = agemerged, index = c("Year", "Province"), 
              model="within", effect="twoway")
age60above = plm(agemerged$X60.or.above ~ agemerged$urbanarea+agemerged$No.of.above.size.industrial.companies+agemerged$public.expenditure + agemerged$GDP + agemerged$GDPperCapita,
              data = agemerged, index = c("Year", "Province"), 
              model="within", effect="twoway")

eduPostGrad = plm(edumerged$post.graduate ~ edumerged$urbanarea + edumerged$No.of.above.size.industrial.companies + edumerged$public.expenditure + edumerged$GDP + edumerged$GDPperCapita,
                  data = edumerged, index = c("Year", "Province"), model = "within", effect = "twoway")
eduBachelor = plm(edumerged$Bachelor.s.degree ~ edumerged$urbanarea + edumerged$No.of.above.size.industrial.companies + edumerged$public.expenditure + edumerged$GDP + edumerged$GDPperCapita,
                  data = edumerged, index = c("Year", "Province"), model = "within", effect = "twoway")
eduOtherPostSecondary = plm(edumerged$Other.post.secondary ~ edumerged$urbanarea + edumerged$No.of.above.size.industrial.companies + edumerged$public.expenditure + edumerged$GDP + edumerged$GDPperCapita,
                  data = edumerged, index = c("Year", "Province"), model = "within", effect = "twoway")
eduTechnical = plm(edumerged$Technical.college ~ edumerged$urbanarea + edumerged$No.of.above.size.industrial.companies + edumerged$public.expenditure + edumerged$GDP + edumerged$GDPperCapita,
                  data = edumerged, index = c("Year", "Province"), model = "within", effect = "twoway")
eduHighSchool = plm(edumerged$High.School.and.other.secondary.school ~ edumerged$urbanarea + edumerged$No.of.above.size.industrial.companies + edumerged$public.expenditure + edumerged$GDP + edumerged$GDPperCapita,
                  data = edumerged, index = c("Year", "Province"), model = "within", effect = "twoway")
eduJuniorHigh = plm(edumerged$Junior.high.or.lower ~ edumerged$urbanarea + edumerged$No.of.above.size.industrial.companies + edumerged$public.expenditure + edumerged$GDP + edumerged$GDPperCapita,
                  data = edumerged, index = c("Year", "Province"), model = "within", effect = "twoway")

unitAdmin = plm(unitmerged$Administrative.units ~ unitmerged$GDP + unitmerged$urbanarea+unitmerged$No.of.above.size.industrial.companies + unitmerged$public.expenditure + unitmerged$GDPperCapita,
                data = unitmerged, index = c("Year", "Province"), model = "within", effect = "twoway")
unitDAEAdmin = plm(unitmerged$Directly..affiliated.admin.units ~ unitmerged$GDP + unitmerged$urbanarea+unitmerged$No.of.above.size.industrial.companies + unitmerged$public.expenditure + unitmerged$GDPperCapita,
                data = unitmerged, index = c("Year", "Province"), model = "within", effect = "twoway")
unitDAENonAdmin = plm(unitmerged$Directly.affiliated.non.admin.units~ unitmerged$GDP + unitmerged$urbanarea+unitmerged$No.of.above.size.industrial.companies + unitmerged$public.expenditure + unitmerged$GDPperCapita,
                data = unitmerged, index = c("Year", "Province"), model = "within", effect = "twoway")
unitTax = plm(unitmerged$Tax.Offices..branch.buraus. ~ unitmerged$GDP + unitmerged$urbanarea+unitmerged$No.of.above.size.industrial.companies + unitmerged$public.expenditure + unitmerged$GDPperCapita,
                data = unitmerged, index = c("Year", "Province"), model = "within", effect = "twoway")

