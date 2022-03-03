
; Raisa Salsabil Yusriyya (20/456376/TK/50506)

; Ask if patient already had a swab test
(defrule hadSwab
    =>
    (printout t crlf "Apakah Anda sudah melakukan swab test?" crlf "0 : belum" crlf "1 : sudah" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (assert (hadSwab yes))
    ) (if (= ?x 0)
        then (printout t crlf "Harap lakukan swab test di pusat kesehatan terdekat" crlf)
    )
)

; Ask swab test result - only execute if (hadSwab yes)
(defrule swabStatus (hadSwab yes)
    =>
    (printout t crlf "Apa hasil swab test Anda?" crlf "0 : negatif" crlf "1 : positif" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (assert (swabStatus positive))
    ) (if (= ?x 0)
        then (printout t crlf "Harap tetap jaga kesehatan dan patuhi protokol kesehatan." crlf)
    )
)

; Ask if having difficulties to breathe - only execute if (swabStatus positive)
(defrule breatheProb (swabStatus positive)
    =>
    (printout t crlf "Apakah Anda kesulitan untuk bernapas?" crlf "0 : tidak" crlf "1 : iya" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (printout t crlf "Anda wajib rujuk untuk isolasi di rumah sakit rujukan Covid-19 terdekat!" crlf)
    ) (if (= ?x 0)
        then (assert (breatheProb no))
    )
)

; Ask if having difficulties to breathe - only execute if (breatheProb no)
(defrule comorbid (breatheProb no)
    =>
    (printout t crlf "Apakah Anda memiliki komorbid?" crlf "0 : tidak" crlf "1 : iya" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (printout t crlf "Anda wajib rujuk untuk isolasi di rumah sakit rujukan Covid-19 terdekat!" crlf)
    ) (if (= ?x 0)
        then (assert (comorbid no))
    )
)

; Ask if age greater than 45 - only execute if (breatheProb no)
(defrule ageOld (comorbid no)
    =>
    (printout t crlf "Apakah Anda berusia 45 tahun atau lebih?" crlf "0 : tidak" crlf "1 : iya" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (printout t crlf "Anda wajib isolasi terpusat di shelter Covid-19 terdekat!" crlf)
    ) (if (= ?x 0)
        then (assert (ageOld no))
    )
)

; Ask if there are separated bedroom and toilet at home - only execute if (ageOld no)
(defrule house (ageOld no)
    =>
    (printout t crlf "Apakah Anda sedang tinggal di rumah pribadi yang terdapat kamar dan kamar mandi yang dapat digunakan terpisah dengan anggota keluarga lain?" crlf "0 : tidak" crlf "1 : iya" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (printout t crlf "Anda wajib melakukan isolasi mandiri selama 2 minggu." crlf)
    ) (if (= ?x 0)
        then (assert (house no))
    )
)

; Ask if enrolled at university - only execute if (house no)
(defrule univ (house no)
    =>
    (printout t crlf "Apakah Anda merupakan sivitas akademika aktif di suatu perguruan tinggi dan sedang kost di sekitar kampus?" crlf "0 : tidak" crlf "1 : iya" crlf)
    (bind ?x (read))
    (if (= ?x 1)
        then (printout t crlf "Hubungi satgas Covid-19 universitas Anda untuk mendaftar di shelter isolasi terpusat kampus." crlf)
    ) (if (= ?x 0)
        then (printout t crlf "Anda wajib isolasi terpusat di shelter Covid-19 terdekat!" crlf)
    )
)