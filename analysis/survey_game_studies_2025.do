********************************************************************************
*** HEADER                                                                   ***
********************************************************************************
version 19.5

set more off, permanently
set scheme white_hue /* ssc install schemepack, replace */


********************************************************************************
*** WISSENSCHAFTLICHER HINTERGRUND                                           ***
********************************************************************************
use "data_game_studies_num.dta", clear


/* Sind Sie Mitglied im AKGWDS? */
/* Einfachauswahl */
label define whakgwds_lb 0 "Nein" 1 "Ja"
   label values whakgwds whakgwds_lb

tab whakgwds

graph pie, over(whakgwds) missing ///
   pie(_all, explode) ///
   pie(3, color("150 150 150")) ///
   plabel(_all sum, size(*1.5)) ///
   title(AKGWDS) ///
   legend(order(1 "Nein" 2 "Ja" 3 "Keine Antwort")) ///
   name(akgwds, replace)
graph export akgwds.pdf, replace


/* In welchem Kontext haben Sie die methodischen Ansätze, die Sie in Ihrer Forschung außerhalb der Game Studies verwenden, erlernt? */
/* Mehrfachauswahl */
gen whkontexterlernt1neu = .
   replace whkontexterlernt1neu = 1 if whkontexterlernt1 == "Y"

gen whkontexterlernt2neu = .
   replace whkontexterlernt2neu = 1 if whkontexterlernt2 == "Y"

gen whkontexterlernt3neu = .
   replace whkontexterlernt3neu = 1 if whkontexterlernt3 == "Y"

gen whkontexterlernt4neu = .
   replace whkontexterlernt4neu = 1 if whkontexterlernt4 == "Y"

gen whkontexterlerntotherneu = .
   replace whkontexterlerntotherneu = 1 if whkontexterlerntother == "Y"

graph hbar (sum) whkontexterlernt1neu ///
           (sum) whkontexterlernt2neu ///
           (sum) whkontexterlernt3neu ///
           (sum) whkontexterlernt4neu ///
           (sum) whkontexterlerntotherneu, ///
           blabel(total) ///
           title(Kontext) ///
           legend(order(1 "Bachelorstudium" 2 "Masterstudium" 3 "Promotionsstudium" 4 "Selbststudium" 5 "Sonstiges")) ///
           name(whkontext, replace)
graph export whkontext.pdf, replace


/* In welcher akademischen Rolle befinden Sie sich derzeit? */
/* Einfachauswahl */
replace whrolle = "8" if whrolle == "-oth-"

destring whrolle, generate(whrolleneu)

label define whrolleneu_lb ///
   1 "Student:in" ///
   2 "Promovierende:r" ///
   3 "Lehrbeauftragte:r/Dozent:in" ///
   4 "Wissenschaftliche:r Mitarbeiter:in" ///
   5 "Juniorprofessor:in" ///
   6 "Professor:in" ///
   7 "Externe:r Forscher:in" ///
   8 "Sonstiges"
   label values whrolleneu whrolleneu_lb

tab whrolleneu

tab whrolleneu severtraut, chi
tab whrolleneu setradition, chi
tab whrolleneu seetabliert, chi
tab whrolleneu segebraeuchlich, chi

graph pie, over(whrolleneu) missing ///
   pie(_all, explode) ///
   pie(8, color("150 150 150")) ///
   plabel(_all sum, size(*1.5)) ///
   title(Rolle) ///
   legend(order(1 "Student:in" 2 "Promovierende:r" 3 "Lehrbeauftragte:r/Dozent:in" 4 "Wissenschaftliche:r Mitarbeiter:in" 5 "Professor:in" 6 "Externe:r Forscher:in" 7 "Sonstiges" 8 "Keine Antwort")) ///
   name(rolle, replace)
graph export rolle.pdf, replace


/* Sind Sie aktuell oder waren Sie innerhalb der letzten zwölf Monate in einem wissenschaftlichen Kontext angestellt? */
/* Einfachauswahl */
label define whanstellung_lb ///
   0 "Nein" ///
   1 "Ja"
   label values whanstellung whanstellung_lb

tab whanstellung

graph pie, over(whanstellung) missing ///
   pie(_all, explode) ///
   pie(3, color("150 150 150")) ///
   plabel(_all sum, size(*1.5)) ///
   title(Anstellung) ///
   legend(order(1 "Nein" 2 "Ja" 3 "Keine Antwort")) ///
   name(anstellung, replace)
graph export anstellung.pdf, replace


