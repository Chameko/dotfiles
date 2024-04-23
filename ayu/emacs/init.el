; Disable default emacs elements
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)

;; Disable backup files
(setq make-backup-files nil)

;; Set visual bell
(setq visible-bell t)

;; Set font
(set-face-attribute 'default nil :font "CaskaydiaCove Nerd Font Propo" :height 125)

;; Line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Scroll margin
(setq scroll-margin 8)
(setq scroll-conservatively 100)

;; Quick keybinds
(global-set-key (kbd "C-c C-k") 'kill-current-buffer)

;; Autopairs
(electric-pair-mode)

;; Spell checking
(setenv "DICPATH" (concat (getenv "HOME") "/Library/Spelling"))
(setq ispell-program-name
      "/usr/bin/hunspell")

;; Make paragraphs use only one space
(setq sentence-end-double-space nil)

;; Increase some funny numbers to make emacs more responsive
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Initialise package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialise use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Prevent littering
(use-package no-littering
  :demand
  :config
  (no-littering-theme-backups))

;; Treesitter config
(require 'treesit)

(use-package tree-sitter-langs
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-on-after-hook #'tree-sitter-hl-mode))

;; Ivy
(use-package swiper
  :bind ("C-s" . swiper))
(use-package ivy
  :diminish
  :bind (:map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x  b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

;; Doom modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; Rainbow delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Which key
(use-package which-key
  :init (which-key-mode)
  :diminish
  :config
  (setq which-key-idle-delay 0.0))

;; Helpful
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package all-the-icons)

(use-package undo-tree
  :config
  (global-undo-tree-mode))

;; Indent guides
(use-package highlight-indent-guides
  :custom
  (highlight-indent-guides-method 'character)
  (highlight-indent-guides-responsive 'stack)
  :hook (prog-mode . highlight-indent-guides-mode))

(use-package meow
  :config
  (defun smart-for-file ()
    "Use projectile find file when in projectile directory, otherwise use normal find file"
    (interactive)
    (if (projectile-project-p)
	(projectile-find-file)
      (counsel-find-file)))
  (defun meow-setup ()
    "Setup meow"
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
    (meow-motion-overwrite-define-key
     '("j" . meow-next)
     '("k" . meow-prev)
     '("<escape>" . ignore))
    (meow-leader-define-key
     ;; SPC j/k will run the original command in MOTION state.
     '("j" . "H-j")
     '("k" . "H-k")
     ;; Use SPC (0-9) for digit arguments.
     '("1" . meow-digit-argument)
     '("2" . meow-digit-argument)
     '("3" . meow-digit-argument)
     '("4" . meow-digit-argument)
     '("5" . meow-digit-argument)
     '("6" . meow-digit-argument)
     '("7" . meow-digit-argument)
     '("8" . meow-digit-argument)
     '("9" . meow-digit-argument)
     '("0" . meow-digit-argument)
     '("/" . meow-keypad-describe-key)
     '("?" . meow-cheatsheet)
     '("f" . smart-for-file)
     '("b" . counsel-ibuffer))
    (meow-normal-define-key
     '("0" . meow-expand-0)
     '("9" . meow-expand-9)
     '("8" . meow-expand-8)
     '("7" . meow-expand-7)
     '("6" . meow-expand-6)
     '("5" . meow-expand-5)
     '("4" . meow-expand-4)
     '("3" . meow-expand-3)
     '("2" . meow-expand-2)
     '("1" . meow-expand-1)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("a" . meow-append)
     '("A" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("d" . meow-delete)
     '("D" . meow-backward-delete)
     '("e" . meow-next-word)
     '("E" . meow-next-symbol)
     '("f" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-insert)
     '("I" . meow-open-above)
     '("j" . meow-next)
     '("J" . meow-next-expand)
     '("k" . meow-prev)
     '("K" . meow-prev-expand)
     '("l" . meow-right)
     '("L" . meow-right-expand)
     '("m" . meow-join)
     '("n" . meow-search)
     '("o" . meow-block)
     '("O" . meow-to-block)
     '("p" . meow-yank)
     '("P" . clipboard-yank) 
     '("q" . meow-quit)
     '("Q" . meow-goto-line)
     '("r" . meow-replace)
     '("R" . meow-swap-grab)
     '("s" . meow-kill)
     '("S" . meow-visit)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . undo-tree-redo)
     '("v" . meow-visit)
     '("w" . meow-mark-word)
     '("W" . meow-mark-symbol)
     '("x" . meow-line)
     '("X" . meow-line-expand)
     '("y" . meow-save)
     '("Y" . meow-sync-grab)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     '("<escape>" . ignore)))
  (meow-setup)
  (meow-global-mode 1))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-idle-delay 0.0)
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-enable-hover nil)
  (lsp-eldoc-render-all t)
  (lsp-inlay-hint-enable t)
  (lsp-rust-analyzer-display-chaining-hints t)
  :hook
  (rustic-mode . lsp)
  (lsp-mode . lsp-enable-which-key-integration))

(use-package lsp-pyright
  :hook (python-mode . (lambda ()
			 (require 'lsp-pyright)
			 (lsp))))

(use-package lsp-ui
  :config
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-ui-doc-delay 0.8))

(use-package rustic
  :bind (:map rustic-mode-map)
  :config
  (setq rustic-format-on-save t))

(use-package company
  :config (add-hook 'eglot-managed-mode-hook #'company-mode)
  :custom
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.1))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map))
  :init
  (when (file-directory-p "~/projects")
    (setq projectile-project-search-path '("~/projects")))
  (setq projectile-switch-project-action #'projectile-dired)
  :custom
  (projectile-completion-system 'ivy))

(use-package counsel-projectile
  :diminish
  :config (counsel-projectile-mode))

(use-package magit)

(use-package dired
  :ensure nil
  :custom ((dired-listing-switches "-agho --group-directories-first")))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package term
  :config
  (setq term-prompt-regexp "^[#$%>\n]*[#$%>] *"))

(use-package org
  :config
  (setq org-hide-emphasis-markers t)
  (setq org-log-done 'time)
  (setq org-startup-indented t)
  (setq org-list-allow-alphabetical t)
  (setq org-agenda-files '("~/org-notes"
			   "~/org-files"))
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
  (setq org-capture-templates
	'(("t" "Todo" entry (file+headline "~/org-files/todo.org" "Tasks")
	   "* TODO %?\n")
	  ("j" "Journal" entry (file+datetree "~/org-files/journal.org")
	   "* %?\nEntered on %U\n %i\n %a")
	  ("a" "Assignment" entry (file+headline "~/org-files/todo.org" "Assignments and tests")
	   "* TODO %?\n %i\n %a")))
  (setq org-time-stamp-custom-formats '(("%d/%m/%y %a" . "%d/%m/%y %a %H:%M")))
  :bind
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
  ("C-c s" . org-store-link))

(defun my/org-mode-visual-fill ()
  "Centre text and provide soft wrapping in org mode"
  (setq visual-fill-column-width 100)
  (setq visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . my/org-mode-visual-fill))

(use-package solaire-mode
  :config
  (solaire-mode))

(use-package night-owl-theme
  :config (load-theme 'night-owl t)
  (set-face-attribute 'font-lock-doc-face nil :foreground "#626a73" :slant 'italic))
(use-package ace-window
  :bind
  ([remap other-window] . ace-window))

(use-package treemacs
  :config
  (treemacs-indent-guide-mode)
  (setq treemacs-indent-guide-style 'line)
  (treemacs-load-theme "all-the-icons"))

(use-package treemacs-all-the-icons)

(use-package treemacs-projectile
  :after treemacs projectile)

;; ligatures
(use-package ligature
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia and Fira Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode
                        '(;; == === ==== => =| =>>=>=|=>==>> ==< =/=//=// =~
                          ;; =:= =!=
                          ("=" (rx (+ (or ">" "<" "|" "/" "~" ":" "!" "="))))
                          ;; ;; ;;;
                          (";" (rx (+ ";")))
                          ;; && &&&
                          ("&" (rx (+ "&")))
                          ;; !! !!! !. !: !!. != !== !~
                          ("!" (rx (+ (or "=" "!" "\." ":" "~"))))
                          ;; ?? ??? ?:  ?=  ?.
                          ("?" (rx (or ":" "=" "\." (+ "?"))))
                          ;; %% %%%
                          ("%" (rx (+ "%")))
                          ;; |> ||> |||> ||||> |] |} || ||| |-> ||-||
                          ;; |->>-||-<<-| |- |== ||=||
                          ;; |==>>==<<==<=>==//==/=!==:===>
                          ("|" (rx (+ (or ">" "<" "|" "/" ":" "!" "}" "\]"
                                          "-" "=" ))))
                          ;; \\ \\\ \/
                          ("\\" (rx (or "/" (+ "\\"))))
                          ;; ++ +++ ++++ +>
                          ("+" (rx (or ">" (+ "+"))))
                          ;; :: ::: :::: :> :< := :// ::=
                          (":" (rx (or ">" "<" "=" "//" ":=" (+ ":"))))
                          ;; // /// //// /\ /* /> /===:===!=//===>>==>==/
                          ("/" (rx (+ (or ">"  "<" "|" "/" "\\" "\*" ":" "!"
                                          "="))))
                          ;; .. ... .... .= .- .? ..= ..<
                          ("\." (rx (or "=" "-" "\?" "\.=" "\.<" (+ "\."))))
                          ;; -- --- ---- -~ -> ->> -| -|->-->>->--<<-|
                          ("-" (rx (+ (or ">" "<" "|" "~" "-"))))
                          ;; *> */ *)  ** *** ****
                          ("*" (rx (or ">" "/" ")" (+ "*"))))
                          ;; www wwww
                          ("w" (rx (+ "w")))
                          ;; <> <!-- <|> <: <~ <~> <~~ <+ <* <$ </  <+> <*>
                          ;; <$> </> <|  <||  <||| <|||| <- <-| <-<<-|-> <->>
                          ;; <<-> <= <=> <<==<<==>=|=>==/==//=!==:=>
                          ;; << <<< <<<<
                          ("<" (rx (+ (or "\+" "\*" "\$" "<" ">" ":" "~"  "!"
                                          "-"  "/" "|" "="))))
                          ;; >: >- >>- >--|-> >>-|-> >= >== >>== >=|=:=>>
                          ;; >> >>> >>>>
                          (">" (rx (+ (or ">" "<" "|" "/" ":" "=" "-"))))
                          ;; #: #= #! #( #? #[ #{ #_ #_( ## ### #####
                          ("#" (rx (or ":" "=" "!" "(" "\?" "\[" "{" "_(" "_"
                                       (+ "#"))))
                          ;; ~~ ~~~ ~=  ~-  ~@ ~> ~~>
                          ("~" (rx (or ">" "=" "-" "@" "~>" (+ "~"))))
                          ;; __ ___ ____ _|_ __|____|_
                          ("_" (rx (+ (or "_" "|"))))
                          ;; Fira code: 0xFF 0x12
                          ("0" (rx (and "x" (+ (in "A-F" "a-f" "0-9")))))
                          ;; Fira code:
                          "Fl"  "Tl"  "fi"  "fj"  "fl"  "ft"
                          ;; The few not covered by the regexps.
                          "{|"  "[|"  "]#"  "(*"  "}#"  "$>"  "^="))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(use-package eldoc-box)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)
			  (projects . 5)
			  (agenda . 5)))
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-week-agenda t)
  (defun random-banner (items)
    "Get a random banner image from a list"
    (let* ((size (length items))
	   (index (random size)))
      (nth index items)))
  (setq dashboard-startup-banner "~/.config/emacs/pictures/lotad.png"))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-roam
  :custom
  (org-roam-directory "~/org-notes")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 :map org-mode-map
	 ("C-M-i" . completion-at-point))
  :config (org-roam-setup))

(use-package calfw)
(use-package calfw-org)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3325e2c49c8cc81a8cc94b0d57f1975e6562858db5de840b03338529c64f58d1" "4363ac3323e57147141341a629a19f1398ea4c0b25c79a6661f20ffc44fdd2cb" "5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" "be84a2e5c70f991051d4aaf0f049fa11c172e5d784727e0b525565bb1533ec78" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098" "6f1f6a1a3cff62cc860ad6e787151b9b8599f4471d40ed746ea2819fcd184e1a" "4ade6b630ba8cbab10703b27fd05bb43aaf8a3e5ba8c2dc1ea4a2de5f8d45882" default))
 '(package-selected-packages
   '(lsp-pyright calfw-org calf-org calfw visual-fill-column visual-fill-column-mode org-roam org-bullets dashboard eldoc-box ligature treemacs-all-the-icons treemacs-projectile treemacs ayu-theme ace-window night-owl-theme solaire-mode tree-sitter-langs flycheck no-littering company rustic lsp-mode highlight-indent-guides all-the-icons helpful which-key rainbow-delimiters doom-modeline counsel ivy-rich swiper)))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
