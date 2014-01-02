; Show line & column numbers
(setq line-number-mode t)
(setq column-number-mode t)

; Spaces instead of tabs
(setq-default indent-tabs-mode nil)

(set-face-foreground 'font-lock-comment-face "red")

; Configure flymake: M-n goes to next error, M-p goes to previous
(global-set-key (kbd "M-n") 'flymake-goto-next-error)
(global-set-key (kbd "M-p") 'flymake-goto-prev-error)

; Show flymake help commands
(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'post-command-hook 'my-flymake-show-help)

; Set up Marmalade
(require 'package)
(add-to-list 'package-archives 
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/"))
(package-initialize)

; Set up JS validation
(require 'flymake-jshint)
(add-to-list 'flymake-allowed-file-name-masks
	     '("\\.js\\'" flymake-jshint-init))

; Validate with PEP 8
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "flake8" (list local-file)))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pylint-init))

;; load less mode
;(load "less-css-mode") ;; best not to include the ending “.el” or “.elc”