/* Geben Sie bitte an, wie sich Ihre Aufgaben ungefähr prozentual auf folgende Bereiche aufteilen (bzw. zuletzt aufgeteilt haben). */
preserve
   reshape long whprozent, i(id) j(whbereich)

   label define whbereich_lb ///
      1 "Forschung" ///
      2 "Lehre" ///
      3 "Administratives"
      label values whbereich whbereich_lb

   graph box whprozent, over(whbereich) ///
      title("Aufteilung der Aufgaben") ///
      ytitle("Prozent") ///
      ylabel(0(20)100) ///
      graphregion(color(white)) ///
      name(aufteilung, replace)
   graph export aufteilung.pdf, replace
restore

sum whprozent1, detail
sum whprozent2, detail
sum whprozent3, detail


/* Sind Sie derzeit befristet oder unbefristet angestellt? */
/* Einfachauswahl */
label define whbefristung_lb ///
   1 "Befristet" ///
   2 "Unbefristet" ///
   3 "Unbefristet mit Sonderkündigungsschutz"
   label values whbefristung whbefristung_lb

tab whbefristung

graph pie, over(whbefristung) missing ///
   pie(_all, explode) ///
   pie(4, color("150 150 150")) ///
   plabel(_all sum, size(*1.5)) ///
   title(Befristung) ///
   legend(order(1 "Befristet" 2 "Unbefristet" 3 "Unbefristet mit Sonderkündigungsschutz" 4 "Keine Antwort")) ///
   name(befristung, replace)
graph export befristung.pdf, replace


********************************************************************************
*** GAME STUDIES                                                             ***
********************************************************************************
use "data_game_studies_num.dta", clear


/* In welchem Kontext haben Sie diese methodischen Ansätze erlernt? */
/* Mehrfachauswahl */
gen gserlernt1neu = .
   replace gserlernt1neu = 1 if gserlernt1 == "Y"

gen gserlernt2neu = .
   replace gserlernt2neu = 1 if gserlernt2 == "Y"

gen gserlernt3neu = .
   replace gserlernt3neu = 1 if gserlernt3 == "Y"

gen gserlernt4neu = .
   replace gserlernt4neu = 1 if gserlernt4 == "Y"

gen gserlerntotherneu = .
   replace gserlerntotherneu = 1 if gserlerntother == "Y"

gen kontext1 = .
   replace kontext1 = 1 if gserlernt1neu == 1
   replace kontext1 = 2 if gserlernt2neu == 1
   replace kontext1 = 3 if gserlernt3neu == 1
   replace kontext1 = 4 if gserlernt4neu == 1
   replace kontext1 = 5 if gserlerntotherneu == 1
   
graph hbar (sum) gserlernt1neu ///
           (sum) gserlernt2neu ///
           (sum) gserlernt3neu ///
           (sum) gserlernt4neu ///
           (sum) gserlerntotherneu, ///
           blabel(total) ///
           title(Kontext) ///
           legend(order(1 "Bachelorstudium" 2 "Masterstudium" 3 "Promotionsstudium" 4 "Selbststudium" 5 "Sonstiges")) ///
           name(gskontext, replace)
graph export gskontext.pdf, replace

gen whkontexterlernt1neu = .
   replace whkontexterlernt1neu = 1 if whkontexterlernt1 == "Y"

gen whkontexterlernt2neu = .
   replace whkontexterlernt2neu = 1 if whkontexterlernt2 == "Y"

gen whkontexterlernt3neu = .
   replace whkontexterlernt3neu = 1 if whkontexterlernt3 == "Y"

gen whkontexterlernt4neu = .
   replace whkontexterlernt4neu = 1 if whkontexterlernt4 == "Y"

gen whkontexterlerntotherneu = .
   replace whkontexterlerntotherneu = 1 if whkontexterlerntother == "Y"

gen kontext2 = .
   replace kontext2 = 1 if whkontexterlernt1neu == 1
   replace kontext2 = 2 if whkontexterlernt2neu == 1
   replace kontext2 = 3 if whkontexterlernt3neu == 1
   replace kontext2 = 4 if whkontexterlernt4neu == 1
   replace kontext2 = 5 if whkontexterlerntotherneu == 1

preserve
   reshape long kontext, i(id) j(bereich)

   mlogit kontext i.bereich, cluster(id)
restore


********************************************************************************
*** SELBSTEINSCHAETZUNG                                                      ***
********************************************************************************
use "data_game_studies_num.dta", clear


/* Wie schätzen Sie Ihr eigenes methodisches Vorgehen in den Game Studies ein? */
/* Einfachauswahl */
label define setradition_lb ///
   1 "Sehr unorthodox" ///
   2 "Eher unorthodox" ///
   3 "Eher traditionell" ///
   4 "Sehr traditionell"
   label values setradition setradition_lb

tab setradition

graph pie, over(setradition) missing ///
   pie(_all, explode) ///
   pie(5, color("150 150 150")) ///
   plabel(_all sum, size(*1.5)) ///
   title(Orthodoxie) ///
   legend(order(1 "Sehr unorthodox" 2 "Eher unorthodox" 3 "Eher traditionell" 4 "Sehr traditionell" 5 "Keine Antwort")) ///
   name(orthodoxie, replace)
