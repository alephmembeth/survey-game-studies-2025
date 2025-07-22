********************************************************************************
*** HEADER                                                                   ***
********************************************************************************
version 14.2

set more off, permanently
set scheme sj


********************************************************************************
*** WISSENSCHAFTLICHER HINTERGRUND                                           ***
********************************************************************************
use "data_game_studies_num.dta", clear


/* Sind Sie Mitglied im AKGWDS? */
label define whakgwds_lb 0 "Nein" 1 "Ja"
   label values whakgwds whakgwds_lb

tab whakgwds


/* In welchem Kontext haben Sie die methodischen Ansätze, die Sie in Ihrer Forschung außerhalb der Game Studies verwenden, erlernt? */
gen whkontexterlerntotherneu = ""
   replace whkontexterlerntotherneu = "Y" if whkontexterlerntother != ""

gen whkontexterlerntneu = .
   replace whkontexterlerntneu = 1 if whkontexterlernt1        == "Y"
   replace whkontexterlerntneu = 2 if whkontexterlernt2        == "Y"
   replace whkontexterlerntneu = 3 if whkontexterlernt3        == "Y"
   replace whkontexterlerntneu = 4 if whkontexterlernt4        == "Y"
   replace whkontexterlerntneu = 5 if whkontexterlerntotherneu == "Y"

label define whkontexterlerntneu_lb ///
   1 "Bachelorstudium" ///
   2 "Masterstudium" ///
   3 "Promotionsstudium" ///
   4 "Selbststudium" ///
   5 "Anderes"
   label values whkontexterlerntneu whkontexterlerntneu_lb

tab whkontexterlerntneu


/* In welcher akademischen Rolle befinden Sie sich derzeit? */
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
   8 "Anderes"
   label values whrolleneu whrolleneu_lb

tab whrolleneu


/* Sind Sie aktuell oder waren Sie innerhalb der letzten zwölf Monate in einem wissenschaftlichen Kontext angestellt? */
label define whanstellung_lb ///
   0 "Nein" ///
   1 "Ja"
   label values whanstellung whanstellung_lb

tab whanstellung


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
      ylabel(0(20)100) ///
      graphregion(color(white))
restore


/* Sind Sie derzeit befristet oder unbefristet angestellt? */
label define whbefristung_lb ///
   1 "Befristet" ///
   2 "Unbefristet" ///
   3 "Unbefristet mit Sonderkündigungsschutz"
   label values whbefristung whbefristung_lb

tab whbefristung


********************************************************************************
*** GAME STUDIES                                                             ***
********************************************************************************
use "data_game_studies_num.dta", clear


/* In welchem Kontext haben Sie diese methodischen Ansätze erlernt? */

gen gserlerntneu = .
   replace gserlerntneu = 1 if gserlernt1     == "Y"
   replace gserlerntneu = 2 if gserlernt2     == "Y"
   replace gserlerntneu = 3 if gserlernt3     == "Y"
   replace gserlerntneu = 4 if gserlernt4     == "Y"
   replace gserlerntneu = 5 if gserlerntother == "Y"

label define gserlerntneu_lb ///
   1 "Bachelorstudium" ///
   2 "Masterstudium" ///
   3 "Promotionsstudium" ///
   4 "Selbststudium" ///
   5 "Anderes"
   label values gserlerntneu gserlerntneu_lb

tab gserlerntneu


********************************************************************************
*** SELBSTEINSCHAETZUNG                                                      ***
********************************************************************************
use "data_game_studies_num.dta", clear


/* Wie schätzen Sie Ihr eigenes methodisches Vorgehen in den Game Studies ein? */
label define setradition_lb ///
   1 "Sehr unorthodox" ///
   2 "Eher unorthodox" ///
   3 "Eher traditionell" ///
   4 "Sehr traditionell"
   label values setradition setradition_lb

tab setradition


/* Wie gut sind Sie mit dem von Ihnen am häufigsten verwendeten methodischen Ansatz, den Sie derzeit in Ihrer Forschung in den Game Studies verwenden, vertraut? */
label define severtraut_lb ///
   1 "Sehr unvertraut" ///
   2 "Eher unvertraut" ///
   3 "Eher vertraut" ///
   4 "Sehr vertraut"
   label values severtraut severtraut_lb

tab severtraut


/* Wie etabliert oder aktuell schätzen Sie den von Ihnen am häufigsten verwendeten methodischen Ansatz, den Sie derzeit in Ihrer Forschung in den Game Studies verwenden, innerhalb des disziplinären Kontexts ein, in dem Sie ihn ursprünglich erlernt oder kennengelernt haben? */
label define seetabliert_lb ///
   1 "Überhaupt nicht etabliert" ///
   2 "Kaum etabliert" ///
   3 "Etabliert" ///
   4 "Quasi Standard"
   label values seetabliert seetabliert_lb

tab seetabliert


/* Wie gebräuchlich schätzen Sie den von Ihnen am häufigsten verwendeten methodischen Ansatz, den Sie derzeit in Ihrer Forschung in den Game Studies verwenden, innerhalb des disziplinären Kontexts ein, in dem Sie ihn ursprünglich erlernt oder kennengelernt haben? */
label define segebraeuchlich_lb ///
   1 "Sehr ungewöhnlich" ///
   2 "Eher ausgefallen" ///
   3 "Gängige Methode" ///
   4 "Methodischer Standard"
   label values segebraeuchlich segebraeuchlich_lb

tab segebraeuchlich


********************************************************************************
*** ALTER UND GESCHLECHT                                                     ***
********************************************************************************
use "data_game_studies_num.dta", clear


/* Bitte geben Sie an, in welcher Altersgruppe Sie sich befinden. */
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


exit
