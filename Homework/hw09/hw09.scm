(define (ascending? asc-lst) 
    (cond 
        ((null? asc-lst) #t)
        ((null? (cdr asc-lst)) #t)
        ((<= (car asc-lst) (car (cdr asc-lst))) (ascending? (cdr asc-lst)))
        (else #f)
    )
)

(define (my-filter pred s) 
    (cond 
        ((null? s) 
            '() )
        ((pred (car s)) 
            (cons (car s) (my-filter pred (cdr s))) )
        (else 
            (my-filter pred (cdr s)) )
    )
)

(define (interleave lst1 lst2) 
    (cond 
        ((and (null? lst1)(null? lst2)) 
            '() )
        ((null? lst1) lst2)
        ((null? lst2) lst1)
        (else
            (append(cons (car lst1) (cons (car lst2) '())) (interleave (cdr lst1) (cdr lst2)))
        ))  
    )


(define (no-repeats lst)
  (define (member item s)
    (cond
      ((null? s) #f)
      ((equal? item (car s)) #t)
      (else (member item (cdr s)))
    )
  )
  (cond
    ((null? lst) lst)
    ((member (car lst) (cdr lst)) (no-repeats (cdr lst)))
    (else (cons (car lst) (no-repeats (cdr lst))))
  )
)