graph export orthodoxie.pdf, replace


/* Wie gut sind Sie mit dem von Ihnen am häufigsten verwendeten methodischen Ansatz, den Sie derzeit in Ihrer Forschung in den Game Studies verwenden, vertraut? */
/* Einfachauswahl */
label define severtraut_lb ///
   1 "Sehr unvertraut" ///
   2 "Eher unvertraut" ///
   3 "Eher vertraut" ///
   4 "Sehr vertraut"
   label values severtraut severtraut_lb

tab severtraut

graph pie, over(severtraut) missing ///
   pie(_all, explode) ///
   pie(5, color("150 150 150")) ///
   plabel(_all sum, size(*1.5)) ///
   title(Vertrautheit) ///
   legend(order(1 "Sehr unvertraut" 2 "Eher unvertraut" 3 "Eher vertraut" 4 "Sehr vertraut" 5 "Keine Antwort")) ///
   name(vertrautheit, replace)
graph export vertrautheit.pdf, replace


/* Wie etabliert oder aktuell schätzen Sie den von Ihnen am häufigsten verwendeten methodischen Ansatz, den Sie derzeit in Ihrer Forschung in den Game Studies verwenden, innerhalb des disziplinären Kontexts ein, in dem Sie ihn ursprünglich erlernt oder kennengelernt haben? */
/* Einfachauswahl */
label define seetabliert_lb ///
   1 "Überhaupt nicht etabliert" ///
   2 "Kaum etabliert" ///
   3 "Etabliert" ///
   4 "Quasi Standard"
   label values seetabliert seetabliert_lb

tab seetabliert

graph pie, over(seetabliert) missing ///
   pie(_all, explode) ///
   pie(5, color("150 150 150")) ///
   plabel(_all sum, size(*1.5)) ///
   title(Etabliertheit) ///
   legend(order(1 "Überhaupt nicht etabliert" 2 "Kaum etabliert" 3 "Etabliert" 4 "Quasi Standard" 5 "Keine Antwort")) ///
   name(etabliertheit, replace)
graph export etabliertheit.pdf, replace


/* Wie gebräuchlich schätzen Sie den von Ihnen am häufigsten verwendeten methodischen Ansatz, den Sie derzeit in Ihrer Forschung in den Game Studies verwenden, innerhalb des disziplinären Kontexts ein, in dem Sie ihn ursprünglich erlernt oder kennengelernt haben? */
/* Einfachauswahl */
label define segebraeuchlich_lb ///
   1 "Sehr ungewöhnlich" ///
   2 "Eher ausgefallen" ///
   3 "Gängige Methode" ///
   4 "Methodischer Standard"
   label values segebraeuchlich segebraeuchlich_lb

tab segebraeuchlich

graph pie, over(segebraeuchlich) missing ///
   pie(_all, explode) ///
   pie(5, color("150 150 150")) ///
   plabel(_all sum, size(*1.5)) ///
   title(Gebräuchlichkeit) ///
   legend(order(1 "Sehr ungewöhnlich" 2 "Eher ausgefallen" 3 "Gängige Methode" 4 "Methodischer Standard" 5 "Keine Antwort")) ///
   name(gebraeuchlichkeit, replace)
graph export gebraeuchlichkeit.pdf, replace


********************************************************************************
*** ALTER                                                                    ***
********************************************************************************
use "data_game_studies_num.dta", clear


/* Bitte geben Sie an, in welcher Altersgruppe Sie sich befinden. */
/* Einfachauswahl */
label define agalter_lb ///
   1 "15–24" ///
   2 "25–34" ///
   3 "35–44" ///
   4 "45–54" ///
   5 "55–64" ///
   6 "65–74" ///
   7 "≥75"
   label values agalter agalter_lb

tab agalter

graph pie, over(agalter) missing ///
   pie(_all, explode) ///
   pie(7, color("150 150 150")) ///
   plabel(_all sum, size(*1.5)) ///
   title(Alter) ///
   legend(order(1 "15–24" 2 "25–34" 3 "35–44" 4 "45–54" 5 "55–64" 6 "65–74" 7 "Keine Antwort")) ///
   name(alter, replace)
graph export alter.pdf, replace


********************************************************************************
*** BEREICHE                                                                 ***
********************************************************************************
use "data_game_studies_area.dta", clear


