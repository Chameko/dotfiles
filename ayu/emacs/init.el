(setq inhibit-startup-message t)
  (setq-default cursor-type 'bar)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq indent-line-function 'indent-tab)
  (tool-bar-mode -1) ; disable toolbar
  (set-fringe-mode 10) ; Some breathing mode
  (scroll-bar-mode -1) ; disable visible scrollbar
  (menu-bar-mode -1) ; disable menubar
  (set-face-attribute 'default nil :font "Fira Code Nerd Font"  :height 100) ; Setup font
  (setq visible-bell t) ; Visual bell instead of becoming deaf
  (column-number-mode) ; Column numbers
  (global-display-line-numbers-mode) ; Line numbers
  ;; Disable line nubmers for some modes
  (dolist (mode '(term-mode-hook
		  eshell-mode-hook
		  treemacs-mode))
    (add-hook mode (lambda () (
  (display-line-numbers-mode 0)
  (global-whitespace-mode 0)
))))

  (require 'whitespace) 
  (global-whitespace-mode 1)
  (setq whitespace-style '(tab-mark space-mark))

;; Initialise package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package general)

(use-package hydra)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
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
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history)))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package minions
  :config (minions-mode 1))

;; Theme
(use-package doom-themes
  :init (load-theme 'doom-ayu-dark t))

;; Icons
(use-package all-the-icons)

(defun cmyk/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . cmyk/lsp-mode-setup)
  :init
  :custom
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints t)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover nil) 
)

(use-package lsp-treemacs
  :after lsp-mode)

(use-package lsp-ivy
  :after lsp-mode)

(use-package flycheck :ensure)

(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
	 ("<tab>" . company-complete-section))
	(:map lsp-mode-map
	 ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package rustic
  :bind (:map rustic-mode-map
            ("M-j" . lsp-ui-imenu)
            ("M-?" . lsp-find-references)
            ("C-c C-c l" . flycheck-list-errors)
            ("C-c C-c a" . lsp-execute-code-action)
            ("C-c C-c r" . lsp-rename)
            ("C-c C-c q" . lsp-workspace-restart)
            ("C-c C-c Q" . lsp-workspace-shutdown)
            ("C-c C-c s" . lsp-rust-analyzer-status)))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/projects")
    (setq projectile-project-search-path '("~/projects")))
  (setq projectile-switch-project-action #'projectile-dired))


(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package org
  :config
  (setq org-ellipsis " ▾")
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
	  (sequence "IDEA(i)" "PLAN(p)" "ACTIVE(a)" "|" "MAINTAIN(m)" "CANC(k@)" "COMPLETED(c)")))

  (setq org-refile-targets
	'(("archive.org" :maxlevel . 1)))

  ;; Save all org buffers after refiling
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
	'((:startgroup)
	  ; Mutually exclusive tags here
	  (:endgroup)
	  ("@school" . ?s)
	  ("@home" . ?p)))

  (setq org-capture-templates
	'(("t" "Tasks")
	  ("tt" "Task" entry (file+olp "~/orgfiles/tasks.org" "Inbox")
	   "* TODO %?\n %U\n %a\n %i" :empty-lines 1)
	  ("p" "Projects")
	  ("pp" "Project" entry (file+olf "~/orgfiles/tasks.org" "Inbox")
	   "* IDEA %?\n %U\n" :empty-lines 1)))

  (setq org-agenda-custom-commands
	'(("d" "Dashboard"
	   ((agenda "" ((org-deadline-warning-days 7)))
	    (todo "NEXT"
		  ((org-agenda-overriding-header "Next Tasks")))
	    (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

	  ("n" "Next Tasks"
	   ((todo "NEXT"
		  ((org-agenda-overriding-header "Next Tasks")))))

	  ("h" "School Tasks" tags-todo "+school")

	  ("p" "Projects"
	   ((todo "IDEA"
		  ((org-agenda-overriding-header "Project Ideas")
		   (org-agenda-files org-agenda-files)))
	    (todo "PLAN"
		  ((org-agenda-overriding-header "Planning")
		   (org-agenda-files org-agenda-files)))
	    (todo "ACTIVE"
		  ((org-agenda-overriding-header "Active Projects")
		   (org-agenda-files org-agenda-files)))
	    (todo "MAINTAIN"
		  ((org-agenda-overriding-header "Projects Being Maintained")
		   (org-agenda-files org-agenda-files)))
	    (todo "CANC"
		  ((org-agenda-overriding-header "Canceled Projects")
		   (org-agenda-files org-agenda-files)))
	    (todo "COMPLETED"
		  ((org-agenda-overriding-header "Completed Projects")
		   (org-agenda-files org-agenda-files)))))))

  (setq org-agenda-files
	'("~/orgfiles/tasks.org"
	  "~/orgfiles/birthdays.org")))

(dolist (face '((org-level-1 . 1.2)
		(org-level-2 . 1.1)
		(org-level-3 . 1.05)
		(org-level-4 . 1.0)
		(org-level-5 . 1.1)
		(org-level-6 . 1.1)
		(org-level-7 . 1.1)
		(org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Fira Code Nerd Font" :weight 'regular :height (cdr face)))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(defun cmyk/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.config/emacs/emacs.org"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'cmyk/org-babel-tangle-config)))
