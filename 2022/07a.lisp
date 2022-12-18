;; it's been 20+ years since I used some LISP
;; ran with SBCL 1.5.4

(defvar *fs* (list 'dir (list "/" '(dir))))
(defun split-by-one-space (string)
  "from: https://lispcookbook.github.io/cl-cookbook/strings.html"
  (loop for i = 0 then (1+ j)
    as j = (position #\Space string :start i)
    collect (subseq string i j)
    while j))
(defun print-tree (dir indent)
  "Pretty print a file tree"
  (let ((total 0))
    (dolist (elem (cdr dir))
      (let (
          (name (car elem))
          (cont (cadr elem)))
        (if (numberp cont) ; is file
          (progn
            (format t "~a~a=~a~%" indent name cont)
            (incf total cont))
          (progn
            (format t "~a~a={~%" indent name)
            (let ((subtotal (print-tree cont (concatenate 'string indent "  "))))
              (incf total subtotal)
              (format t "~a}=~a~%" indent subtotal)))))
          )
  total))
;; (let ((fs '(("a" 1) ("b" (("b1" 10) ("b2" 11) ("b3" (("b21" 100))))) ("c" 3))))
;;   (print-tree fs ""))
(defun chdir (dir name)
  "Returns a specific directory"
  (cadr (find name (cdr dir) :test (lambda (a b) (string= a (car b))))))
;; (let ((fs '(("a" 1) ("b" (("b1" 10) ("b2" 11) ("b3" (("b21" 100))))) ("c" 3))))
;;   (print-tree fs "fs ")
;; )
(defun add-entry (dir entry)
  (setf (cdr (last dir)) (list entry)))
(let ((dirs '()))
  (loop for line = (read-line t nil)
    while line
    do (let* (
        (w (split-by-one-space line))
        (p1 (car w))
        (p2 (cadr w)))
      (cond
        ((string= "$" p1) (if
          (string= "cd" p2) ; we ignore "ls", output is self-describing
          (let ((name (caddr w)))
            ;; (format t "ch dir: ~a~%" name)
            (cond
              ((string= "/" name) (setf dirs (list (chdir *fs* "/"))))
              ((string= ".." name) (pop dirs))
              (t (push (chdir (car dirs) name) dirs)))
          )
        ))
        ((string= "dir" p1) (let ((name p2))
          ;; (format t "add dir: ~a~%" name)
          (add-entry (car dirs) (list name (cons 'dir nil)))
        ))
        (t (let ((size (parse-integer p1))
                 (name p2))
          ;; (format t "add file: ~a ~a~%" name size)
          (add-entry (car dirs) (list name size))
        ))
      )
      ;; (format t "dirs=~a~%" dirs)
      ;; (print-tree (car dirs) "")
    ))
)
;; (format t "fs=~a~%" *fs*)
(print-tree *fs* "")
(defun search-dir (dir maxsize)
  "Search directories with maxsize"
  (let (
      (total 0)
      (dirs '()))
    (dolist (elem (cdr dir))
      (let (
          (name (car elem))
          (cont (cadr elem)))
        (if (numberp cont) ; is file
          (incf total cont)
          (let* (
              (res (search-dir cont maxsize))
              (subtotal (car res))
              (subdirs (cadr res)))
            (incf total subtotal)
            (setf dirs (append dirs subdirs))
            (if (<= subtotal maxsize)
              (push (list name subtotal) dirs))))))
  (list total dirs)))
(let (
    (dirs (cadr (search-dir *fs* 100000)))
    (total 0))
  (format t "Small dirs: ~a~%" dirs)
  (dolist (dir dirs)
    (incf total (cadr dir)))
  (format t "ANSWER~%~a~%" total))
