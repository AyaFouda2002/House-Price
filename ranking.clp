(clear)
(defglobal ?*min-price* = 1.0)
(defglobal ?*max-price* = 4041600.0)
(defglobal ?*avg-price* = 8476.135701892093)
(defglobal ?*min-carpet* = 0.7639)
(defglobal ?*max-carpet* = 7633994.6858)
(defglobal ?*avg-carpet* = 14923.856974609598)

(deftemplate property
  (slot Price (type FLOAT))
  (slot Carpet_Area (type FLOAT))
  (slot classification (type SYMBOL)))

(deftemplate input
  (slot Price (type FLOAT))
  (slot Carpet_Area (type FLOAT)))

(defrule classify-cheap
  ?input <- (input (Price ?p) (Carpet_Area ?c))
  (test (and (<= ?p ?*avg-price*) (<= ?c ?*avg-carpet*)))
  =>
  (printout t "Debug: Firing classify-cheap rule" crlf)
  (retract ?input)
  (assert (property (Price ?p) (Carpet_Area ?c) (classification cheap)))
  (printout t "Property classified as cheap." crlf))

(defrule classify-average
  ?input <- (input (Price ?p) (Carpet_Area ?c))
  (test (and (> ?p ?*avg-price*) (<= ?p ?*max-price*) (> ?c ?*avg-carpet*) (<= ?c ?*max-carpet*)))
  =>
  (printout t "Debug: Firing classify-average rule" crlf)
  (retract ?input)
  (assert (property (Price ?p) (Carpet_Area ?c) (classification average)))
  (printout t "Property classified as average." crlf))

(defrule classify-expensive
  ?input <- (input (Price ?p) (Carpet_Area ?c))
  (test (or (> ?p ?*max-price*) (> ?c ?*max-carpet*)))
  =>
  (printout t "Debug: Firing classify-expensive rule" crlf)
  (retract ?input)
  (assert (property (Price ?p) (Carpet_Area ?c) (classification expensive)))
  (printout t "Property classified as expensive." crlf))

(defrule classify-other-average
  ?input <- (input (Price ?p) (Carpet_Area ?c))
  (test (and (> ?p ?*avg-price*) (<= ?p ?*max-price*)))
  =>
  (printout t "Debug: Firing classify-average rule (for cases not covered by classify-average)" crlf)
  (retract ?input)
  (assert (property (Price ?p) (Carpet_Area ?c) (classification average)))
  (printout t "Property classified as average." crlf))

(defrule print-properties
  (property (classification ?class))
  =>
  (printout t "Property classification: " ?class crlf))


