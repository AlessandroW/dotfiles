;; (require 'package)

;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
;; (add-to-list 'load-path "/home/temporary/.themes/tomorrow-theme/GNU Emacs")
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(load "~/.emacs.d/init-packages")
;; (package-initialize)
;; (when (not package-archive-contents)
;;   (package-refresh-contents))

;; (defvar myPackages
;;   '(better-defaults
;;     indium
;;     flycheck
;;     ))

;; (mapc #'(lambda (package)
;;           (unless (package-installed-p package)
;;             (package-install package)))
;;       myPackages)


;; GENERAL 
(global-linum-mode t) ;; enable line numbers globally
(global-flycheck-mode) ;; enable flycheck mode globally
(company-quickhelp-mode 1)

(add-to-list 'load-path "~/")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
 (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load "company"
    (global-set-key (kbd "S-SPC") 'company-complete))
(setq company-dabbrev-downcase nil)
(require 'evil)
(evil-mode 1)

(which-key-mode 1) ;;Shows key code completion

;; VISUAL
(set-frame-font "Inconsolata-12")
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")

(autoload 'hideshowvis-minor-mode
   "hideshowvis"
   "Will indicate regions foldable with hideshow in the fringe."
   'interactive)
;; Codefolding
(defun toggle-selective-display (column)
  (interactive "P")
  (set-selective-display
   (or column
       (unless selective-display
         (1+ (current-column))))))
(defun toggle-hiding (column)
      (interactive "P")
      (if hs-minor-mode
          (if (condition-case nil
                  (hs-toggle-hiding)
                (error t))
              (hs-show-all))
        (toggle-selective-display column)))

(load-library "hideshow")
(global-set-key (kbd "C-+") 'toggle-hiding)
(global-set-key (kbd "C--") 'toggle-selective-display)
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

;;JSON
 ;; (eval-after-load 'json
 ;;   (global-set-key (kbd "C-c p") 'json-pretty-print-buffer))

;; ;; (require 'theme-changer)
;; ;; (change-theme 'solarized-light 'solarized-dark)
;; =======
;; (setq calendar-location-name "Berlin") 
;; (setq calendar-latitude 49.76)
;; (setq calendar-longitude 9.93)

;; (require 'theme-changer)
;; (change-theme 'base16-default-light 'base16-default-dark)
(load-theme 'base16-default-dark t)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(rainbow-mode 1)



;;PYTHON
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;;(minimap-mode 1)
;;(setq minimap-window-location 'right)
;;(setq minimap-minimum-width 10)
;; changing colors
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t (:background "#2d2d2d"))))
 '(minimap-active-region-background ((((background dark)) (:background "#37474f")) (t (:background "#ff5177"))) nil :group))

;;UTILITY
;; (setq-default ispell-program-name "aspell")
;;  (setq ispell-program-name "aspell"
;;        flyspell-default-dictionary "deutsch8"
;;        ispell-local-dictionary "deutsch8"
;;       ;; saves personal dictionary without asking me. there is no difference if I switch that off.
;;        ispell-silently-savep t
;;        )

;;  ;; clear alist and set for aspell /de_DE.UTF-8 the right way: 
;;  (setq ispell-local-dictionary-alist nil) 
;;  (add-to-list 'ispell-local-dictionary-alist 
;;          '("deutsch8" 
;;            "[[:alpha:]]" "[^[:alpha:]]"
;;             "[']" t
;;             ("-C" "-d" "de_DE-neu.multi")
;;             "~latin1" iso-8859-1)
;;           )

(global-set-key (kbd "C-c y") 'browse-kill-ring)
(require 'smartparens-config);; Always start smartparens mode in js-mode.
(add-hook 'js2-mode-hook #'smartparens-mode)
(require 'smartparens-latex)
(electric-pair-mode 1) ;;add other braket etc.
(require 'better-defaults)
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; Better imenu
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

(require 'js2-refactor)
;;(require 'xref-js2)

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
(define-key js-mode-map (kbd "M-.") nil)

(add-hook 'js2-mode-hook (lambda ()
;; <<<<<<< HEAD
;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))
(add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

(require 'powerline)
(require 'powerline-evil)
(powerline-default-theme)

(unless (package-installed-p 'indium)
  (package-install 'indium))
(require 'indium)
(add-hook 'js-mode-hook #'indium-interaction-mode)

(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(85 . 50) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(centered-window-mode t)
 '(custom-safe-themes
   (quote
    ("5a39d2a29906ab273f7900a2ae843e9aa29ed5d205873e1199af4c9ec921aaab" "2a998a3b66a0a6068bcb8b53cd3b519d230dd1527b07232e54c8b9d84061d48d" "16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661" "3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299" "c9f102cf31165896631747fd20a0ca0b9c64ecae019ce5c2786713a5b7d6315e" "36746ad57649893434c443567cb3831828df33232a7790d232df6f5908263692" "b0c5c6cc59d530d3f6fbcfa67801993669ce062dda1435014f74cafac7d86246" "b67b2279fa90e4098aa126d8356931c7a76921001ddff0a8d4a0541080dee5f6" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "5ee12d8250b0952deefc88814cf0672327d7ee70b16344372db9460e9a0e3ffc" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "5dc0ae2d193460de979a463b907b4b2c6d2c9c4657b2e9e66b8898d2592e3de5" "7f1263c969f04a8e58f9441f4ba4d7fb1302243355cb9faecb55aec878a06ee9" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" default)))
 '(package-selected-packages
   (quote
    (smartparens helm json-mode typescript-mode magit yaml-mode flycheck-yamllint ac-js2 flycheck-pos-tip folding company-tern hideshowvis browse-kill-ring figlet flyspell-correct-helm ein elpy base16-theme rainbow-mode minimap company-auctex neotree flycheck-popup-tip use-package sublimity solarized-theme powerline-evil org-evil material-theme indium flyspell-popup flyspell-correct-popup flymake-json flymake-jslint flycheck evil-tutor better-defaults auto-indent-mode auctex)))
 '(semantic-mode t)
 '(typescript-indent-level 2)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a"))))
 '(vc-annotate-very-old-color nil))
