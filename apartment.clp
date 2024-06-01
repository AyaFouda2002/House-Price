(deftemplate apartment
  (slot balconies)
  (slot toilets))

(deftemplate apartment-class
  (slot class))

(defrule studio-apartment
  (apartment (balconies ?b) (toilets ?t))
  (test (eq ?b 1))
  (test (eq ?t 1))
  =>
  (assert (class Studio)))

(defrule compact-apartment
  (apartment (balconies ?b) (toilets ?t))
  (or (test (and (eq ?b 1) (eq ?t 2)))
      (test (and (eq ?b 2) (eq ?t 1))))
  =>
  (assert (class Compact)))

(defrule standard-apartment
  (apartment (balconies ?b) (toilets ?t))
  (test (eq ?b 2))
  (test (eq ?t  2))
  =>
  (assert (class Standard)))

(defrule comfort-apartment
  (apartment (balconies ?b) (toilets ?t))
  (or (test (and (eq ?b 2) (eq ?t 3)))
      (test (and (eq ?b 3) (eq ?t 2))))
  =>
  (assert (class Comfort)))

(defrule spacious-apartment
  (apartment (balconies ?b) (toilets ?t))
  (test (>= ?b 3))
  (test (>= ?t 3))
  =>
  (assert (class Spacious)))

(defrule print-apartment-class
  (class ?c)
  =>
  (printout t "The apartment is classified as: " ?c crlf))
