;
; CIS 343, Winter 2019, Project 7
;
; Student Name(s): Blake Lapum, Cole Sellers
;

(defun my-gcd (a b)
    (if (= b 0) a (my-gcd b (mod a b)))
)


(defun is-palindrome (l)
	(if (not (listp l))(return-from is-palindrome "Error"))

	(if (null l) 
		(return-from is-palindrome nil)
		(equal l (reverse l))
	)
)


(defun intlist (n)
	(loop for x from 1 to n
        for y = (+ (- n x) 1)
         collect y
	)
)


(defun analyze (l)
	(cond ((null l) l)
		((atom (car l)) (append '(atom) (analyze (cdr l))))
		(t (append '(list) (analyze (cdr l ))))
	)
)


(defun only-atoms (l)
	(cond ((null l) nil)
		((= (length l) 1) (atom (car l)))
		(t (and (atom (car l)) (only-atoms (cdr l))))
	)
)


(defun only-atoms-iter (l)
	(if (null l) (return-from only-atoms-iter nil))
	(doList (e l)
		(when (not (atom e)) (return-from only-atoms-iter nil))
	)
	t
)


(defun quad-roots (a b c)
	(list
		(/ (- (- 0 b) (sqrt(- (* b b) (* 4 (* a c))))) (* 2 a))
		(/ (+ (- 0 b) (sqrt(- (* b b) (* 4 (* a c))))) (* 2 a))

	)
)


(defun rotate-from-right (l n)
	(if (zerop n)
	l
		(rotate-from-right (append (last l) (butlast l)) (- n 1))
	)
)


(defun odds (l)
	(unless (null l)
    	(cons (first l) (odds (cddr l)))
	)
)


(defun odds-iter (l)
	(loop for i in l
		for keep = t then (not keep) 
		if keep collect i
	)
)


;
; DO NOT MODIFY THE CODE BELOW: Contains test functions
;

; tests for my-gcd
(defun test-my-gcd ()
	(if (equal (my-gcd 42 56) 14) (print "my-gcd-t1: PASS") (print "my-gcd-t1: FAIL"))
	(if (equal (my-gcd 12 18) 6) (print "my-gcd-t2: PASS") (print "my-gcd-t2: FAIL"))
	(if (equal (my-gcd 3 5) 1) (print "my-gcd-t3: PASS") (print "my-gcd-t3: FAIL"))
	(if (equal (my-gcd 12 60) 12) (print "my-gcd-t4: PASS") (print "my-gcd-t4: FAIL"))
	(if (equal (my-gcd 12 90) 6) (print "my-gcd-t5: PASS") (print "my-gcd-t5: FAIL"))
)

; tests for is-palindrome
(defun test-is-palindrome ()
	(if (equal (is-palindrome '(a b b a)) t) (print "is-palindrome-t1: PASS") (print "is-palindrome-t1: FAIL"))
	(if (equal (is-palindrome '(a b c)) nil) (print "is-palindrome-t2: PASS") (print "is-palindrome-t2: FAIL"))
	(if (equal (is-palindrome '(a b a)) t) (print "is-palindrome-t3: PASS") (print "is-palindrome-t3: FAIL"))
	(if (equal (is-palindrome '(a b)) nil) (print "is-palindrome-t4: PASS") (print "is-palindrome-t4: FAIL"))
	(if (equal (is-palindrome '(a)) t) (print "is-palindrome-t5: PASS") (print "is-palindrome-t5: FAIL"))
	(if (equal (is-palindrome '()) nil) (print "is-palindrome-t6: PASS") (print "is-palindrome-t6: FAIL"))
)

; tests for intlist
(defun test-intlist ()
	(if (equal (intlist 8) '(8 7 6 5 4 3 2 1)) (print "intlist-t1: PASS") (print "intlist-t1: FAIL"))
	(if (equal (intlist 5) '(5 4 3 2 1)) (print "intlist-t2: PASS") (print "intlist-t2: FAIL"))
	(if (equal (intlist 1) '(1)) (print "intlist-t3: PASS") (print "intlist-t3: FAIL"))
	(if (equal (intlist 0) nil) (print "intlist-t4: PASS") (print "intlist-t4: FAIL"))
	(if (equal (intlist -5) nil) (print "intlist-t5: PASS") (print "intlist-t5: FAIL"))
)

; tests for analyze
(defun test-analyze ()
	(if (equal (analyze '(a b c)) '(atom atom atom)) (print "analyze-t1: PASS") (print "analyze-t1: FAIL"))
	(if (equal (analyze '(a b (c d) e f)) '(atom atom list atom atom)) (print "analyze-t2: PASS") (print "analyze-t2: FAIL"))
	(if (equal (analyze '(a)) '(atom)) (print "analyze-t3: PASS") (print "analyze-t3: FAIL"))
	(if (equal (analyze '((a))) '(list)) (print "analyze-t4: PASS") (print "analyze-t4: FAIL"))
	(if (equal (analyze '()) nil) (print "analyze-t5: PASS") (print "analyze-t5: FAIL"))
)

; tests for only-atoms
(defun test-only-atoms ()
	(if (equal (only-atoms '(a b c)) t) (print "only-atoms-t1: PASS") (print "only-atoms-t1: FAIL"))
	(if (equal (only-atoms '(a)) t) (print "only-atoms-t2: PASS") (print "only-atoms-t2: FAIL"))
	(if (equal (only-atoms '(a (b) c)) nil) (print "only-atoms-t3: PASS") (print "only-atoms-t3: FAIL"))
	(if (equal (only-atoms '()) nil) (print "only-atoms-t4: PASS") (print "only-atoms-t4: FAIL"))
)

; tests for only-atoms-iter
(defun test-only-atoms-iter ()
	(if (equal (only-atoms-iter '(a b c)) t) (print "only-atoms-iter-t1: PASS") (print "only-atoms-iter-t1: FAIL"))
	(if (equal (only-atoms-iter '(a)) t) (print "only-atoms-iter-t2: PASS") (print "only-atoms-iter-t2: FAIL"))
	(if (equal (only-atoms-iter '(a (b) c)) nil) (print "only-atoms-iter-t3: PASS") (print "only-atoms-iter-t3: FAIL"))
	(if (equal (only-atoms-iter '()) nil) (print "only-atoms-iter-t4: PASS") (print "only-atoms-iter-t4: FAIL"))
)

; tests for quad-roots
(defun test-quad-roots ()
	(if (or (equal (quad-roots 2 4 -30) '(3 -5)) (equal (quad-roots 2 4 -30) '(-5 3))) (print "quad-roots-t1: PASS") (print "quad-roots-iter-t1: FAIL"))
	(if (or (equal (quad-roots 1 3 -4) '(1 -4)) (equal (quad-roots 1 3 -4) '(-4 1))) (print "quad-roots-t2: PASS") (print "quad-roots-iter-t2: FAIL"))
	(if (or (equal (quad-roots 1 5 -6) '(1 -6)) (equal (quad-roots 1 5 -6) '(-6 1))) (print "quad-roots-t3: PASS") (print "quad-roots-iter-t3: FAIL"))
	(if (or (equal (quad-roots 1 2 -8) '(2 -4)) (equal (quad-roots 1 2 -8) '(-4 2))) (print "quad-roots-t4: PASS") (print "quad-roots-iter-t4: FAIL"))
)

; tests for rotate-from-right
(defun test-rotate-from-right ()
	(if (equal (rotate-from-right '(a b c d e) 3) '(c d e a b)) (print "rotate-from-right-t1: PASS") (print "rotate-from-right-t1: FAIL"))
	(if (equal (rotate-from-right '(a b c d e) 2) '(d e a b c)) (print "rotate-from-right-t2: PASS") (print "rotate-from-right-t2: FAIL"))
	(if (equal (rotate-from-right '(a b c d e) 1) '(e a b c d)) (print "rotate-from-right-t3: PASS") (print "rotate-from-right-t3: FAIL"))
	(if (equal (rotate-from-right '(a b c d e) 4) '(b c d e a)) (print "rotate-from-right-t4: PASS") (print "rotate-from-right-t4: FAIL"))
	(if (equal (rotate-from-right '(a b c d e) 5) '(a b c d e)) (print "rotate-from-right-t5: PASS") (print "rotate-from-right-t5: FAIL"))
	(if (equal (rotate-from-right '(a b c d e) 7) '(d e a b c)) (print "rotate-from-right-t6: PASS") (print "rotate-from-right-t6: FAIL"))
	(if (equal (rotate-from-right '(a b c d e) 0) '(a b c d e)) (print "rotate-from-right-t7: PASS") (print "rotate-from-right-t7: FAIL"))
	(if (equal (rotate-from-right '(a b c d e) -2) '(a b c d e)) (print "rotate-from-right-t8: PASS") (print "rotate-from-right-t8: FAIL"))
)

; tests for odds
(defun test-odds ()
	(if (equal (odds '(a b c d e)) '(a c e)) (print "odds-t1: PASS") (print "odds-t1: FAIL"))
	(if (equal (odds '(a)) '(a)) (print "odds-t2: PASS") (print "odds-t2: FAIL"))
	(if (equal (odds '(a b)) '(a)) (print "odds-t3: PASS") (print "odds-t3: FAIL"))
	(if (equal (odds '()) nil) (print "odds-t4: PASS") (print "odds-t4: FAIL"))
	(if (equal (odds '(a b c d e f g)) '(a c e g)) (print "odds-t5: PASS") (print "odds-t5: FAIL"))
)

; tests for odds-iter
(defun test-odds-iter ()
	(if (equal (odds-iter '(a b c d e)) '(a c e)) (print "odds-iter-t1: PASS") (print "odds-iter-t1: FAIL"))
	(if (equal (odds-iter '(a)) '(a)) (print "odds-iter-t2: PASS") (print "odds-iter-t2: FAIL"))
	(if (equal (odds-iter '(a b)) '(a)) (print "odds-iter-t3: PASS") (print "odds-iter-t3: FAIL"))
	(if (equal (odds-iter '()) nil) (print "odds-iter-t4: PASS") (print "odds-iter-t4: FAIL"))
	(if (equal (odds-iter '(a b c d e f g)) '(a c e g)) (print "odds-iter-t5: PASS") (print "odds-iter-t5: FAIL"))
)

;
; Test all functions
;
(defun testall ()
	(test-my-gcd)
	(test-is-palindrome)
	(test-intlist)
	(test-analyze)
	(test-only-atoms)
	(test-only-atoms-iter)
	(test-quad-roots)
	(test-rotate-from-right)
	(test-odds)
	(test-odds-iter)
	
	t	; return true when done with testing
)