/* Welche akademischen Abschlüsse haben Sie bisher erworben? */
/* Freitextfeld */
label define bereich_lb ///
    1 "Philosophie, Ethik, Religion" ///
    2 "Geschichte, Archäologie" ///
    3 "Soziologie" ///
    4 "Kulturwissenschaften" ///
    5 "Sprach- und Literaturwiss." ///
    6 "Medien- und Kommunikationswiss." ///
    7 "Wirtschaftswissenschaften" ///
    8 "Psychologie" ///
    9 "Kunstwissenschaften" ///
   10 "Digital Humanities" ///
   11 "Erziehungswissenschaften" ///
   12 "Architektur" ///
   13 "Politikwissenschaften" ///
   14 "Sonstige Religion, Religionswiss." ///
   15 "Mathematik" ///
   16 "Theologie" ///
   17 "Informatik" ///
   18 "Gesundheitswissenschaften"
   label values bereich bereich_lb

gen bereich_alpha = .
   replace bereich_alpha =  1 if bereich == 12
   replace bereich_alpha =  2 if bereich == 10
   replace bereich_alpha =  3 if bereich == 11
   replace bereich_alpha =  4 if bereich ==  2
   replace bereich_alpha =  5 if bereich == 18
   replace bereich_alpha =  6 if bereich == 17
   replace bereich_alpha =  7 if bereich ==  4
   replace bereich_alpha =  8 if bereich ==  9
   replace bereich_alpha =  9 if bereich == 15
   replace bereich_alpha = 10 if bereich ==  6
   replace bereich_alpha = 11 if bereich ==  1
   replace bereich_alpha = 12 if bereich == 13
   replace bereich_alpha = 13 if bereich ==  8
   replace bereich_alpha = 14 if bereich == 14
   replace bereich_alpha = 15 if bereich ==  3
   replace bereich_alpha = 16 if bereich ==  5
   replace bereich_alpha = 17 if bereich == 16
   replace bereich_alpha = 18 if bereich ==  7

label define bereich_alpha_lb ///
    1 "Architektur" ///
    2 "Digital Humanities" ///
    3 "Erziehungswissenschaften" ///
    4 "Geschichte, Archäologie" ///
    5 "Gesundheitswissenschaften" ///
    6 "Informatik" ///
    7 "Kulturwissenschaften" ///
    8 "Kunstwissenschaften" ///
    9 "Mathematik" ///
   10 "Medien- und Kommunikationswiss." ///
   11 "Philosophie, Ethik, Religion" ///
   12 "Politikwissenschaften" ///
   13 "Psychologie" ///
   14 "Sonst. Religion, Religionswiss." ///
   15 "Soziologie" ///
   16 "Sprach- und Literaturwiss." ///
   17 "Theologie" ///
   18 "Wirtschaftswissenschaften"
   label values bereich_alpha bereich_alpha_lb

preserve
   reshape long station, i(bereich_alpha) j(stationneu)

   label define stationneu_lb ///
      1 "Zur Zeit im Studium" ///
      2 "Bachelor (oder vergleichbar)" ///
      3 "Master (oder vergleichbar)" ///
      4 "Promotion" ///
      5 "Habilitation"
      label values stationneu stationneu_lb

   graph bar (sum) station, asyvars ///
      over(stationneu) ///
      over(bereich_alpha, label(angle(45))) ///
      bargap(10) ///
      ytitle("Anzahl") ///
      title(Studienbereiche) ///
      legend(pos(6) cols(3)) ///
      name(bereiche, replace)
   graph export bereiche.pdf, replace
restore


********************************************************************************
*** GENDER                                                                   ***
********************************************************************************
use "data_game_studies_gender.dta", clear


/* Bitte geben Sie Ihr Geschlecht an. */
/* Freitextfeld */
label define gender_lb ///
   1 "Männlich" ///
   2 "Weiblich" ///
   3 "Nichtbinär" ///
   4 "Anderes" ///
   5 "Keine Antwort"
   label values gender gender_lb

graph pie anzahl, over(gender) missing ///
   pie(_all, explode) ///
   pie(5, color("150 150 150")) ///
   plabel(_all sum, size(*1.5)) ///
   title(Gender) ///
   name(gender, replace)
graph export gender.pdf, replace


********************************************************************************
*** PUBLIKATIONSSPRACHE                                                      ***
********************************************************************************
use "data_game_studies_language.dta", clear


/* In welcher Sprache oder welchen Sprachen schreiben Sie Ihre Forschung in den Game Studies primär? */
/* Freitextfeld */
label define sprache_lb ///
   1 "Deutsch" ///
   2 "Deutsch > Englisch" ///
   3 "Deutsch = Englisch" ///
   4 "Deutsch < Englisch" ///
   5 "Englisch" ///
   6 "Englisch, Deutsch, Französisch" ///
   7 "Keine Antwort"
   label values sprache sprache_lb

graph pie anzahl, over(sprache) missing ///
   pie(_all, explode) ///
   pie(7, color("150 150 150")) ///
   plabel(_all sum, size(*1.5)) ///
   title(Publikationssprachen) ///
   name(sprache, replace)
graph export sprache.pdf, replace


exit
