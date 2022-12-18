;; it's been 20+ years since I used some LISP
;; ran with SBCL 1.5.4

(defvar *fs* (list 'dir (list "/" '(dir))))
(defun split-by-one-space (string)
  "from: https://lispcookbook.github.io/cl-cookbook/strings.html"
  (loop for i = 0 then (1+ j)
    as j = (position #\Space string :start i)
    collect (subseq string i j)
    while j))
(defun chdir (dir name)
  "Returns a specific directory"
  (cadr (find name (cdr dir) :test (lambda (a b) (string= a (car b))))))
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
            (cond
              ((string= "/" name) (setf dirs (list (chdir *fs* "/"))))
              ((string= ".." name) (pop dirs))
              (t (push (chdir (car dirs) name) dirs)))
          )
        ))
        ((string= "dir" p1) (let ((name p2))
          (add-entry (car dirs) (list name (cons 'dir nil)))
        ))
        (t (let ((size (parse-integer p1))
                 (name p2))
          (add-entry (car dirs) (list name size))
        ))
      )
    ))
)
(defun search-dir (dir)
  "Search directories with total size"
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
              (res (search-dir cont))
              (subtotal (car res))
              (subdirs (cadr res)))
            (incf total subtotal)
            (setf dirs (append dirs subdirs))
            (push (list name subtotal) dirs)))))
  (list total dirs)))
(let (
    (dirs (cadr (search-dir *fs*)))
    (disk 70000000)
    (need 30000000)
    (free 0)
    (used 0)
    (best 70000000))
  ;; (format t "Dirs: ~a~%" dirs)
  (setf used (cadar dirs))
  (format t "Used space:    ~a~%" used)
  (setf free (- disk used))
  (format t "Free space:    ~a~%" free)
  (decf need free)
  (format t "Needs to free: ~a~%" need)
  (dolist (dir dirs)
    (let ((size (cadr dir)))
      (if (and (>= size need) (< size best))
        (progn
          (format t "New best:      ~a ~a~%" size (car dir))
          (setf best size)))))
  (format t "ANSWER~%~a~%" best))
